
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SmartCampusPortal | Your Campus, Connected</title>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {
    font-family: "Segoe UI", Arial, sans-serif;
    background: #f5f7ff;
    color: #17213c;
    line-height: 1.6;
}

a {
    text-decoration: none;
    color: inherit;
}

.navbar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 7%;
    background: #ffffff;
    border-bottom: 1px solid #e8eaf3;
    gap: 20px;
    flex-wrap: wrap;
}

.logo {
    font-size: 23px;
    font-weight: 800;
    color: #5145cd;
}

.logo span {
    color: #17213c;
}

.nav-links {
    display: flex;
    align-items: center;
    gap: 26px;
    flex-wrap: wrap;
}

.nav-links a {
    font-size: 14px;
    font-weight: 600;
    color: #47516b;
}

.nav-links a:hover {
    color: #5145cd;
}

.btn {
    display: inline-block;
    padding: 12px 21px;
    border-radius: 10px;
    background: #5145cd;
    color: white !important;
    font-weight: 700;
    transition: 0.2s;
}

.btn:hover {
    background: #3e34a8;
    transform: translateY(-2px);
}

.btn-light {
    background: white;
    color: #5145cd !important;
    border: 1px solid #dedbff;
}

.hero {
    padding: 85px 7%;
    display: grid;
    grid-template-columns: 1.2fr 0.8fr;
    align-items: center;
    gap: 50px;
    background: linear-gradient(135deg, #f0efff, #ffffff 65%);
}

.eyebrow {
    display: inline-block;
    color: #5145cd;
    background: #e8e6ff;
    padding: 8px 14px;
    border-radius: 30px;
    font-size: 12px;
    font-weight: 800;
    letter-spacing: 1px;
    margin-bottom: 23px;
}

.hero h1 {
    font-size: clamp(38px, 5vw, 62px);
    line-height: 1.12;
    letter-spacing: -2px;
    margin-bottom: 23px;
}

.hero h1 span {
    color: #5145cd;
}

.hero p {
    color: #626d85;
    font-size: 17px;
    max-width: 570px;
    margin-bottom: 30px;
}

.hero-buttons {
    display: flex;
    gap: 13px;
    flex-wrap: wrap;
}

.hero-card {
    background: #5145cd;
    color: white;
    padding: 32px;
    border-radius: 25px;
    box-shadow: 0 25px 60px rgba(81, 69, 205, 0.22);
}

.hero-card .icon {
    font-size: 42px;
    margin-bottom: 16px;
}

.hero-card h2 {
    font-size: 25px;
    margin-bottom: 12px;
}

.hero-card p {
    color: #e4e1ff;
    font-size: 15px;
    margin-bottom: 22px;
}

.quick-stats {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 12px;
    margin-top: 25px;
}

.stat {
    padding: 14px 8px;
    background: rgba(255,255,255,0.13);
    border-radius: 12px;
    text-align: center;
}

.stat strong {
    display: block;
    font-size: 22px;
}

.stat small {
    color: #e4e1ff;
    font-size: 11px;
}

.section {
    padding: 75px 7%;
}

.section-heading {
    text-align: center;
    margin-bottom: 38px;
}

.section-heading .eyebrow {
    margin-bottom: 12px;
}

.section-heading h2 {
    font-size: 35px;
    margin-bottom: 10px;
}

.section-heading p {
    color: #69738a;
}

.features {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 23px;
}

.feature-card {
    padding: 28px;
    background: white;
    border: 1px solid #e8eaf3;
    border-radius: 18px;
    box-shadow: 0 8px 25px rgba(32, 43, 80, 0.04);
    transition: 0.2s;
}

.feature-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 15px 35px rgba(32, 43, 80, 0.09);
}

.feature-icon {
    width: 55px;
    height: 55px;
    display: grid;
    place-items: center;
    background: #eeecff;
    border-radius: 15px;
    font-size: 27px;
    margin-bottom: 20px;
}

.feature-card h3 {
    font-size: 20px;
    margin-bottom: 10px;
}

