<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Instructor Registration</title>
</head>
<body>
<h2>Instructor Registration</h2>

<form action="registerInstructor" method="post">
    <!-- Common User fields -->
    Full Name: <input type="text" name="fullName" required><br><br>
    Email: <input type="email" name="email" required><br><br>
    Password: <input type="password" name="password" required><br><br>
    Profile Picture: <input type="text" name="profilePictureUrl"><br><br>

    <!-- Instructor-specific fields -->
    Area of Expertise: <input type="text" name="expertiseArea" required><br><br>
    Certification: <input type="text" name="certification"><br><br>
    Years of Experience: <input type="number" name="experienceYears" min="0"><br><br>

    <input type="hidden" name="role" value="INSTRUCTOR">

    <input type="submit" value="Register as Instructor">
</form>

</body>
</html>
