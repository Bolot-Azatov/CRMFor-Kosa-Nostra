package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class TributeRequest {

    @NotNull(message = "Укажите сумму взноса")
    @DecimalMin(value = "100.00", message = "Минимальный взнос — $100.00")
    private BigDecimal amount;

    private String description;
}