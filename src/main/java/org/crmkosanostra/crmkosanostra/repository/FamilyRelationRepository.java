package org.crmkosanostra.crmkosanostra.repository;

import org.crmkosanostra.crmkosanostra.entity.FamilyRelation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface FamilyRelationRepository extends JpaRepository<FamilyRelation, Long> {

    @Query("SELECT fr FROM FamilyRelation fr WHERE " +
            "(fr.family1.id = :f1 AND fr.family2.id = :f2) OR " +
            "(fr.family1.id = :f2 AND fr.family2.id = :f1)")
    Optional<FamilyRelation> findRelationBetween(@Param("f1") Long family1Id, @Param("f2") Long family2Id);

    @Query("SELECT fr FROM FamilyRelation fr WHERE fr.family1.id = :fId OR fr.family2.id = :fId")
    List<FamilyRelation> findAllByFamilyId(@Param("fId") Long familyId);
}
