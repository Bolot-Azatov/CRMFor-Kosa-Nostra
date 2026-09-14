package org.crmkosanostra.crmkosanostra.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.request.TributeRequest;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.CapoService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/capo")
@PreAuthorize("hasAnyRole('CAPO', 'BOSS')")
@RequiredArgsConstructor
public class CapoController {

    private final CapoService capoService;

    @GetMapping("/business")
    public String showBusinessPage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        if (!model.containsAttribute("tributeRequest")) {
            model.addAttribute("tributeRequest", new TributeRequest());
        }

        try {
            model.addAttribute("business", capoService.getCapoBusiness(userDetails.getUserId()));
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
        }

        return "capo/business";
    }

    @GetMapping("/tribute")
    public String getTributePage(Model model) {
        if (!model.containsAttribute("tributeRequest")) {
            model.addAttribute("tributeRequest", new TributeRequest());
        }
        return "capo/tribute";
    }

    @PostMapping("/tribute")
    public String submitTribute(@AuthenticationPrincipal CustomUserDetails userDetails,
                                @Valid @ModelAttribute("tributeRequest") TributeRequest request,
                                BindingResult bindingResult,
                                RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.tributeRequest", bindingResult);
            redirectAttributes.addFlashAttribute("tributeRequest", request);
            return "redirect:/capo/business";
        }

        try {
            capoService.payTribute(userDetails.getUserId(), userDetails.getFamilyId(), request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.tribute.success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/capo/business";
    }
}