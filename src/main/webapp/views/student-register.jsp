<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registration | Skoler</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Student Registration</h2>

    <!-- Alert message -->
    <div id="otp-message" style="display:none;"></div>

    <form id="registrationForm">
        <!-- Full Name -->
        <div class="mb-3">
            <label for="fullName" class="form-label">Full Name</label>
            <input type="text" class="form-control" id="fullName" name="fullName" required>
        </div>

        <!-- Email + Verify -->
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <div class="input-group">
                <input type="email" class="form-control" id="email" name="email" required>
                <button class="btn btn-primary" type="button" id="sendOtpBtn">Verify Email</button>
            </div>
        </div>

        <!-- OTP Input -->
        <div class="mb-3" id="otpDiv" style="display:none;">
            <label for="otp" class="form-label">Enter OTP</label>
            <div class="input-group">
                <input type="text" class="form-control" id="otp" maxlength="6">
                <button class="btn btn-success" type="button" id="verifyOtpBtn">Verify OTP</button>
            </div>
        </div>

        <!-- University -->
        <div class="mb-3">
            <label for="university" class="form-label">University</label>
            <input type="text" class="form-control" id="university" name="university">
        </div>

        <!-- Branch -->
        <div class="mb-3">
            <label for="branch" class="form-label">Branch</label>
            <input type="text" class="form-control" id="branch" name="branch">
        </div>

        <!-- Phone -->
        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number</label>
            <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
        </div>

        <!-- Password -->
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>

        <!-- Register Button -->
        <button type="submit" class="btn btn-primary" id="registerBtn" disabled>Register</button>
    </form>
</div>

<script>
document.addEventListener("DOMContentLoaded", () => {
    let emailVerified = false;
    const contextPath = "<%= request.getContextPath() %>";
    const otpMsg = document.getElementById("otp-message");
    const otpDiv = document.getElementById("otpDiv");
    const registerBtn = document.getElementById("registerBtn");

    // Show message helper
    function showMessage(msg, type = "info") {
        otpMsg.textContent = msg;
        otpMsg.className = `alert alert-${type}`;
        otpMsg.style.display = "block";
    }

    // 1️⃣ Send OTP
    document.getElementById("sendOtpBtn").addEventListener("click", async () => {
        const email = document.getElementById("email").value.trim();
        if (!email) return showMessage("Enter your email first!", "danger");

        try {
            const res = await fetch(`${contextPath}/skoler/send-otp`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ email })
            });
            const text = await res.text();

            if (res.status === 409) { // duplicate email
                showMessage("Email already exists. Try another.", "danger");
                emailVerified = false;
                registerBtn.disabled = true;
                otpDiv.style.display = "none";
            } else if (res.ok) {
                showMessage("OTP sent successfully!", "success");
                otpDiv.style.display = "block";
            } else {
                showMessage(text, "danger");
            }
        } catch (err) {
            showMessage("Error sending OTP. Try again.", "danger");
        }
    });

    // 2️⃣ Verify OTP
    document.getElementById("verifyOtpBtn").addEventListener("click", async () => {
        const email = document.getElementById("email").value.trim();
        const otp = document.getElementById("otp").value.trim();
        if (!otp) return showMessage("Please enter OTP!", "warning");

        try {
            const res = await fetch(`${contextPath}/skoler/verify-otp`, {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ email, otp })
            });
            const text = await res.text();

            if (res.ok) {
                showMessage("OTP verified successfully!", "success");
                emailVerified = true;
                registerBtn.disabled = false;
                otpDiv.style.display = "none";
            } else if (res.status === 410) {
                showMessage("OTP expired. Request new OTP.", "danger");
                emailVerified = false;
                registerBtn.disabled = true;
            } else {
                showMessage("Incorrect OTP. Try again.", "danger");
                emailVerified = false;
                registerBtn.disabled = true;
            }
        } catch (err) {
            showMessage("Error verifying OTP. Try again.", "danger");
        }
    });

    // 3️⃣ Register Student
    document.getElementById("registrationForm").addEventListener("submit", async e => {
        e.preventDefault();
        if (!emailVerified) {
            showMessage("Please verify your email before registering!", "warning");
            return;
        }

        const data = {
            fullName: document.getElementById("fullName").value.trim(),
            email: document.getElementById("email").value.trim(),
            password: document.getElementById("password").value.trim(),
            university: document.getElementById("university").value.trim(),
            branch: document.getElementById("branch").value.trim(),
            phoneNumber: document.getElementById("phoneNumber").value.trim()
        };
        const otp = encodeURIComponent(document.getElementById("otp").value.trim());

        try {
            const res = await fetch(`${contextPath}/skoler/complete-registration?otp=${otp}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            });
            const text = await res.text();

            if (res.ok) {
                showMessage("Registration successful!", "success");
                otpDiv.style.display = "none";
                registerBtn.disabled = true;
            } else if (res.status === 409) {
                showMessage("Email already registered!", "danger");
            } else {
                showMessage("Registration failed. Try again.", "danger");
            }
        } catch (err) {
            showMessage("Registration failed. Try again.", "danger");
        }
    });
});
</script>
</body>
</html>
