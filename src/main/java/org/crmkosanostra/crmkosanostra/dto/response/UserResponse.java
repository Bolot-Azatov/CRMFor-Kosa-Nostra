package org.crmkosanostra.crmkosanostra.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.crmkosanostra.crmkosanostra.entity.User;

@Data
@AllArgsConstructor
@Builder
public class UserResponse {

    private Long id;
    private String username;
    private String role;
    private Long familyId;

    public static UserResponse mapToUserResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .role(user.getRole().name())
                .familyId(user.getFamily().getId())
                .build();
    }
}