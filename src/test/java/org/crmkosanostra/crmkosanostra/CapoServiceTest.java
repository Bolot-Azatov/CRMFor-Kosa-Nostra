package org.crmkosanostra.crmkosanostra;

import org.crmkosanostra.crmkosanostra.dto.request.TributeRequest;
import org.crmkosanostra.crmkosanostra.entity.*;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BusinessLogicException;
import org.crmkosanostra.crmkosanostra.repository.BusinessRepository;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.crmkosanostra.crmkosanostra.repository.FinancialLedgerRepository;
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

    @InjectMocks private CapoService capoService;

    @Test
    @DisplayName("Успешный взнос в общак: пополнение баланса семьи и запись в журнал")
    void contributeTribute_Success() {
        Family family = Family.builder().id(1L).treasuryBalance(new BigDecimal("1000")).build();
        User capo = User.builder().id(2L).role(Role.CAPO).family(family).build();
        Business business = Business.builder().id(10L).family(family).capo(capo).build();

        when(businessRepository.findByCapoId(capo.getId())).thenReturn(Optional.of(business));

        TributeRequest tributeRequest = new TributeRequest();
        tributeRequest.setAmount(new BigDecimal("500"));
        tributeRequest.setDescription("test");

        capoService.payTribute(capo.getId(), family.getId(), tributeRequest);

        assertEquals(new BigDecimal("1500"), family.getTreasuryBalance());
        verify(familyRepository, times(1)).save(family);
        verify(ledgerRepository, times(1)).save(any(FinancialLedger.class));
    }

    @Test
    @DisplayName("Ошибка при попытке сдать деньги, если за Капо не закреплен бизнес")
    void contributeTribute_ShouldThrow_WhenNoBusinessAssigned() {
        User capo = User.builder().id(2L).role(Role.CAPO).build();
        Family family = Family.builder().id(1L).treasuryBalance(new BigDecimal("1000")).build();

        TributeRequest tributeRequest = new TributeRequest();
        tributeRequest.setAmount(new BigDecimal("500"));
        tributeRequest.setDescription("test");

        when(businessRepository.findByCapoId(capo.getId())).thenReturn(Optional.empty());

        assertThrows(BusinessLogicException.class,
                () -> capoService.payTribute(capo.getId(), family.getId(), tributeRequest));
    }
}