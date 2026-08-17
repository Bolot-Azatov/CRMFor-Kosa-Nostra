package org.crmkosanostra.crmkosanostra.dto;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class BusinessDto {
    private Long id;
    private String name;
    private String type;
    private BigDecimal weeklyRevenue;
}