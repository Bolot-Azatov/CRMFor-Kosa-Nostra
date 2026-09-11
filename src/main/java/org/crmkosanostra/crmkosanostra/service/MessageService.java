package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.entity.Message;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BusinessLogicException;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.MessageRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MessageService {

    private final MessageRepository messageRepository;

    @Transactional
    public Message readMessage(Long messageId, Long currentUserId) {

        Message message = messageRepository.findById(messageId)
                .orElseThrow(() -> new ResourceNotFoundException("Сообщение не найдено"));

        if (!message.getRecipient().getId().equals(currentUserId) && !message.getSender().getId().equals(currentUserId)) {
            throw new BusinessLogicException("Доступ к чужой переписке запрещен законом омерты");
        }

        if (message.getRecipient().getId().equals(currentUserId) && !message.isRead()) {
            message.setRead(true);
            messageRepository.save(message);
        }

        return message;
    }
}
