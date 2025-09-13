package com.skoler.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/skoler")
public class HomeController {

   
    @GetMapping("/home")
    public String getHome() {
        return "home";
    }

    @GetMapping("/register/student")
    public String getStudentRegister() {
        return "student-register"; 
    }

    @GetMapping("/register/instructor")
    public String getInstructorRegister() {
        return "instructor-register";
    }
}
