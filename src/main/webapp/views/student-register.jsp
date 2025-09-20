<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Registration | Skoler</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Student Registration</h2>
    
    <div class="alert alert-info" id="otp-message" style="display:none;"></div>

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

        <!-- OTP Input (hidden initially) -->
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
$(document).ready(function() {
    let emailVerified = false;

    // 1️⃣ Send OTP
    $("#sendOtpBtn").click(function() {
        const email = $("#email").val();
        if(!email) {
            alert("Enter email first!");
            return;
        }

        $.post("${pageContext.request.contextPath}/skoler/send-otp", { email: email })
         .done(function(res) {
             $("#otp-message").text(res).show();
             $("#otpDiv").show();
         })
         .fail(function(err) {
             $("#otp-message").text(err.responseText).show();
         });
    });

    // 2️⃣ Verify OTP
    $("#verifyOtpBtn").click(function() {
        const email = $("#email").val();
        const otp = $("#otp").val();
        if(!otp) { alert("Enter OTP!"); return; }

        $.post("${pageContext.request.contextPath}/skoler/verify-otp", { email: email, otp: otp })
         .done(function(res) {
             $("#otp-message").text(res).show();
             emailVerified = true;
             $("#registerBtn").prop("disabled", false); // enable register
             $("#otpDiv").hide(); // hide OTP input
         })
         .fail(function(err) {
             $("#otp-message").text(err.responseText).show();
             emailVerified = false;
             $("#registerBtn").prop("disabled", true);
         });
    });

    // 3️⃣ Submit registration
    $("#registrationForm").submit(function(e) {
        e.preventDefault();
        if(!emailVerified) {
            alert("Please verify your email first!");
            return;
        }

        const data = {
            fullName: $("#fullName").val(),
            email: $("#email").val(),
            password: $("#password").val(),
            university: $("#university").val(),
            branch: $("#branch").val(),
            phoneNumber: $("#phoneNumber").val()
        };

        $.ajax({
            url: "${pageContext.request.contextPath}/skoler/complete-registration",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function(res) {
                alert(res);
                window.location.href = "${pageContext.request.contextPath}/skoler/home";
            },
            error: function(err) {
                $("#otp-message").text(err.responseText).show();
            }
        });
    });
});
</script>
</body>
</html>
