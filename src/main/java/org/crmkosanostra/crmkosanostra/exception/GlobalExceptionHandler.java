package org.crmkosanostra.crmkosanostra.exception;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.crmkosanostra.crmkosanostra.exception.exceptions.BusinessLogicException;
import org.crmkosanostra.crmkosanostra.exception.exceptions.ResourceNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.time.LocalDateTime;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleResourceNotFound(ResourceNotFoundException ex, HttpServletRequest request, Model model) {
        log.warn("Resource not found [{}]: {}", request.getRequestURI(), ex.getMessage());

        populateErrorModel(model, HttpStatus.NOT_FOUND.value(), "Ресурс не найден", ex.getMessage(), request.getRequestURI());
        return "error";
    }

    @ExceptionHandler(BusinessLogicException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String handleBusinessLogic(BusinessLogicException ex, HttpServletRequest request, Model model) {
        log.warn("Business logic violation [{}]: {}", request.getRequestURI(), ex.getMessage());

        populateErrorModel(model, HttpStatus.BAD_REQUEST.value(), "Ошибка бизнес-логики", ex.getMessage(), request.getRequestURI());
        return "error";
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String handleIllegalArgument(IllegalArgumentException ex, HttpServletRequest request, Model model) {
        log.warn("Invalid argument [{}]: {}", request.getRequestURI(), ex.getMessage());

        populateErrorModel(model, HttpStatus.BAD_REQUEST.value(), "Некорректный запрос", ex.getMessage(), request.getRequestURI());
        return "error";
    }

    @ExceptionHandler(RuntimeException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String handleRuntimeException(RuntimeException ex, HttpServletRequest request, Model model) {
        log.error("Runtime exception [{}]: {}", request.getRequestURI(), ex.getMessage());

        populateErrorModel(model, HttpStatus.BAD_REQUEST.value(), "Ошибка выполнения", ex.getMessage(), request.getRequestURI());
        return "error";
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleGlobalException(Exception ex, HttpServletRequest request, Model model) {
        log.error("Unhandled exception on [{}]", request.getRequestURI(), ex);

        populateErrorModel(model, HttpStatus.INTERNAL_SERVER_ERROR.value(), "Внутренняя ошибка сервера", "Произошла непредвиденная ошибка. Обратитесь к администратору.", request.getRequestURI());
        return "error";
    }

    private void populateErrorModel(Model model, int status, String title, String message, String path) {
        model.addAttribute("status", status);
        model.addAttribute("errorTitle", title);
        model.addAttribute("message", message);
        model.addAttribute("path", path);
        model.addAttribute("timestamp", LocalDateTime.now());
    }
}