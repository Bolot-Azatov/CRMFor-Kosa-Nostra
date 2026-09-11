package org.crmkosanostra.crmkosanostra.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.crmkosanostra.crmkosanostra.dto.request.MessageRequest;
import org.crmkosanostra.crmkosanostra.security.CustomUserDetails;
import org.crmkosanostra.crmkosanostra.service.ConsigliereService;
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

    // Просмотр финансовой книги семьи
    @GetMapping("/ledger")
    public String getLedger(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {
        model.addAttribute("ledger", consigliereService.getFamilyLedger(userDetails.getFamilyId()));
        return "consigliere/ledger";
    }

    // Форма отправки сообщения Боссу
    @GetMapping("/message")
    public String showMessageForm(Model model) {
        if (!model.containsAttribute("messageRequest")) {
            model.addAttribute("messageRequest", new MessageRequest());
        }
        return "consigliere/message"; // Шаблон src/main/resources/templates/counselor/message.html
    }

    // Обработка отправки сообщения Боссу
    @PostMapping("/message")
    public String sendMessage(@AuthenticationPrincipal CustomUserDetails userDetails,
                              @Valid @ModelAttribute("messageRequest") MessageRequest request,
                              BindingResult bindingResult,
                              RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            redirectAttributes.addFlashAttribute("org.springframework.validation.BindingResult.messageRequest", bindingResult);
            redirectAttributes.addFlashAttribute("messageRequest", request);
            return "redirect:/consigliere/message";
        }

        try {
            consigliereService.sendMessageToBoss(userDetails.getUserId(), userDetails.getFamilyId(), request);
            redirectAttributes.addFlashAttribute("successMessage", "Зашифрованное письмо отправлено Боссу.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }

        return "redirect:/consigliere/message";
    }
}