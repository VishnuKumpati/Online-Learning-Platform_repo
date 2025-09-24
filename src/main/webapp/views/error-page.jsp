<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Skoler</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="alert alert-danger">
        <h4 class="alert-heading">Oops! Something went wrong.</h4>
        <p>${errorMessage}</p>
        <hr>
        <a href="${pageContext.request.contextPath}/skoler/home" class="btn btn-primary">Go Home</a>
    </div>
</div>
</body>
</html>
