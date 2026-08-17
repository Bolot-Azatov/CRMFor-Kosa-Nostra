package org.crmkosanostra.crmkosanostra.repository;

import org.crmkosanostra.crmkosanostra.entity.FinancialLedger;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FinancialLedgerRepository extends JpaRepository<FinancialLedger, Long> {

    List<FinancialLedger> findByFamilyIdOrderByContributedAtDesc(Long familyId);
}
