<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List"%>
<%
    if (request.getParameter("logout") != null) {
        session.invalidate();
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<html>
  <head>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <title>Home Page</title>
  </head>
<body>
<div id="content">
<h1>Sistema de Gestión</h1>

<p>Hola <b><%= request.getUserPrincipal().getName() %></b>. Este es el menu de la aplicación: </p>
<p>Su login es: <%= request.getRemoteUser() %></p>
<p>Sus roles son: <% 
    if (request.isUserInRole("MANAGEMENT")) { %> [MANAGEMENT: ✔️]<% } else { %> [MANAGEMENT: 🚫]<% }
    if (request.isUserInRole("SALES")) { %> [SALES: ✔️]<% } else { %> [SALES: 🚫]<% }
    if (request.isUserInRole("HUMANR")) { %> [HUMANR: ✔️]<% } else { %> [HUMANR: 🚫]<% }
    if (request.isUserInRole("PURCHASES")) { %> [PURCHASES: ✔️]<% } else { %> [PURCHASES: 🚫]<% }
    if (request.isUserInRole("AUDITOR")) { %> [AUDITOR: ✔️]<% } else { %> [AUDITOR: 🚫]<% }
    %></p>

<h3>Módulo Ventas</h3></td>
<p><a href="ventas/gestion_clientes.jsp">
    <% if (request.isUserInRole("SALES") || (request.isUserInRole("AUDITOR"))) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar clientes</a></p>
<p><a href="ventas/gestion_presupuestos.jsp">
    <% if (request.isUserInRole("SALES")) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar presupuestos</a></p>
<p><a href="ventas/gestion_facturas.jsp">
    <% if (request.isUserInRole("SALES")) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar facturas</a></p>

<h3>Módulo Compras</h3></td>
<p><a href="compras/gestion_proveedores.jsp">
    <% if (request.isUserInRole("PURCHASES")) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar proveedores</a></p>
<p><a href="compras/gestion_compras.jsp">
    <% if (request.isUserInRole("PURCHASES") || (request.isUserInRole("AUDITOR"))) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar compras</a></p>
<p><a href="compras/autorizar_compras.jsp">
    <% if (request.isUserInRole("MANAGEMENT")) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: autorizar compras</a></p>

<h3>Módulo Nóminas</h3></td>
<p><a href="nominas/gestion_trabajadores.jsp">
    <% if (request.isUserInRole("HUMANR")) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar trabajadores</a></p>
<p><a href="nominas/gestion_nominas.jsp">
    <% if (request.isUserInRole("HUMANR") || (request.isUserInRole("AUDITOR"))) { %>✔️ - <% } else { %>🚫 -<% } %>
    &nbsp;Operación: gestionar nóminas</a></p>

<hr>
<a href='<%= response.encodeURL("menu.jsp?logout=true") %>'>Cerrar sesión</a>
<hr>
<div align="right">️️
    ✔️ Granted
    🚫 Denied
</div>
</body>
</html>