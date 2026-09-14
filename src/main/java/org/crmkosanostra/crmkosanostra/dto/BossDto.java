package org.crmkosanostra.crmkosanostra.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import org.crmkosanostra.crmkosanostra.entity.Role;

import java.math.BigDecimal;

public class BossDto {

    public record AssignRoleRequest(
            @NotNull(message = "ID бойца обязателен")
            @Positive(message = "ID бойца должен быть больше нуля")
            Long userId,

            @NotNull(message = "Укажите роль")
            Role newRole
    ) {}

    public record InvestRequest(
            @NotNull(message = "Укажите сумму")
            @DecimalMin(value = "0.01", message = "Сумма инвестиции должна быть строго больше нуля")
            BigDecimal amount,

            @NotBlank(message = "Укажите назначение средств")
            String description
    ) {}

    public record DiplomacyRequest(
            @NotNull(message = "Target Family ID is required")
            @Positive(message = "ID семьи должен быть больше нуля")
            Long targetFamilyId
    ) {}

    public record BossMessageRequest(
            @NotNull(message = "Recipient ID is required")
            @Positive(message = "ID получателя должен быть больше нуля")
            Long recipientId,

            @NotBlank(message = "Subject is required") String subject,
            @NotBlank(message = "Body is required") String body
    ) {}

    public record AssignBusinessRequest(
            @NotNull @Positive(message = "ID бизнеса должен быть больше нуля") Long businessId,
            @NotNull @Positive(message = "ID капо должен быть больше нуля") Long capoId
    ) {}
}