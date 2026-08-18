package org.crmkosanostra.crmkosanostra.dto;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.crmkosanostra.crmkosanostra.entity.Role;

import java.math.BigDecimal;

public class BossDto {

    public record AssignRoleRequest(
            @NotNull(message = "User ID is required") Long userId,
            @NotNull(message = "Role is required") Role newRole
    ) {}

    public record InvestRequest(
            @NotNull(message = "Amount is required")
            @DecimalMin(value = "0.01", message = "Amount must be greater than zero")
            BigDecimal amount,

            @NotBlank(message = "Description is required") String description
    ) {}

    public record DiplomacyRequest(
            @NotNull(message = "Target Family ID is required") Long targetFamilyId
    ) {}

    public record BossMessageRequest(
            @NotNull(message = "Recipient ID is required") Long recipientId,
            @NotBlank(message = "Subject is required") String subject,
            @NotBlank(message = "Body is required") String body
    ) {}
}