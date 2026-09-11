package org.crmkosanostra.crmkosanostra.dto.response;

import lombok.Builder;
import lombok.Data;
import org.crmkosanostra.crmkosanostra.entity.Article;

@Data
@Builder
public class ArticleResponse {
    private Long id;
    private String title;
    private String content;
    private String familyName;

    public static ArticleResponse mapToDto(Article article) {
        return new ArticleResponse(
                article.getId(),
                article.getTitle(),
                article.getContent(),
                article.getFamily() != null ? article.getFamily().getName() : null
        );
    }
}