package org.crmkosanostra.crmkosanostra.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class MessageRequest {

    @NotBlank(message = "Тема сообщения не может быть пустой")
    @Size(max = 255, message = "Тема слишком длинная")
    private String subject;

    @NotBlank(message = "Текст сообщения не может быть пустым")
    private String body;
}