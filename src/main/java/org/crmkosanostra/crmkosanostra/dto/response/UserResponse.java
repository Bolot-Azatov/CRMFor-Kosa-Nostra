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
    private String familyName;
    private String photoUrl;
    private String bio;

    public static UserResponse mapToUserResponse(User user) {
        return UserResponse.builder()
                .id(user.getId())
                .username(user.getUsername())
                .role(user.getRole().name())
                .familyId(user.getFamily() != null ? user.getFamily().getId() : null)
                .familyName(user.getFamily() != null ? user.getFamily().getName() : null)
                .photoUrl(user.getPhotoUrl())
                .bio(user.getBio())
                .build();
    }
}