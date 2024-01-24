#!/bin/bash

# URL del endpoint de autenticación
AUTH_URL="http://localhost:8081/api/v1/auth/signin"

# ID del libro que deseas eliminar
LIBRO_ID="211"  # Reemplaza con el ID real del libro que deseas eliminar

# URL del endpoint protegido para eliminar libros
PROTECTED_URL="http://localhost:8081/api/v1/libros/$LIBRO_ID"

# Datos de autenticación
AUTH_DATA='{
    "email": "bob.smith@example.com",
    "password": "password456"
}'

# Realiza la solicitud POST para obtener el token
response=$(curl -s -X POST -H "Content-Type:application/json" --data "$AUTH_DATA" $AUTH_URL)

# Extrae el token JWT de la respuesta usando grep y cut
token=$(echo $response | grep -o '"token":"[^"]*' | cut -d'"' -f4)

# Verifica si se obtuvo un token
if [ -z "$token" ]; then
    echo "No se pudo obtener el token JWT"
    exit 1
fi

# Realiza la solicitud DELETE para eliminar un libro usando el token JWT
curl -v -X DELETE -H "Authorization: Bearer $token" $PROTECTED_URL
