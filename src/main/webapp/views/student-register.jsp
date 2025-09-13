<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Registration</title>
</head>
<body>
<h2>Student Registration</h2>

<form action="registerStudent" method="post">
    <!-- Common User fields -->
    Full Name: <input type="text" name="fullName" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    Profile Picture: <input type="text" name="profilePictureUrl"><br><br>

    <!-- Student-specific fields -->
    University: <input type="text" name="university" required><br><br>
    Major: <input type="text" name="major"><br><br>
    Year of Study: <input type="number" name="yearOfStudy" min="1" max="8"><br><br>
    Phone Number: <input type="text" name="phoneNumber"><br><br>

    <input type="hidden" name="role" value="STUDENT">

    <input type="submit" value="Register as Student">
</form>

</body>
</html>
