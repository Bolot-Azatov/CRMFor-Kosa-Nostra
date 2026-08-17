package org.crmkosanostra.crmkosanostra.controller;

import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.HierarchyService;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/hierarchy")
@RequiredArgsConstructor
public class HierarchyController {

    private final HierarchyService hierarchyService;

    @GetMapping
    public String getMyFamilyHierarchy(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        Long familyId = userDetails.getFamilyId();

        model.addAttribute("hierarchy", hierarchyService.getFamilyHierarchy(familyId));
        return "hierarchy/my-family";
    }

    @GetMapping("/{familyId}")
    public String getFamilyHierarchyById(@PathVariable Long familyId, Model model) {
        model.addAttribute("hierarchy", hierarchyService.getFamilyHierarchy(familyId));
        return "hierarchy/other-family";
    }
}