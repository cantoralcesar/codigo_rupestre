package com.codigorupestre.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;   // Importante para subida de archivos
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;                    // Para manejar las partes del archivo

import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.io.InputStream;                          // Para leer el contenido del archivo
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;           // Formatear fecha
import java.util.Base64;

/**
 * Servlet implementation class HelloWorld
 */
@WebServlet("/HelloWorld")

//IMPORTANTE: Esta anotación es necesaria para que el Servlet maneje solicitudes multipart/form-data
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB: tamaño en disco antes de escribir en el disco
              maxFileSize = 1024 * 1024 * 10,      // 10MB: tamaño máximo de un archivo subido
              maxRequestSize = 1024 * 1024 * 50)   // 50MB: tamaño máximo de la solicitud (todos los archivos + campos)

public class HelloWorld extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HelloWorld() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. Recopilar los parámetros de texto
		String nombre = request.getParameter("nombre");
		String apellido = request.getParameter("apellido");
		String direccion = request.getParameter("direccion");
		String email = request.getParameter("email");
		String profesion = request.getParameter("profesion");
		String pais = request.getParameter("ciudad");
		String ciudad = request.getParameter("pais");
		
		int zip = 0;
		String mensajeErrorZip = null; // Variable para el mensaje de error del ZIP
		
		try {
		    zip = Integer.parseInt(request.getParameter("zip"));
		} catch (NumberFormatException e) {
		    mensajeErrorZip = "El campo 'Zip' debe ser un número válido.";
		    // Puedes imprimir en consola para depuración, pero el mensaje se enviará al JSP
		    System.err.println("Error al parsear ZIP: " + e.getMessage());
		}
		
		// 2. Lógica para manejar la imagen sin guardar en disco
		String nombreArchivoImagen = null;
		String imagenBase64 = null;        // Aquí guardaremos la imagen codificada en Base64
		String tipoContenidoImagen = null; // Para saber el tipo MIME (ej. "image/jpeg")
		String mensajeSubidaImagen = null;
		
		try {
		    Part filePart = request.getPart("imagenFile");

		    if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
		        nombreArchivoImagen = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
		        tipoContenidoImagen = filePart.getContentType(); // Obtener el tipo MIME del archivo

		        // Leer el contenido del InputStream a un arreglo de bytes
		        try (InputStream fileContent = filePart.getInputStream();
		             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
		            
		            byte[] buffer = new byte[4096]; // Buffer para leer
		            int bytesRead;
		            while ((bytesRead = fileContent.read(buffer)) != -1) {
		                outputStream.write(buffer, 0, bytesRead);
		            }
		            byte[] imageBytes = outputStream.toByteArray(); // Contenido completo de la imagen en bytes

		            // Codificar los bytes de la imagen a Base64
		            imagenBase64 = Base64.getEncoder().encodeToString(imageBytes);

		            mensajeSubidaImagen = "Imagen '" + nombreArchivoImagen + "' capturada y codificada exitosamente.";
		            
		        } catch (IOException ioException) {
		            mensajeSubidaImagen = "Error de E/S al leer la imagen: " + ioException.getMessage();
		            System.err.println("Error de E/S al leer la imagen: " + ioException.getMessage());
		            ioException.printStackTrace();
		        }

		    } else {
		        mensajeSubidaImagen = "No se seleccionó ninguna imagen o el archivo está vacío.";
		    }
		} catch (Exception e) { // Captura ServletException y otras excepciones de getPart()
		    mensajeSubidaImagen = "Error al capturar la imagen: " + e.getMessage();
		    System.err.println("Error en captura de imagen: " + e.getMessage());
		    e.printStackTrace(); 
		}
		
		// 3. Establecer los atributos para el JSP      
		request.setAttribute("nombre", nombre);
		request.setAttribute("apellido", apellido);
		request.setAttribute("email", email);
		request.setAttribute("profesion", profesion);
		request.setAttribute("direccion", direccion);
		request.setAttribute("ciudad", ciudad);
		request.setAttribute("pais", pais);
		request.setAttribute("zip", zip);
		
		//request.setAttribute("creacion",LocalDateTime.now().toString());
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String formattedDateTime = now.format(formatter);
		request.setAttribute("creacion", formattedDateTime);
		
		// Atributos relacionados con la imagen (ahora Base64)
		request.setAttribute("nombreArchivoImagen", nombreArchivoImagen);
		request.setAttribute("imagenBase64", imagenBase64); // La cadena Base64
		request.setAttribute("tipoContenidoImagen", tipoContenidoImagen); // El tipo MIME (ej. "image/png")
		request.setAttribute("mensajeSubidaImagen", mensajeSubidaImagen);
				
		// Atributo para el error del ZIP
		if (mensajeErrorZip != null) {
		   request.setAttribute("errorZip", mensajeErrorZip);
		}
				
		// 4. Reenviar la solicitud al JSP
		request.getRequestDispatcher("/helloworld.jsp").forward(request, response);
	}

}
