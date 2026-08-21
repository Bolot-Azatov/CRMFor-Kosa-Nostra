package org.crmkosanostra.crmkosanostra.repository;

import org.crmkosanostra.crmkosanostra.entity.Family;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface FamilyRepository extends JpaRepository<Family, Long> {


    @Override
    Optional<Family> findById(Long aLong);

    Optional<Family> getFamilyByName(String name);
}
