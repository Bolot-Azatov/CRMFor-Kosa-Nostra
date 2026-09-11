package org.crmkosanostra.crmkosanostra;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
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
    @DisplayName("Иерархия закрыта для анонима (редирект на /login)")
    void hierarchy_ShouldRedirectToLogin_ForAnonymous() throws Exception {
        mockMvc.perform(get("/family"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test
    @WithMockUser(roles = "SOLDIER")
    @DisplayName("Солдат не имеет доступа к кабинету Босса (403 Forbidden)")
    void bossEndpoints_ShouldReturn403_ForSoldier() throws Exception {
        mockMvc.perform(get("/boss"))
                .andExpect(status().isForbidden());
    }

    @Test
    @WithMockUser(roles = "CAPO")
    @DisplayName("Капо имеет доступ к своему кабинету (200 OK)")
    void capoAccess_Allowed() throws Exception {
        mockMvc.perform(get("/capo/business"))
                .andExpect(status().isOk());
    }
}