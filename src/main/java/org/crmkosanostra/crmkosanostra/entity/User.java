package org.crmkosanostra.crmkosanostra.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.context.i18n.LocaleContextHolder;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false)
    private String username;

    @Column(name = "password_hash", nullable = false)
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id")
    private Family family;

    @Column(name = "photo_url")
    private String photoUrl;

    @Column(columnDefinition = "TEXT")
    private String bio;

    @Column(name = "bio_en", columnDefinition = "TEXT")
    private String bioEn;

    public String getBio() {
        if ("en".equalsIgnoreCase(LocaleContextHolder.getLocale().getLanguage()) && bioEn != null && !bioEn.isBlank()) {
            return bioEn;
        }
        return bio;
    }
}