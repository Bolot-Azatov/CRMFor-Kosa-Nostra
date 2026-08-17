package org.crmkosanostra.crmkosanostra.dto.response;

import lombok.Builder;
import lombok.Data;
import org.crmkosanostra.crmkosanostra.dto.MemberDto;

import java.util.List;

@Data
@Builder
public class FamilyHierarchyResponse {
    private String familyName;
    private MemberDto boss;
    private MemberDto counselor;
    private List<MemberDto> capos;
    private List<MemberDto> soldiers;
}