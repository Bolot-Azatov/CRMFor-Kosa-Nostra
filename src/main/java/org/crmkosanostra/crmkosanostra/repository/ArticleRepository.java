package org.crmkosanostra.crmkosanostra.repository;

import org.crmkosanostra.crmkosanostra.entity.Article;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ArticleRepository extends JpaRepository<Article, Long> {

    List<Article> findByIsPublicTrue();

    List<Article> findByIsPublicFalseAndFamilyId(Long familyId);
}
