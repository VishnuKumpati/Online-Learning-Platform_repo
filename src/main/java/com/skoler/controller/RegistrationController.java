package com.skoler.controller;
import com.skoler.dto.StudentRegistrationRequest;
import com.skoler.service.RegistrationService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/skoler")
public class RegistrationController {

    private final RegistrationService registrationService;

    public RegistrationController(RegistrationService registrationService) {
        this.registrationService = registrationService;
    }

  

    @PostMapping("/send-otp")
    @ResponseBody
    public ResponseEntity<String> sendOtp(@RequestParam String email) {
        registrationService.sendOtp(email);
        return ResponseEntity.ok("OTP sent to " + email);
    }

    @PostMapping("/verify-otp")
    @ResponseBody
    public ResponseEntity<String> verifyOtp(@RequestParam String email, @RequestParam String otp) {
        boolean valid = registrationService.verifyOtp(email, otp);
        if (valid) return ResponseEntity.ok("OTP verified. You can now register.");
        return ResponseEntity.badRequest().body("Invalid or expired OTP.");
    }

    @PostMapping("/complete-registration")
    @ResponseBody
    public ResponseEntity<String> registerStudent(@RequestBody StudentRegistrationRequest request,
                                                  @RequestParam String otp) {
        boolean valid = registrationService.verifyOtp(request.getEmail(), otp);
        if (!valid) {
            return ResponseEntity.badRequest().body("OTP invalid or expired!");
        }
        registrationService.registerStudent(request);
        return ResponseEntity.ok("Registration successful!");
    }

}
