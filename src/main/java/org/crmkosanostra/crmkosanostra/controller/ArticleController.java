package org.crmkosanostra.crmkosanostra.controller;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.service.ArticleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/articles")
@RequiredArgsConstructor
public class ArticleController {

    private final ArticleService articleService;

    @GetMapping()
    public String getPublicArticles(Model model) {
        model.addAttribute("articles", articleService.getPublicArticles());
        return "public/articles";
    }

    @GetMapping("/{id}")
    public String getArticle(@PathVariable Long id, Model model) {

        model.addAttribute("article", articleService.getArticleById(id));
        return "public/article";
    }
}