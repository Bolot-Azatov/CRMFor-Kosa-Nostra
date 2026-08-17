package org.crmkosanostra.crmkosanostra.controller;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.service.ArticleService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/public")
@RequiredArgsConstructor
public class PublicController {

    private final ArticleService articleService;

    @GetMapping("/articles")
    public String getPublicArticles(Model model) {
        model.addAttribute("articles", articleService.getPublicArticles());
        return "public/articles";
    }
}