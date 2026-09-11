package org.crmkosanostra.crmkosanostra.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MemberDto {
    private Long id;
    private String username;
    private String photoUrl;
    private String bio;
}