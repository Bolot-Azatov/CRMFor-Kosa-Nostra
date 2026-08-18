package org.crmkosanostra.crmkosanostra.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.BossDto;
import org.crmkosanostra.crmkosanostra.entity.*;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BusinessLogicException;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BossService {

    private final UserRepository userRepository;
    private final FamilyRepository familyRepository;
    private final BusinessRepository businessRepository;
    private final FinancialLedgerRepository ledgerRepository;
    private final MessageRepository messageRepository;
    private final FamilyRelationRepository relationRepository;

    @Transactional(readOnly = true)
    public User getBossById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Пользователь с ID " + id + " не найден"));

        if (user.getRole() != Role.BOSS) {
            throw new IllegalArgumentException("Пользователь с ID " + id + " не является Боссом");
        }

        return user;
    }

    // --- 1. Управление кадрами ---
    @Transactional
    public void assignRole(User boss, BossDto.AssignRoleRequest request) {
        User targetUser = userRepository.findById(request.userId())
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        // Проверка: пользователь должен принадлежать семье Босса
        if (!targetUser.getFamily().getId().equals(boss.getFamily().getId())) {
            throw new BusinessLogicException("Cannot change role for member of another family");
        }

        // Запрет назначения ролей ANONYMOUS и BOSS через данный эндпоинт
        if (request.newRole() == Role.BOSS || request.newRole() == Role.ANONYMOUS) {
            throw new BusinessLogicException("Invalid role assignment target");
        }

        // Ограничение: Ровно 1 COUNSELOR на семью
        if (request.newRole() == Role.COUNSELOR) {
            boolean counselorExists = userRepository.existsByFamilyIdAndRole(
                    boss.getFamily().getId(), Role.COUNSELOR);
            if (counselorExists && targetUser.getRole() != Role.COUNSELOR) {
                throw new BusinessLogicException("Family already has a Counselor");
            }
        }

        targetUser.setRole(request.newRole());
        userRepository.save(targetUser);
    }

    // --- 2. Просмотр бизнесов и финансового журнала семьи ---
    @Transactional(readOnly = true)
    public List<Business> getFamilyBusinesses(User boss) {
        return businessRepository.findByFamilyId(boss.getFamily().getId());
    }

    @Transactional(readOnly = true)
    public List<FinancialLedger> getFamilyLedger(User boss) {
        return ledgerRepository.findByFamilyIdOrderByContributedAtDesc(boss.getFamily().getId());
    }

    // --- 3. Инвестиции из общака ---
    @Transactional
    public Family investFromTreasury(User boss, BossDto.InvestRequest request) {
        Family family = boss.getFamily();

        if (family.getTreasuryBalance().compareTo(request.amount()) < 0) {
            throw new BusinessLogicException("Insufficient funds in family treasury");
        }

        // Списание средств
        family.setTreasuryBalance(family.getTreasuryBalance().subtract(request.amount()));

        // Логирование операции в финансовом журнале (расход обозначается отрицательной суммой)
        FinancialLedger entry = FinancialLedger.builder()
                .family(family)
                .capo(boss) // Запись оформляется от имени Босса
                .amount(request.amount().negate())
                .contributedAt(LocalDateTime.now())
                .description("INVESTMENT: " + request.description())
                .build();

        ledgerRepository.save(entry);
        return familyRepository.save(family);
    }

    // --- 4. Дипломатия ---
    @Transactional
    public void declareWar(User boss, BossDto.DiplomacyRequest request) {
        changeRelationStatus(boss, request.targetFamilyId(), RelationStatus.WAR);
    }

    @Transactional
    public void proposePeace(User boss, BossDto.DiplomacyRequest request) {
        changeRelationStatus(boss, request.targetFamilyId(), RelationStatus.PENDING_PEACE);
    }

    @Transactional
    public void acceptPeace(User boss, BossDto.DiplomacyRequest request) {
        FamilyRelation relation = relationRepository.findRelationBetween(
                        boss.getFamily().getId(), request.targetFamilyId())
                .orElseThrow(() -> new ResourceNotFoundException("Relation not found"));

        if (relation.getStatus() != RelationStatus.PENDING_PEACE) {
            throw new BusinessLogicException("There is no pending peace proposal from this family");
        }

        relation.setStatus(RelationStatus.PEACE);
        relationRepository.save(relation);
    }

    private void changeRelationStatus(User boss, Long targetFamilyId, RelationStatus newStatus) {
        if (boss.getFamily().getId().equals(targetFamilyId)) {
            throw new BusinessLogicException("Cannot change relations with your own family");
        }

        Family targetFamily = familyRepository.findById(targetFamilyId)
                .orElseThrow(() -> new ResourceNotFoundException("Target family not found"));

        FamilyRelation relation = relationRepository.findRelationBetween(
                        boss.getFamily().getId(), targetFamilyId)
                .orElseGet(() -> FamilyRelation.builder()
                        .family1(boss.getFamily())
                        .family2(targetFamily)
                        .build());

        relation.setStatus(newStatus);
        relationRepository.save(relation);
    }

    // --- 5. Почта Босса ---
    @Transactional
    public Message sendMessage(User boss, BossDto.BossMessageRequest request) {
        User recipient = userRepository.findById(request.recipientId())
                .orElseThrow(() -> new ResourceNotFoundException("Recipient not found"));

        if (boss.getId().equals(recipient.getId())) {
            throw new BusinessLogicException("Cannot send messages to yourself");
        }

        // Проверка допустимых адресатов для Босса:
        // 1. Капо или Консильери своей семьи
        // 2. Босс другой семьи
        boolean isOwnFamilyMember = recipient.getFamily().getId().equals(boss.getFamily().getId());
        boolean isAllowedSubordinate = isOwnFamilyMember &&
                (recipient.getRole() == Role.CAPO || recipient.getRole() == Role.COUNSELOR);
        boolean isOtherFamilyBoss = !isOwnFamilyMember && recipient.getRole() == Role.BOSS;

        if (!isAllowedSubordinate && !isOtherFamilyBoss) {
            throw new BusinessLogicException("Boss can only text their Capos, Counselor, or Bosses of other families");
        }

        Message message = Message.builder()
                .sender(boss)
                .recipient(recipient)
                .subject(request.subject())
                .body(request.body())
                .sentAt(LocalDateTime.now())
                .build();

        return messageRepository.save(message);
    }
}