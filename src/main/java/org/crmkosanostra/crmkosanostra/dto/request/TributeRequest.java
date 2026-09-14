package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class TributeRequest {

    @NotNull(message = "{validation.tribute.amount.notnull}")
    @DecimalMin(value = "100.00", message = "{validation.tribute.amount.min}")
    private BigDecimal amount;

    private String description;
}