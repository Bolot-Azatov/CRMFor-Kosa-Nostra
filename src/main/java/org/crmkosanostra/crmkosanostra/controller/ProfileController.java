package org.crmkosanostra.crmkosanostra.controller;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.response.UserResponse;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("profile")
@RequiredArgsConstructor
public class ProfileController {

    private final UserService userService;

    @GetMapping()
    private String showCurrentUserProfilePage(Model model, @AuthenticationPrincipal CustomUserDetails userDetails) {

        UserResponse user = userService.findUserById(userDetails.getUserId());

        model.addAttribute("user", user);
        return "profile/view";
    }

    @GetMapping("/{id}")
    private String showProfilePage(@PathVariable() Long id,
                                   Model model) {
        UserResponse user = userService.findUserById(id);
        model.addAttribute("user", user);

        return "profile/view";
    }
}
