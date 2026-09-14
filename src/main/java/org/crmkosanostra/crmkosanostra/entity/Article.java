package org.crmkosanostra.crmkosanostra.entity;

import jakarta.persistence.*;
import lombok.*;
import org.springframework.context.i18n.LocaleContextHolder;

@Entity
@Table(name = "articles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Article {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String title;

    @Column(name = "title_en", length = 255)
    private String titleEn;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String content;

    @Column(name = "content_en", columnDefinition = "TEXT")
    private String contentEn;

    @Column(name = "is_public", nullable = false)
    private boolean isPublic;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "family_id")
    private Family family;

    public String getTitle() {
        if ("en".equalsIgnoreCase(LocaleContextHolder.getLocale().getLanguage()) && titleEn != null && !titleEn.isBlank()) {
            return titleEn;
        }
        return title;
    }

    public String getContent() {
        if ("en".equalsIgnoreCase(LocaleContextHolder.getLocale().getLanguage()) && contentEn != null && !contentEn.isBlank()) {
            return contentEn;
        }
        return content;
    }
}