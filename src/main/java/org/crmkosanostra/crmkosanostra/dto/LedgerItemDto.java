package org.crmkosanostra.crmkosanostra.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
public class LedgerItemDto {
    private Long id;
    private String capoUsername;
    private BigDecimal amount;
    private LocalDateTime contributedAt;
    private String description;
}