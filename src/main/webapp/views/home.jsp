<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Skoler | Online Learning Platform</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .features .card {
            transition: 0.3s;
        }
        .features .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 6px 18px rgba(0,0,0,0.2);
        }
        footer {
            margin-top: 50px;
            padding: 20px;
            background: #f8f9fa;
            text-align: center;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/skoler/home">Skoler</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/skoler/home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/skoler/courses">Courses</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/skoler/login">Login</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- Hero Section -->
<section class="hero">
    <div class="container">
        <h1 class="display-4 fw-bold">Welcome to Skoler</h1>
        <p class="lead">Learn from top instructors, anytime and anywhere.</p>
        <a href="student-register.jsp" class="btn btn-warning btn-lg me-3">Join as Student</a>
        <a href="instructor-register.jsp" class="btn btn-outline-light btn-lg">Teach on Skoler</a>
    </div>
</section>

<!-- Features Section -->
<section class="features py-5">
    <div class="container">
        <div class="row text-center mb-4">
            <h2 class="fw-bold">Why Choose Skoler?</h2>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card p-3">
                    <div class="card-body">
                        <h5 class="card-title">📚 Wide Range of Courses</h5>
                        <p class="card-text">From coding to design, explore courses across multiple domains and skill levels.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3">
                    <div class="card-body">
                        <h5 class="card-title">👨‍🏫 Expert Instructors</h5>
                        <p class="card-text">Learn from industry professionals with years of real-world experience.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3">
                    <div class="card-body">
                        <h5 class="card-title">🌍 Learn Anywhere</h5>
                        <p class="card-text">Access lessons on any device and continue your learning journey on the go.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Skoler. All Rights Reserved.</p>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
