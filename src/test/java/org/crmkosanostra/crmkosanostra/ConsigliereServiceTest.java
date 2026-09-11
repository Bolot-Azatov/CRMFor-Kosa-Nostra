package org.crmkosanostra.crmkosanostra;

import org.crmkosanostra.crmkosanostra.dto.request.MessageRequest;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.entity.Message;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.FinancialLedgerRepository;
import org.crmkosanostra.crmkosanostra.repository.MessageRepository;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.crmkosanostra.crmkosanostra.service.ConsigliereService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class ConsigliereServiceTest {

    @Mock private FinancialLedgerRepository ledgerRepository;
    @Mock private MessageRepository messageRepository;
    @Mock private UserRepository userRepository;

    @InjectMocks private ConsigliereService consigliereService;

    @Test
    @DisplayName("Успешная отправка зашифрованного сообщения Боссу семьи")
    void sendMessageToBoss_Success() {
        Family family = Family.builder().id(1L).name("Gambino").build();
        User consigliere = User.builder().id(2L).username("consig").role(Role.CONSIGLIERE).family(family).build();
        User boss = User.builder().id(1L).username("boss").role(Role.BOSS).family(family).build();

        when(userRepository.findById(2L)).thenReturn(Optional.of(consigliere));
        when(userRepository.findByFamilyIdAndRole(1L, Role.BOSS)).thenReturn(Optional.of(boss));

        MessageRequest req = new MessageRequest();
        req.setSubject("Предательство");
        req.setBody("Капо что-то скрывает...");

        consigliereService.sendMessageToBoss(2L, 1L, req);

        verify(messageRepository, times(1)).save(any(Message.class));
    }

    @Test
    @DisplayName("Ошибка отправки, если в семье отсутствует назначенный Босс")
    void sendMessageToBoss_ShouldThrow_WhenNoBoss() {
        User consigliere = User.builder().id(2L).role(Role.CONSIGLIERE).build();

        when(userRepository.findById(2L)).thenReturn(Optional.of(consigliere));
        when(userRepository.findByFamilyIdAndRole(1L, Role.BOSS)).thenReturn(Optional.empty());

        MessageRequest req = new MessageRequest();
        req.setSubject("Доклад");
        req.setBody("Текст");

        assertThrows(IllegalStateException.class, () -> consigliereService.sendMessageToBoss(2L, 1L, req));
    }
}