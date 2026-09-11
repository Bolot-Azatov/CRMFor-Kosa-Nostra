package org.crmkosanostra.crmkosanostra.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(
        name = "family_relations",
        uniqueConstraints = {
                @UniqueConstraint(name = "uq_family_pair", columnNames = {"family_1_id", "family_2_id"})
        }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class FamilyRelation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_1_id", nullable = false)
    private Family family1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_2_id", nullable = false)
    private Family family2;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private RelationStatus status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "initiator_family_id")
    private Family initiatorFamily;
}