// src/main/java/org/crmkosanostra/crmkosanostra/controller/BossController.java

package org.crmkosanostra.crmkosanostra.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.BossDto;
import org.crmkosanostra.crmkosanostra.entity.Message;
import org.crmkosanostra.crmkosanostra.entity.User;
import org.crmkosanostra.crmkosanostra.repository.MessageRepository;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.BossService;
import org.crmkosanostra.crmkosanostra.service.MessageService;
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
    private final MessageService messageService;
    private final MessageRepository messageRepository;

    // 1. Главный дашборд
    @GetMapping({"", "/dashboard"})
    public String dashboard(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("boss", boss);
        model.addAttribute("family", boss.getFamily());
        model.addAttribute("membersCount", bossService.getFamilyMembers(boss).size());
        model.addAttribute("businessesCount", bossService.getFamilyBusinesses(boss).size());
        model.addAttribute("recentLedger", bossService.getFamilyLedger(boss).stream().limit(5).toList());
        return "boss/dashboard";
    }

    // 2. Кадровый учет
    @GetMapping("/members")
    public String getMembers(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("boss", boss);
        model.addAttribute("members", bossService.getFamilyMembers(boss));
        if (!model.containsAttribute("assignRoleRequest")) {
            model.addAttribute("assignRoleRequest", new BossDto.AssignRoleRequest(null, null));
        }
        return "boss/members";
    }

    @PostMapping({"/members/assign", "/members/assign-role"})
    public String assignRole(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("assignRoleRequest") BossDto.AssignRoleRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "flash.role.error");
            return "redirect:/boss/members";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.assignRole(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.role.assigned");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss/members";
    }

    // 3. Предприятия семьи и привязка к Капо
    @GetMapping("/businesses")
    public String getBusinesses(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("businesses", bossService.getFamilyBusinesses(boss));
        model.addAttribute("capos", bossService.getFamilyCapos(boss));
        return "boss/businesses";
    }

    @PostMapping("/businesses/assign")
    public String assignBusiness(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("assignBusinessRequest") BossDto.AssignBusinessRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "flash.business.error");
            return "redirect:/boss/businesses";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.assignBusinessToCapo(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.business.assigned");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss/businesses";
    }


    // 4. Казначейство и Инвестиции
    @GetMapping({"/treasury", "/ledger"})
    public String getTreasury(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("family", boss.getFamily());
        model.addAttribute("ledger", bossService.getFamilyLedger(boss));
        if (!model.containsAttribute("investRequest")) {
            model.addAttribute("investRequest", new BossDto.InvestRequest(null, null));
        }
        return "boss/treasury";
    }

    @PostMapping("/treasury/invest")
    public String invest(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("investRequest") BossDto.InvestRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "flash.invest.error");
            return "redirect:/boss/treasury";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.investFromTreasury(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.invest.success");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/boss/treasury";
    }


    // 5. Дипломатия
    @GetMapping("/diplomacy")
    public String getDiplomacy(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("relations", bossService.getFamilyRelations(boss));
        model.addAttribute("currentFamily", boss.getFamily());
        return "boss/diplomacy";
    }

    @PostMapping("/diplomacy/declare-war")
    public String declareWar(@AuthenticationPrincipal CustomUserDetails userDetails,
                             @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
                             BindingResult bindingResult,
                             RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Некорректный идентификатор целевой семьи");
            return "redirect:/boss/diplomacy";
        }
        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.declareWar(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.war.declared");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/boss/diplomacy";
    }

    @PostMapping("/diplomacy/propose-peace")
    public String proposePeace(@AuthenticationPrincipal CustomUserDetails userDetails,
                               @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
                               BindingResult bindingResult,
                               RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Некорректный идентификатор целевой семьи");
            return "redirect:/boss/diplomacy";
        }
        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.proposePeace(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.peace.proposed");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/boss/diplomacy";
    }

    @PostMapping("/diplomacy/accept-peace")
    public String acceptPeace(@AuthenticationPrincipal CustomUserDetails userDetails,
                              @Valid @ModelAttribute("diplomacyRequest") BossDto.DiplomacyRequest request,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Некорректный идентификатор целевой семьи");
            return "redirect:/boss/diplomacy";
        }
        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.acceptPeace(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.peace.accepted");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/boss/diplomacy";
    }

    // 6. Почтовая система Дона
    @GetMapping("/messages")
    public String getMessages(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        Long userId = userDetails.getUserId();
        model.addAttribute("inbox", messageRepository.findByRecipientIdOrderBySentAtDesc(userId));
        model.addAttribute("outbox", messageRepository.findBySenderIdOrderBySentAtDesc(userId));
        return "boss/messages";
    }

    @GetMapping("/messages/new")
    public String getMessageNewForm(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        User boss = bossService.getBossById(userDetails.getUserId());
        model.addAttribute("recipients", bossService.getAllowedRecipientsForBoss(boss));
        if (!model.containsAttribute("messageRequest")) {
            model.addAttribute("messageRequest", new BossDto.BossMessageRequest(null, "", ""));
        }
        return "boss/message_new";
    }

    @PostMapping({"/messages/send", "/messages"})
    public String sendMessage(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("messageRequest") BossDto.BossMessageRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "flash.message.error");
            redirectAttributes.addFlashAttribute("messageRequest", request);
            return "redirect:/boss/messages/new";
        }

        try {
            User boss = bossService.getBossById(userDetails.getUserId());
            bossService.sendMessage(boss, request);
            redirectAttributes.addFlashAttribute("successMessage", "flash.message.sent");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            redirectAttributes.addFlashAttribute("messageRequest", request);
            return "redirect:/boss/messages/new";
        }

        return "redirect:/boss/messages";
    }

    @GetMapping("/messages/{id}")
    public String readMessage(
            @PathVariable Long id,
            @AuthenticationPrincipal CustomUserDetails userDetails,
            Model model) {
        Message msg = messageService.readMessage(id, userDetails.getUserId());
        model.addAttribute("msg", msg);
        model.addAttribute("isRecipient", msg.getRecipient().getId().equals(userDetails.getUserId()));
        return "boss/message_detail";
    }
}