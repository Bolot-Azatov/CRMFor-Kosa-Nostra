package org.crmkosanostra.crmkosanostra;

import org.crmkosanostra.crmkosanostra.dto.request.TributeRequest;
import org.crmkosanostra.crmkosanostra.entity.*;
import org.crmkosanostra.crmkosanostra.repository.BusinessRepository;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.crmkosanostra.crmkosanostra.repository.FinancialLedgerRepository;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.crmkosanostra.crmkosanostra.service.CapoService;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;

import java.math.BigDecimal;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class CapoServiceTest {

    @Mock private BusinessRepository businessRepository;
    @Mock private FamilyRepository familyRepository;
    @Mock private FinancialLedgerRepository ledgerRepository;
    @Mock private UserRepository userRepository;

    @InjectMocks private CapoService capoService;

    @Test
    @DisplayName("Успешный взнос в общак: пополнение баланса семьи (80%) и запись в журнал")
    void contributeTribute_Success() {
        Family family = Family.builder().id(1L).treasuryBalance(new BigDecimal("1000.00")).build();
        User capo = User.builder().id(2L).role(Role.CAPO).family(family).build();
        Business business = Business.builder().id(10L).name("Docks").family(family).capo(capo).build();

        when(userRepository.findById(capo.getId())).thenReturn(Optional.of(capo));
        when(businessRepository.findByCapoId(capo.getId())).thenReturn(Optional.of(business));
        when(familyRepository.findById(family.getId())).thenReturn(Optional.of(family));

        TributeRequest tributeRequest = new TributeRequest();
        tributeRequest.setAmount(new BigDecimal("500.00"));
        tributeRequest.setDescription("test");

        capoService.payTribute(capo.getId(), family.getId(), tributeRequest);

        // 1000 + (500 * 0.80) = 1400.00
        assertEquals(new BigDecimal("1400.00"), family.getTreasuryBalance());
        verify(familyRepository, times(1)).save(family);
        verify(ledgerRepository, times(1)).save(any(FinancialLedger.class));
    }

    @Test
    @DisplayName("Ошибка при попытке сдать деньги, если за Капо не закреплен бизнес")
    void contributeTribute_ShouldThrow_WhenNoBusinessAssigned() {
        User capo = User.builder().id(2L).role(Role.CAPO).build();
        Family family = Family.builder().id(1L).treasuryBalance(new BigDecimal("1000.00")).build();

        when(userRepository.findById(capo.getId())).thenReturn(Optional.of(capo));
        when(businessRepository.findByCapoId(capo.getId())).thenReturn(Optional.empty());

        TributeRequest tributeRequest = new TributeRequest();
        tributeRequest.setAmount(new BigDecimal("500.00"));
        tributeRequest.setDescription("test");

        assertThrows(IllegalArgumentException.class,
                () -> capoService.payTribute(capo.getId(), family.getId(), tributeRequest));
    }
}