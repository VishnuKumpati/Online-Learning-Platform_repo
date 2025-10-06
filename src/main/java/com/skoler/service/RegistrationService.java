package com.skoler.service;

import com.skoler.dto.StudentRegistrationRequest;
import com.skoler.entity.Student;
import com.skoler.entity.UserRole;
import com.skoler.mailConfig.EmailService;
import com.skoler.repo.StudentRepository;
import org.springframework.stereotype.Service;

import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

@Service
public class RegistrationService {

    private final StudentRepository studentRepository;
    private final EmailService emailService;

    private final ConcurrentHashMap<String, OtpData> otpStore = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, OtpData> expiredOtpStore = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<String, Boolean> verifiedEmails = new ConcurrentHashMap<>();

    public RegistrationService(StudentRepository studentRepository, EmailService emailService) {
        this.studentRepository = studentRepository;
        this.emailService = emailService;
    }


    public void sendOtp(String email) {
        String otp = String.valueOf(new Random().nextInt(900000) + 100000);
        long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000);
        OtpData otpData = new OtpData(otp, expiryTime);

        otpStore.put(email, otpData);
        verifiedEmails.remove(email); 
        emailService.sendOtpMail(email, otp);
    }

    public boolean verifyOtp(String email, String inputOtp) {
        OtpData otpData = otpStore.get(email);

        if (otpData == null || otpData.isExpired()) {
            if (otpData != null) expiredOtpStore.put(email, otpData);
            otpStore.remove(email);
            return false;
        }

        if (otpData.getOtp().equals(inputOtp) && !otpData.isUsed()) {
            otpData.setUsed(true);
            verifiedEmails.put(email, true);
            return true;
        }

        return false;
    }

    public boolean isEmailVerified(String email) {
        return verifiedEmails.getOrDefault(email, false);
    }

    // ---------------- Student Registration ---------------- //

    public void registerStudent(StudentRegistrationRequest request) {
        Student student = new Student();
        student.setFullName(request.getFullName());
        student.setEmail(request.getEmail());
        student.setPassword(request.getPassword());
        student.setUniversity(request.getUniversity());
        student.setBranch(request.getBranch());
        student.setPhoneNumber(request.getPhoneNumber());
        student.setRole(UserRole.STUDENT);

        studentRepository.save(student);
        verifiedEmails.remove(request.getEmail()); // reset after success
    }

    // ---------------- Inner class for OTP ---------------- //
    private static class OtpData {
        private final String otp;
        private final long expiryTime;
        private boolean used;

        public OtpData(String otp, long expiryTime) {
            this.otp = otp;
            this.expiryTime = expiryTime;
            this.used = false;
        }

        public String getOtp() { return otp; }
        public boolean isUsed() { return used; }
        public void setUsed(boolean used) { this.used = used; }
        public boolean isExpired() { return System.currentTimeMillis() > expiryTime; }
    }
}
