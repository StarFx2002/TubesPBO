<link rel="stylesheet" href="components/header.css" />
<header>
    <div class="logo">
        <h1><a href="home"class="title" >MyReuseHub</a></h1>
    </div>
    <nav>
        <ul class="nav-links">
            <li><a href="home" class="${param.p == null || param.p == 'home' ? 'active' : ''}">MyHome</a></li>
            <li><a href="home?p=payment" class="${param.p == 'payment' ? 'active' : ''}">MyTransaction</a></li>
            <li><a href="home?p=profile" class="${param.p == 'profile' ? 'active' : ''}">MyProfile</a></li>
        </ul>
    </nav>
        <div class="search-bar" id="search-bar" style="<% if (request.getParameter("a") != null) { %>visibility : hidden;<% } %>">
        <input type="text" placeholder="Search...">
    </div>
</header>
