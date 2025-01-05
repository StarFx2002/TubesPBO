<%-- 
    Document   : error
    Created on : 5 Jan 2025, 03.41.42
    Author     : aktsa_wi2suow
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body style="display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background-color: #333333;">
        <div style="text-align: center; background-color: white; padding: 2rem; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">
            <h1 style="color: #721c24; font-size: 2.5rem; margin-bottom: 1rem;">Hayo loh, mau ngapain???</h1>
            <p style="color: #721c24; font-size: 1.2rem; margin-bottom: 2rem;">${param.message}</p>
            <a href="home" style="display: inline-block; text-decoration: none; color: white; background-color: #007bff; padding: 0.5rem 1rem; border-radius: 5px; font-size: 1rem;">Back to Home</a>
        </div>
    </body>
</html>
