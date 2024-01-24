#!/bin/bash

# URL del endpoint para realizar la reserva
RESERVA_URL="http://localhost:8081/api/v1/libros/212/reservar"  # Reemplaza 123 con el ID del libro que deseas reservar

# Datos de autenticación
AUTH_DATA='{"email":"alice.johnson@example.com",
"password":"password123"}'

# Realiza la solicitud POST para obtener el token
response=$(curl -s -X POST -H "Content-Type:application/json" --data "$AUTH_DATA" http://localhost:8081/api/v1/auth/signin)

# Extrae el token JWT de la respuesta usando grep y cut
token=$(echo $response | grep -o '"token":"[^"]*' | cut -d'"' -f4)

# Verifica si se obtuvo un token
if [ -z "$token" ]; then
    echo "No se pudo obtener el token JWT"
    exit 1
fi

# Realiza la solicitud POST para realizar la reserva usando el token JWT
curl -v -X POST -H "Authorization: Bearer $token" $RESERVA_URL
