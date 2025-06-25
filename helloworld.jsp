<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<title>Información del Aprendiz</title>

<style>
    .error-message {
        color: red;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .success-message {
        color: green;
        font-weight: bold;
        margin-bottom: 10px;
    }
    .card-body img {
        max-width: 100%;
        height: auto;
        display: block;
        margin-top: 15px;
        border: 1px solid #ddd;
        padding: 5px;
        background-color: #fff;
    }
</style>
</head>
<body>

   <div class="container mt-4">
   
       <div class="card shadow-sm"> 
       <div class="card-header bg-primary text-white text-center"> 
           <h1>Información del Aprendiz</h1>
       </div>
       
       <div class="card-body"> <%-- Añadido card-body para el contenido --%>
           <%-- Mostrar mensaje de error del ZIP si existe (usando scriptlet) --%>
           <%
               String errorZip = (String) request.getAttribute("errorZip");
               if (errorZip != null && !errorZip.isEmpty()) {
           %>
               <p class="error-message"><%= errorZip %></p>
           <%
               }
           %>

           <div class="row"> 
              <div class="col-md-8">
                 <ul class="list-group list-group-flush"> <%-- Corregido "lis-group-flush" a "list-group-flush" --%>
                    <li class="list-group-item"><strong>Nombres: </strong>${nombre}</li>
                    <li class="list-group-item"><strong>Apellidos: </strong>${apellido}</li>
                    <li class="list-group-item"><strong>Email: </strong>${email}</li>
                    <li class="list-group-item"><strong>Profesión: </strong>${profesion}</li>
                    <li class="list-group-item"><strong>Dirección: </strong>${direccion}</li>
                    <li class="list-group-item"><strong>Ciudad: </strong>${ciudad}</li>
                    <li class="list-group-item"><strong>País: </strong>${pais}</li>
                    <li class="list-group-item"><strong>Zip: </strong>${zip}</li>
                 
                    <li class="list-group-item"><strong>Creación: </strong>${creacion}</li>
                 </ul>
              </div>
              
              <div class="col-md-4">
                 <h4>Imagen Capturada</h4>
                 <%-- Mostrar mensaje de subida de imagen (usando scriptlet) --%>
                 <%
                     String mensajeSubidaImagen = (String) request.getAttribute("mensajeSubidaImagen");
                     if (mensajeSubidaImagen != null && !mensajeSubidaImagen.isEmpty()) {
                 %>
                     <p class="success-message"><%= mensajeSubidaImagen %></p>
                 <%
                     }
                 %>

                 <%-- Mostrar la imagen si está codificada en Base64 --%>
                 <%
                     String imagenBase64 = (String) request.getAttribute("imagenBase64");
                     String tipoContenidoImagen = (String) request.getAttribute("tipoContenidoImagen");

                     if (imagenBase64 != null && !imagenBase64.isEmpty() && tipoContenidoImagen != null) {
                 %>
                     <img src="data:<%= tipoContenidoImagen %>;base64,<%= imagenBase64 %>" alt="Imagen Capturada">
                 <%
                     } else {
                 %>
                     <p>No se pudo mostrar la imagen.</p>
                 <%
                     }
                 %>
              </div>
              
            </div>
        </div> <%-- Cierre del card-body --%>
     </div>
   </div>
 
</body>
</html>
