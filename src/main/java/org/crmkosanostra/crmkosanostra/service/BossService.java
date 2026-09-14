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

import java.math.BigDecimal;
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

        if (request.userId() == null || request.userId() <= 0) {
            throw new BusinessLogicException("ID бойца должен быть положительным числом больше нуля");
        }

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
        if (request.newRole() == Role.CONSIGLIERE) {
            boolean counselorExists = userRepository.existsByFamilyIdAndRole(
                    boss.getFamily().getId(), Role.CONSIGLIERE);
            if (counselorExists && targetUser.getRole() != Role.CONSIGLIERE) {
                throw new BusinessLogicException("Family already has a Consigliere");
            }
        }

        if (targetUser.getRole() == Role.CAPO && request.newRole() != Role.CAPO) {
            businessRepository.findByCapoId(targetUser.getId()).ifPresent(b -> {
                b.setCapo(null);
                businessRepository.save(b);
            });
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

        if (request.amount() == null || request.amount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new BusinessLogicException("Сумма инвестиции должна быть строго больше нуля");
        }

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
        changeRelationStatus(boss, request.targetFamilyId(), RelationStatus.WAR, null);
    }

    @Transactional
    public void proposePeace(User boss, BossDto.DiplomacyRequest request) {
        FamilyRelation relation = relationRepository.findRelationBetween(boss.getFamily().getId(), request.targetFamilyId())
                .orElseThrow(() -> new ResourceNotFoundException("Дипломатические отношения не найдены"));

        if (relation.getStatus() == RelationStatus.PEACE) {
            throw new BusinessLogicException("С этой семьей уже заключен мир");
        }

        if (relation.getStatus() == RelationStatus.PENDING_PEACE) {
            throw new BusinessLogicException("Запрос на перемирие уже отправлен");
        }

        changeRelationStatus(boss, request.targetFamilyId(), RelationStatus.PENDING_PEACE, boss.getFamily());
    }

    @Transactional
    public void acceptPeace(User boss, BossDto.DiplomacyRequest request) {
        FamilyRelation relation = relationRepository.findRelationBetween(
                        boss.getFamily().getId(), request.targetFamilyId())
                .orElseThrow(() -> new ResourceNotFoundException("Отношения между семьями не найдены"));

        if (relation.getStatus() != RelationStatus.PENDING_PEACE) {
            throw new BusinessLogicException("С этой семьей нет активного запроса на мир");
        }

        // Защита от принятия собственного мира
        if (relation.getInitiatorFamily() != null
                && relation.getInitiatorFamily().getId().equals(boss.getFamily().getId())) {
            throw new BusinessLogicException("Вы не можете принять собственное предложение о мире. Ожидайте ответа Дона другой семьи.");
        }

        relation.setStatus(RelationStatus.PEACE);
        relation.setInitiatorFamily(null);
        relationRepository.save(relation);
    }

    private void changeRelationStatus(User boss, Long targetFamilyId, RelationStatus newStatus, Family initiator) {
        if (boss.getFamily().getId().equals(targetFamilyId)) {
            throw new BusinessLogicException("Нельзя изменять дипломатический статус с собственной семьей");
        }

        Long min = Math.min(boss.getFamily().getId(), targetFamilyId);
        Long max = Math.max(boss.getFamily().getId(), targetFamilyId);

        Family minIdFamily = familyRepository.findById(min).orElseThrow(
                () -> new ResourceNotFoundException("Целевая семья не найдена")
        );

        Family maxIdFamily = familyRepository.findById(max).orElseThrow(
                () -> new ResourceNotFoundException("Целевая семья не найдена")
        );

        FamilyRelation relation = relationRepository.findRelationBetween(boss.getFamily().getId(), targetFamilyId)
                .orElseGet(() -> FamilyRelation.builder()
                        .family1(minIdFamily)
                        .family2(maxIdFamily)
                        .build());

        relation.setStatus(newStatus);
        relation.setInitiatorFamily(initiator);
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
        boolean isOwnFamilyMember = recipient.getFamily() != null
                && boss.getFamily() != null
                && recipient.getFamily().getId().equals(boss.getFamily().getId());

        boolean isAllowedSubordinate = isOwnFamilyMember &&
                (recipient.getRole() == Role.CAPO || recipient.getRole() == Role.CONSIGLIERE);
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

    // Добавить в src/main/java/org/crmkosanostra/crmkosanostra/service/BossService.java

    // Закрепление бизнеса за Капо (1 Капо = 1 бизнес)
    @Transactional
    public void assignBusinessToCapo(User boss, BossDto.AssignBusinessRequest request) {
        Business business = businessRepository.findById(request.businessId())
                .orElseThrow(() -> new ResourceNotFoundException("Предприятие не найдено"));

        if (!business.getFamily().getId().equals(boss.getFamily().getId())) {
            throw new BusinessLogicException("Нельзя распоряжаться предприятиями чужой семьи");
        }

        User capo = userRepository.findById(request.capoId())
                .orElseThrow(() -> new ResourceNotFoundException("Капо не найден"));

        if (!capo.getFamily().getId().equals(boss.getFamily().getId())) {
            throw new BusinessLogicException("Капо должен принадлежать вашей семье");
        }

        if (capo.getRole() != Role.CAPO) {
            throw new BusinessLogicException("Предприятие может быть закреплено только за членом семьи в ранге CAPO");
        }

        // Если за данным Капо уже числился другой бизнес, отвязываем его
        businessRepository.findByCapoId(capo.getId()).ifPresent(oldBiz -> {
            if (!oldBiz.getId().equals(business.getId())) {
                oldBiz.setCapo(null);
                businessRepository.save(oldBiz);
            }
        });

        business.setCapo(capo);
        businessRepository.save(business);
    }

    @Transactional(readOnly = true)
    public List<User> getFamilyCapos(User boss) {
        return userRepository.findByFamilyId(boss.getFamily().getId()).stream()
                .filter(u -> u.getRole() == Role.CAPO)
                .toList();
    }

    @Transactional(readOnly = true)
    public List<User> getFamilyMembers(User boss) {
        return userRepository.findByFamilyId(boss.getFamily().getId());
    }

    @Transactional(readOnly = true)
    public List<FamilyRelation> getFamilyRelations(User boss) {
        return relationRepository.findAllByFamilyId(boss.getFamily().getId());
    }

    @Transactional(readOnly = true)
    public List<User> getAllowedRecipientsForBoss(User boss) {
        Long bossFamilyId = boss.getFamily().getId();

        // 1. Капо и Консильери своей семьи
        List<User> ownSubordinates = userRepository.findByFamilyId(bossFamilyId).stream()
                .filter(u -> u.getRole() == Role.CAPO || u.getRole() == Role.CONSIGLIERE)
                .toList();

        // 2. Боссы других семей
        List<User> otherBosses = userRepository.findAll().stream()
                .filter(u -> u.getRole() == Role.BOSS && (u.getFamily() == null || !u.getFamily().getId().equals(bossFamilyId)))
                .toList();

        List<User> recipients = new java.util.ArrayList<>(ownSubordinates);
        recipients.addAll(otherBosses);
        return recipients;
    }
}