package org.crmkosanostra.crmkosanostra.repository;

import org.crmkosanostra.crmkosanostra.entity.Role;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);

    List<User> findByFamilyId(Long familyId);

    Optional<User> findByFamilyIdAndRole(Long familyId, Role role);

    boolean existsByFamilyIdAndRole(Long familyId, Role role);
}