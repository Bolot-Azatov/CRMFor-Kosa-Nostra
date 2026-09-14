package org.crmkosanostra.crmkosanostra.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import org.crmkosanostra.crmkosanostra.entity.Role;

import java.math.BigDecimal;

public class BossDto {

    public record AssignRoleRequest(
            @NotNull(message = "{validation.role.userid.notnull}")
            @Positive(message = "{validation.role.userid.positive}")
            Long userId,

            @NotNull(message = "{validation.role.newrole.notnull}")
            Role newRole
    ) {}

    public record InvestRequest(
            @NotNull(message = "{validation.invest.amount.notnull}")
            @DecimalMin(value = "0.01", message = "{validation.invest.amount.min}")
            BigDecimal amount,

            @NotBlank(message = "{validation.invest.desc.notblank}")
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

            @NotBlank(message = "{validation.message.subject.notblank}") String subject,
            @NotBlank(message = "{validation.message.body.notblank}") String body
    ) {}

    public record AssignBusinessRequest(
            @NotNull @Positive(message = "ID бизнеса должен быть больше нуля") Long businessId,
            @NotNull @Positive(message = "ID капо должен быть больше нуля") Long capoId
    ) {}
}