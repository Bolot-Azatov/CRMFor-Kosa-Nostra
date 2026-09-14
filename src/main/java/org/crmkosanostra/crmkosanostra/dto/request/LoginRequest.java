package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class LoginRequest {
    @NotBlank(message = "{validation.username.notblank}")
    private String username;

    @NotBlank(message = "{validation.password.notblank}")
    private String password;
}