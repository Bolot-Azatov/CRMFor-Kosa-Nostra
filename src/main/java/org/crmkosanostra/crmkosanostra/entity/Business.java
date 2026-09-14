package org.crmkosanostra.crmkosanostra.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.context.i18n.LocaleContextHolder;

import java.math.BigDecimal;

@Entity
@Table(name = "businesses")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Business {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 150)
    private String name;

    @Column(nullable = false, length = 100)
    private String type;

    @Column(name = "type_ru", length = 100)
    private String typeRu;

    @Column(name = "weekly_revenue", nullable = false, precision = 15, scale = 2)
    private BigDecimal weeklyRevenue;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "capo_id", unique = true)
    private User capo;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id", nullable = false)
    private Family family;

    public String getType() {
        if ("ru".equalsIgnoreCase(LocaleContextHolder.getLocale().getLanguage()) && typeRu != null && !typeRu.isBlank()) {
            return typeRu;
        }
        return type;
    }
}