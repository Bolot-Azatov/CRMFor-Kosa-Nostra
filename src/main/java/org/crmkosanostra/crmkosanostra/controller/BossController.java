package org.crmkosanostra.crmkosanostra.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.BossDto;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails; // Проверьте правильность пакета CustomUserDetails
import org.crmkosanostra.crmkosanostra.service.BossService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/boss")
@RequiredArgsConstructor
@PreAuthorize("hasRole('BOSS')")
public class BossController {

    private final BossService bossService;

    // Главная страница панели управления Босса (Dashboard)
    @GetMapping
    public String dashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());

        model.addAttribute("boss", boss);
        model.addAttribute("family", boss.getFamily());
        model.addAttribute("businesses", bossService.getFamilyBusinesses(boss));
        model.addAttribute("ledger", bossService.getFamilyLedger(boss));

        if (!model.containsAttribute("assignRoleRequest")) {
            model.addAttribute("assignRoleRequest", new BossDto.AssignRoleRequest(null, null));
        }
        if (!model.containsAttribute("investRequest")) {
            model.addAttribute("investRequest", new BossDto.InvestRequest(null, null));
        }
        if (!model.containsAttribute("diplomacyRequest")) {
            model.addAttribute("diplomacyRequest", new BossDto.DiplomacyRequest(null));
        }
        if (!model.containsAttribute("messageRequest")) {
            model.addAttribute("messageRequest", new BossDto.BossMessageRequest(null, null, null));
        }

        return "boss/dashboard";
    }

    // Просмотр бизнесов
    @GetMapping("/businesses")
    public String getFamilyBusinesses(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("businesses", bossService.getFamilyBusinesses(boss));
        return "boss/businesses";
    }

    // Просмотр журнала доходов
    @GetMapping("/ledger")
    public String getFamilyLedger(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("ledger", bossService.getFamilyLedger(boss));
        return "boss/ledger";
    }

    // Назначение роли
    @PostMapping("/members/assign-role")
    public String assignRole(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("assignRoleRequest") BossDto.AssignRoleRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.assignRoleRequest", bindingResult);
            redirectAttributes.addFlashAttribute("assignRoleRequest", request);
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.assignRole(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Роль успешно обновлена");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    // Инвестиции из общака
    @PostMapping("/treasury/invest")
    public String investFromTreasury(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("investRequest") BossDto.InvestRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.investRequest", bindingResult);
            redirectAttributes.addFlashAttribute("investRequest", request);
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.investFromTreasury(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Инвестиция успешно выполнена");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    // Объявление войны
    @PostMapping("/diplomacy/declare-war")
    public String declareWar(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Неверно указан ID семьи");
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.declareWar(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Война успешно объявлена!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    // Предложение мира
    @PostMapping("/diplomacy/propose-peace")
    public String proposePeace(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Неверно указан ID семьи");
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.proposePeace(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Предложение о мире отправлено");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    // Принятие мира
    @PostMapping("/diplomacy/accept-peace")
    public String acceptPeace(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Неверно указан ID семьи");
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.acceptPeace(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Мирный договор принят");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    @GetMapping("/messages/new")
    public String getMessageSendForm(Model model) {
        return "boss/message_new";
    }

    // Отправка сообщений
    @PostMapping("/messages")
    public String sendMessage(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("messageRequest") BossDto.BossMessageRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.messageRequest", bindingResult);
            redirectAttributes.addFlashAttribute("messageRequest", request);
            return "redirect:/boss";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.sendMessage(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "Сообщение отправлено");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss";
    }

    @PostMapping("/businesses/assign")
    public String assignBusiness(@AuthenticationPrincipal CustomUserDetails userDetails,
                                 @Valid @ModelAttribute("assignBusinessRequest") BossDto.AssignBusinessRequest request){

    }
}