<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">

<title>Formulario de Registro</title>
</head>
<body>

   <div class="container mt-5"> 
       <div class="card">
           <div class="card-header bg-primary text-white">
              <h4 class="mb-0">Formulario de Registro</h4>
           </div>
          
          <%-- IMPORTANTE: Añadir enctype="multipart/form-data" para la subida de archivos --%>
           <form action="HelloWorld" method="post" class="card-body" enctype="multipart/form-data">
            
               <div class="row">
                   <div class="col-md-6 mb-3">
                      <label for="nombre" class="form-label">Nombres</label>
                      <input type="text" class="form-control" id="nombre" name="nombre"required>
                   </div>
                
                   <div class="col-md-6 mb-3">
                      <label for="apellido" class="form-label">Apellidos</label>
                      <input type="text" class="form-control" id="apellido" name="apellido" required>
                   </div>
               </div>
               
               <div class="row">
                   <div class="col-md-6 mb-3">
                      <label for="nombre" class="form-label">Email</label>
                      <input type="email" class="form-control" id="email" name="email"required>
                   </div>
                
                   <div class="col-md-6 mb-3">
                      <label for="profesion" class="form-label">Profesión</label>
                      <select class="form-select" id="profesion" name="profesion" required>
                         <option value="">Selecciona tu profesión...</option>
                         <option value="Consultor">Consultor Junior</option>
                         <option value="Desarrollo">Desarrollo Web</option>
                         <option value="Programador">Programador Web</option>
                         <option value="Analista">Analista</option>
                         <option value="Arquitecto">Arquitecto de Software</option>
                      </select>
                   </div>
               </div>
               
               <div class="col-12 mb-3">
                   <label for="direccion" class="form-label">Dirección</label>
                   <input type="text" class="form-control" id="direccion" name="direccion"required>
               </div>
               <div class="row">
                  <div class="col-md-6">
                     <label for="ciudad" class="form-label">Ciudad</label>
                     <input type="text" class="form-control" id="ciudad" name="ciudad"required >
                  </div>
               
                  <div class="col-md-4">
                      <label for="pais" class="form-label">País</label>
                      <select class="form-select" id="pais" name="pais" required>
                         <option value="">Selecciona tu país...</option>
                         <option value="Colombia">Colombia</option>
                         <option value="Peru">Perú</option>
                         <option value="Argentina">Argentina</option>
                         <option value="España">España</option>
                         <option value="Mexico">México</option>
                      </select>
                  </div>
               
                  <div class="col-md-2 mb-3">
                     <label for="zip" class="form-label">Zip</label>
                     <input type="text" class="form-control" id="zip" name="zip" required>
                  </div>
               </div>
               
               <%-- Nuevo campo para la imagen --%>
               <div class="col-6 mb-3">
                   <label for="imagenFile" class="form-label">Subir Imagen</label>
                   <input type="file" class="form-control" id="imagenFile" name="imagenFile" accept="image/*">
               </div>
               
               <button type="submit" class="btn btn-success">Registrar</button>
            </form>
       </div>
   </div>
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>
</html>
