package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.LedgerItemDto;
import org.crmkosanostra.crmkosanostra.dto.request.MessageRequest;
import org.crmkosanostra.crmkosanostra.entity.Message;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.FinancialLedgerRepository;
import org.crmkosanostra.crmkosanostra.repository.MessageRepository;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ConsigliereService {

    private final FinancialLedgerRepository ledgerRepository;
    private final MessageRepository messageRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public List<LedgerItemDto> getFamilyLedger(Long familyId) {
        return ledgerRepository.findByFamilyIdOrderByContributedAtDesc(familyId).stream()
                .map(item -> LedgerItemDto.builder()
                        .id(item.getId())
                        .capoUsername(item.getCapo().getUsername())
                        .amount(item.getAmount())
                        .contributedAt(item.getContributedAt())
                        .description(item.getDescription())
                        .build())
                .toList();
    }

    @Transactional
    public void sendMessageToBoss(Long senderId, Long familyId, MessageRequest request) {
        User sender = userRepository.findById(senderId)
                .orElseThrow(() -> new IllegalArgumentException("Отправитель не найден"));

        User boss = userRepository.findByFamilyIdAndRole(familyId, Role.BOSS)
                .orElseThrow(() -> new IllegalStateException("В вашей семье еще не назначен Босс"));

        Message message = new Message();
        message.setSender(sender);
        message.setRecipient(boss);
        message.setSubject(request.getSubject());
        message.setBody(request.getBody());
        message.setSentAt(LocalDateTime.now());

        messageRepository.save(message);
    }
}