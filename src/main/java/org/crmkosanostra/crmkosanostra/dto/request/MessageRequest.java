package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class MessageRequest {

    @NotBlank(message = "{validation.message.subject.notblank}")
    @Size(max = 255, message = "{validation.message.subject.size}")
    private String subject;

    @NotBlank(message = "{validation.message.body.notblank}")
    private String body;
}