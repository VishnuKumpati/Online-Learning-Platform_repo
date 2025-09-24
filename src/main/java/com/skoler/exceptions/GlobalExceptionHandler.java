package com.skoler.exceptions;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.time.LocalDateTime;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model, HttpServletRequest request) {

        model.addAttribute("errorMessage", ex.getMessage());
        model.addAttribute("exceptionType", ex.getClass().getSimpleName());
        model.addAttribute("url", request.getRequestURL());
        model.addAttribute("timestamp", LocalDateTime.now());

        ex.printStackTrace(); // log on server

        return "error-page"; // forwards to error-page.jsp
    
  }
}