package com.skoler.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("skoler")
public class HomeController {

	
	 @GetMapping("/home")
	    public ModelAndView getHome() {
	        ModelAndView mv = new ModelAndView("home");
	        return mv;
	    }
}
