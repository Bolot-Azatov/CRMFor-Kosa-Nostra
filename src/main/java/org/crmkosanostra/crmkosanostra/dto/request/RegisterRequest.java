package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class RegisterRequest {

    @NotBlank(message = "{validation.username.notblank}")
    @Size(max = 150, message = "{validation.username.size}")
    private String username;

    @NotBlank(message = "{validation.password.notblank}")
    @Size(min = 4, max = 10, message = "{validation.password.size}")
    private String password;

    private String role;

    @NotBlank(message = "{validation.family.notblank}")
    private String familyName;

    private String photoUrl;

    @NotBlank(message = "{validation.bio.notblank}")
    @Size(max = 2500, message = "{validation.bio.size}")
    private String bio;
}