package org.crmkosanostra.crmkosanostra.service;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.response.ArticleResponse;
import org.crmkosanostra.crmkosanostra.entity.Article;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.crmkosanostra.crmkosanostra.repository.ArticleRepository;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ArticleService {

    private final ArticleRepository articleRepository;

    @Transactional(readOnly = true)
    public List<ArticleResponse> getAvailableArticles(CustomUserDetails currentUser) {
        List<Article> articles = new ArrayList<>(articleRepository.findByIsPublicTrue());

        // Если пользователь авторизован и состоит в семье — добавляем закрытые архивы его семьи
        if (currentUser != null && currentUser.getFamilyId() != null) {
            articles.addAll(articleRepository.findByIsPublicFalseAndFamilyId(currentUser.getFamilyId()));
        }

        return articles.stream()
                .map(ArticleResponse::mapToDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public ArticleResponse getArticleById(Long id, CustomUserDetails currentUser) {
        Article article = articleRepository.findById(id).orElseThrow(
                () -> new ResourceNotFoundException("Статья с этим id не была найдена")
        );

        // Проверка прав на чтение закрытого архива
        if (!article.isPublic()) {
            if (currentUser == null || currentUser.getFamilyId() == null
                    || article.getFamily() == null
                    || !currentUser.getFamilyId().equals(article.getFamily().getId())) {
                throw new AccessDeniedException("Доступ к закрытому архиву запрещен законом омерты");
            }
        }

        return ArticleResponse.mapToDto(article);
    }
}