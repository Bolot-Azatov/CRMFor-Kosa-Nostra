// src/main/java/org/crmkosanostra/crmkosanostra/controller/ConsigliereController.java

package org.crmkosanostra.crmkosanostra.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.request.MessageRequest;
import org.crmkosanostra.crmkosanostra.entity.Message;
import org.crmkosanostra.crmkosanostra.repository.MessageRepository;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.ConsigliereService;
import org.crmkosanostra.crmkosanostra.service.MessageService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/consigliere")
@PreAuthorize("hasAnyRole('CONSIGLIERE', 'BOSS')")
@RequiredArgsConstructor
public class ConsigliereController {

    private final ConsigliereService consigliereService;
    private final MessageService messageService;
    private final MessageRepository messageRepository;

    @GetMapping("/ledger")
    public String getLedger(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("ledger", consigliereService.getFamilyLedger(userDetails.getFamilyId()));
        return "consigliere/ledger";
    }

    @GetMapping("/messages")
    public String getMessages(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        Long userId = userDetails.getUserId();
        model.addAttribute("inbox", messageRepository.findByRecipientIdOrderBySentAtDesc(userId));
        model.addAttribute("outbox", messageRepository.findBySenderIdOrderBySentAtDesc(userId));
        return "consigliere/messages";
    }

    @GetMapping({"/messages/new", "/message"})
    public String showMessageForm(Model model) {
        if (!model.containsAttribute("messageRequest")) {
            model.addAttribute("messageRequest", new MessageRequest());
        }
        return "consigliere/message_new";
    }

    @PostMapping({"/messages/send", "/message"})
    public String sendMessage(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @ModelAttribute("messageRequest") MessageRequest request,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Заполните тему и текст донесения");
            return "redirect:/consigliere/messages/new";
        }

        try {
            consigliereService.sendMessageToBoss(userDetails.getUserId(), userDetails.getFamilyId(), request);
            redirectAttributes.addFlashAttribute("successMessage", "Зашифрованное послание передано Дону.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/consigliere/messages/new";
        }

        return "redirect:/consigliere/messages";
    }

    @GetMapping("/messages/{id}")
    public String readMessage(
            @PathVariable Long id,
            @AuthenticationPrincipal CustomUserDetails userDetails,
            Model model) {
        Message msg = messageService.readMessage(id, userDetails.getUserId());
        model.addAttribute("msg", msg);
        model.addAttribute("isRecipient", msg.getRecipient().getId().equals(userDetails.getUserId()));
        return "consigliere/message_detail";
    }
}