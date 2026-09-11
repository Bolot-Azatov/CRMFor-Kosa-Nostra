package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

@Data
public class RegisterRequest {

    @NotBlank
    @Size(max = 150)
    private String username;

    @NotBlank
    @Size(min = 4, max = 10)
    private String password;

    @NotBlank
    private String role;

    @NotBlank
    private String familyName;

//    @NotBlank
    private String photoUrl;

    @NotBlank
    @Size(max = 2500)
    private String bio;
}
