package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.BusinessDto;
import org.crmkosanostra.crmkosanostra.dto.request.TributeRequest;
import org.crmkosanostra.crmkosanostra.entity.Business;
import org.crmkosanostra.crmkosanostra.entity.Family;
import org.crmkosanostra.crmkosanostra.entity.FinancialLedger;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.BusinessRepository;
import org.crmkosanostra.crmkosanostra.repository.FamilyRepository;
import org.crmkosanostra.crmkosanostra.repository.FinancialLedgerRepository;
import org.crmkosanostra.crmkosanostra.repository.UserRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class CapoService {

    private static final BigDecimal FAMILY_CUT_PERCENT = new BigDecimal("0.80");

    private final BusinessRepository businessRepository;
    private final FamilyRepository familyRepository;
    private final FinancialLedgerRepository ledgerRepository;
    private final UserRepository userRepository;

    @Transactional(readOnly = true)
    public BusinessDto getCapoBusiness(Long capoId) {
        Business business = businessRepository.findByCapoId(capoId)
                .orElseThrow(() -> new IllegalArgumentException("За вами не закреплен ни один бизнес"));

        return BusinessDto.builder()
                .id(business.getId())
                .name(business.getName())
                .type(business.getType())
                .weeklyRevenue(business.getWeeklyRevenue())
                .build();
    }

    @Transactional
    public void payTribute(Long capoId, Long familyId, TributeRequest request) {
        User capo = userRepository.findById(capoId)
                .orElseThrow(() -> new IllegalArgumentException("Пользователь не найден"));

        Business business = businessRepository.findByCapoId(capoId)
                .orElseThrow(() -> new IllegalArgumentException("У вас нет бизнеса для сдачи выручки"));

        Family family = familyRepository.findById(familyId)
                .orElseThrow(() -> new IllegalArgumentException("Семья не найдена"));

        // Расчет доли семьи (80% от внесенной суммы)
        BigDecimal familyCut = request.getAmount()
                .multiply(FAMILY_CUT_PERCENT)
                .setScale(2, RoundingMode.HALF_UP);

        // Пополнение общака семьи
        family.setTreasuryBalance(family.getTreasuryBalance().add(familyCut));
        familyRepository.save(family);

        // Фиксация транзакции в журнале доходов
        FinancialLedger entry = new FinancialLedger();
        entry.setFamily(family);
        entry.setCapo(capo);
        entry.setAmount(familyCut);
        entry.setContributedAt(LocalDateTime.now());
        entry.setDescription(request.getDescription() != null && !request.getDescription().isBlank()
                ? request.getDescription()
                : "Еженедельный взнос с бизнеса: " + business.getName());

        ledgerRepository.save(entry);
    }
}