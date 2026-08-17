package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.response.ArticleResponse;
import org.crmkosanostra.crmkosanostra.repository.ArticleRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public List<ArticleResponse> getPublicArticles() {
        return articleRepository.findByIsPublicTrue().stream()
                .map(article -> ArticleResponse.builder()
                        .id(article.getId())
                        .title(article.getTitle())
                        .content(article.getContent())
                        .familyName(article.getFamily() != null ? article.getFamily().getName() : null)
                        .build())
                .toList();
    }
}