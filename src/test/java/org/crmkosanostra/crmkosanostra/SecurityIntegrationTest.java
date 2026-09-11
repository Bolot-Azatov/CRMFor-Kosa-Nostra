// src/test/java/org/crmkosanostra/crmkosanostra/SecurityIntegrationTest.java
package org.crmkosanostra.crmkosanostra;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.csrf;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrlPattern;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class SecurityIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("Публичные статьи доступны анониму (200 OK)")
    void publicArticles_ShouldBeAccessibleForAnonymous() throws Exception {
        mockMvc.perform(get("/articles"))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("Иерархия /hierarchy закрыта для анонима (редирект на /login)")
    void hierarchy_ShouldRedirectToLogin_ForAnonymous() throws Exception {
        mockMvc.perform(get("/hierarchy"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @WithMockUser(roles = "SOLDIER")
    @DisplayName("Солдат не имеет доступа к кабинету Босса (403 Forbidden)")
    void bossEndpoints_ShouldReturn403_ForSoldier() throws Exception {
        mockMvc.perform(get("/boss/dashboard"))
                .andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "SOLDIER")
    @DisplayName("Солдат не имеет доступа к кабинету Капо (403 Forbidden)")
    void capoEndpoints_ShouldReturn403_ForSoldier() throws Exception {
        mockMvc.perform(get("/capo/business"))
                .andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "CAPO")
    @DisplayName("Капо имеет доступ к своему кабинету (200 OK)")
    void capoAccess_Allowed() throws Exception {
        mockMvc.perform(get("/capo/business"))
                .andExpect(status().isOk());
    }

    @Test
    @WithMockUser(roles = "CAPO")
    @DisplayName("POST запрос без CSRF-токена отклоняется (403 Forbidden)")
    void postWithoutCsrf_ShouldReturn403() throws Exception {
        mockMvc.perform(post("/capo/tribute")
                        .param("amount", "500.00"))
                .andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "CAPO")
    @DisplayName("POST запрос с валидным CSRF-токеном обрабатывается (302 Redirect)")
    void postWithCsrf_ShouldRedirect() throws Exception {
        mockMvc.perform(post("/capo/tribute")
                        .with(csrf())
                        .param("amount", "500.00")
                        .param("description", "Тест взноса"))
                .andExpect(status().is3xxRedirection());
    }
}