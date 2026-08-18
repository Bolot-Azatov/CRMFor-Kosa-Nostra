package org.crmkosanostra.crmkosanostra;

import org.crmkosanostra.crmkosanostra.dto.BossDto;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BusinessLogicException;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.crmkosanostra.crmkosanostra.service.BossService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class BossServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private BossService bossService;

    @Test
    @DisplayName("Ошибка при попытке назначить второго Консильери на семью")
    void assignRole_ShouldThrowException_WhenCounselorAlreadyExists() {
        Family family = new Family();
        family.setId(1L);

        User boss = new User();
        boss.setFamily(family);

        User soldier = new User();
        soldier.setId(2L);
        soldier.setFamily(family);
        soldier.setRole(Role.SOLDIER);

        when(userRepository.findById(2L)).thenReturn(Optional.of(soldier));
        when(userRepository.existsByFamilyIdAndRole(1L, Role.COUNSELOR)).thenReturn(true);

        BossDto.AssignRoleRequest request = new BossDto.AssignRoleRequest(2L, Role.COUNSELOR);

        assertThrows(BusinessLogicException.class, () -> bossService.assignRole(boss, request));
    }

    @Test
    @DisplayName("Ошибка при попытке Босса отправить письмо рядовому Солдату")
    void sendMessage_ShouldThrowException_WhenRecipientIsSoldier() {
        Family family = Family.builder().id(1L).build();
        User boss = User.builder().id(1L).role(Role.BOSS).family(family).build();
        User soldier = User.builder().id(3L).role(Role.SOLDIER).family(family).build();

        when(userRepository.findById(3L)).thenReturn(Optional.of(soldier));

        BossDto.BossMessageRequest request = new BossDto.BossMessageRequest(3L, "Привет", "Текст");

        assertThrows(BusinessLogicException.class, () -> bossService.sendMessage(boss, request));
    }
}