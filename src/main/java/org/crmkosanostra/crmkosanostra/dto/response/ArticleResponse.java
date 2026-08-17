package org.crmkosanostra.crmkosanostra.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ArticleResponse {
    private Long id;
    private String title;
    private String content;
    private String familyName;
}