.feature-card p {
    font-size: 14px;
    color: #69738a;
    margin-bottom: 20px;
}

.card-link {
    color: #5145cd;
    font-weight: 700;
    font-size: 14px;
}

.events-section {
    background: #ffffff;
}

.events-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 23px;
}

.event-card {
    border: 1px solid #e8eaf3;
    border-radius: 18px;
    overflow: hidden;
    background: white;
}

.event-banner {
    min-height: 130px;
    padding: 25px;
    background: linear-gradient(135deg, #5145cd, #958bff);
    color: white;
    font-size: 42px;
}

.event-banner.green {
    background: linear-gradient(135deg, #07876d, #5dd6ac);
}

.event-banner.orange {
    background: linear-gradient(135deg, #d86a27, #ffbf75);
}

.event-content {
    padding: 23px;
}

.tag {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 20px;
    background: #eeecff;
    color: #5145cd;
    font-size: 11px;
    font-weight: 800;
    margin-bottom: 12px;
}

.event-content h3 {
    margin-bottom: 10px;
    font-size: 20px;
}

.event-content p {
    color: #69738a;
    font-size: 14px;
    margin-bottom: 17px;
}

.event-date {
    font-size: 13px;
    color: #47516b;
    font-weight: 600;
    margin-bottom: 18px;
}

.cta {
    margin: 65px 7%;
    padding: 48px;
    border-radius: 22px;
    background: #1c2340;
    color: white;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 25px;
    flex-wrap: wrap;
}

.cta h2 {
    font-size: 30px;
    margin-bottom: 8px;
}

.cta p {
    color: #c4c9dc;
}

.footer {
    background: white;
    padding: 30px 7%;
    border-top: 1px solid #e8eaf3;
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
    color: #69738a;
    font-size: 13px;
}

@media (max-width: 850px) {
    .hero {
        grid-template-columns: 1fr;
        padding-top: 55px;
    }

    .features,
    .events-grid {
        grid-template-columns: repeat(2, 1fr);
    }

    .nav-links {
        gap: 14px;
    }
}

@media (max-width: 560px) {
    .navbar {
        padding: 18px 5%;
    }

    .hero,
    .section {
        padding: 45px 5%;
    }

    .features,
    .events-grid {
        grid-template-columns: 1fr;
    }

    .section-heading h2 {
        font-size: 29px;
    }

    .cta {
        margin: 35px 5%;
        padding: 28px;
    }

    .footer {
        padding: 25px 5%;
    }
}
</style>
</head>

<body>

<nav class="navbar">
    <a class="logo" href="#home">✦ Smart<span>Campus</span></a>

    <div class="nav-links">
        <a href="#home">Home</a>
        <a href="#features">Resources</a>
        <a href="#events">Events</a>
        <a href="#about">About</a>
        <a class="btn" href="admin.jsp">Sign In</a>
    </div>
</nav>

<main>
    <section class="hero" id="home">
        <div>
            <span class="eyebrow">YOUR CAMPUS, CONNECTED</span>
            <h1>Make campus life <span>work smarter.</span></h1>
            <p>
                One place for the events you love and the spaces you need.
                Discover campus experiences, reserve resources, and spend
                less time coordinating.
            </p>

            <div class="hero-buttons">
                <a class="btn" href="#events">Explore Events ↗</a>
                <a class="btn btn-light" href="#features">Explore Resources</a>
            </div>
        </div>

        <div class="hero-card">
            <div class="icon">🎓</div>
            <h2>Campus, made simple.</h2>
            <p>
                Your campus activities, resources, and community
                brought together in one convenient portal.
            </p>

            <div class="quick-stats">
                <div class="stat">
                    <strong>01</strong>
                    <small>Events</small>
                </div>
                <div class="stat">
                    <strong>02</strong>
                    <small>Spaces</small>
                </div>
                <div class="stat">
                    <strong>03</strong>
                    <small>Community</small>
                </div>
            </div>
        </div>
    </section>

    <section class="section" id="features">
        <div class="section-heading">
            <span class="eyebrow">EVERYTHING IN ONE PLACE</span>
            <h2>Your campus at a glance</h2>
            <p>Everything you need to make the most of campus life.</p>
        </div>

        <div class="features">
            <article class="feature-card">
                <div class="feature-icon">📅</div>
                <h3>Campus Events</h3>
                <p>
                    Discover workshops, seminars, activities, and
                    opportunities happening around campus.
                </p>
                <a class="card-link" href="#events">Explore events →</a>
            </article>

            <article class="feature-card">
                <div class="feature-icon">🏫</div>
                <h3>Resource Booking</h3>
                <p>
                    Find the spaces and facilities you need for
                    studying, meetings, and group activities.
                </p>
                <a class="card-link" href="#booking">Explore resources →</a>
            </article>

            <article class="feature-card">
                <div class="feature-icon">🤝</div>
                <h3>Campus Community</h3>
                <p>
                    Stay informed, connect with campus activities,
                    and make every college day count.
                </p>
                <a class="card-link" href="#about">Learn more →</a>
            </article>
        </div>
    </section>

    <section class="section events-section" id="events">
        <div class="section-heading">
            <span class="eyebrow">LEARN • CONNECT • GROW</span>
            <h2>What's happening on campus?</h2>
            <p>Explore opportunities to learn new skills and meet people.</p>
        </div>

        <div class="events-grid">
            <article class="event-card">
                <div class="event-banner">💻</div>
                <div class="event-content">
                    <span class="tag">TECHNOLOGY</span>
                    <h3>Build the Future with AI</h3>
                    <p>
                        Explore artificial intelligence and discover
                        how emerging technologies are changing the world.
                    </p>
                    <div class="event-date">📅 October 24 · 10:00 AM</div>
                    <a class="card-link" href="#booking">View details →</a>
                </div>
            </article>

            <article class="event-card">
                <div class="event-banner green">🚀</div>
                <div class="event-content">
                    <span class="tag">INNOVATION</span>
                    <h3>Student Innovation Hub</h3>
                    <p>
                        Share ideas, collaborate with fellow students,
                        and turn creative thinking into projects.
                    </p>
                    <div class="event-date">📅 Campus activity</div>
                    <a class="card-link" href="#about">Learn more →</a>
                </div>
            </article>

            <article class="event-card">
                <div class="event-banner orange">🎤</div>
                <div class="event-content">
                    <span class="tag">COMMUNITY</span>
                    <h3>Skills & Career Workshop</h3>
                    <p>
                        Build communication skills, explore career
                        options, and prepare for future opportunities.
                    </p>
                    <div class="event-date">📅 Student workshop</div>
                    <a class="card-link" href="#about">Learn more →</a>
                </div>
            </article>
        </div>
    </section>

    <section class="section" id="booking">
        <div class="section-heading">
            <span class="eyebrow">PLAN YOUR DAY</span>
            <h2>Make room for great ideas.</h2>
            <p>
                Use your campus resources to study, collaborate,
                and bring your next project to life.
            </p>
        </div>

        <div class="features">
            <article class="feature-card">
                <div class="feature-icon">📚</div>
                <h3>Study Spaces</h3>
                <p>Find a comfortable place to focus on your studies.</p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">🖥️</div>
                <h3>Computer Facilities</h3>
                <p>Access campus technology for learning and projects.</p>
            </article>

            <article class="feature-card">
                <div class="feature-icon">🏢</div>
                <h3>Seminar Rooms</h3>
                <p>Plan group discussions, presentations, and meetings.</p>
            </article>
        </div>
    </section>

    <section class="cta" id="about">
        <div>
            <h2>Your campus journey starts here.</h2>
            <p>Discover more. Connect better. Make every day count.</p>
        </div>
        <a class="btn" href="#home">Back to Home ↑</a>
    </section>
</main>

<footer class="footer">
    <a class="logo" href="#home">✦ Smart<span>Campus</span></a>
    <p>© 2026 SmartCampusPortal. Built for campus life.</p>
</footer>

</body>
</html>
