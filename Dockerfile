# Etapa 1: Construcción del proyecto
FROM node:20-alpine AS build
WORKDIR /app

# Instalar dependencias
COPY package*.json ./
RUN npm ci

# Copiar el resto de los archivos y construir
COPY . .
RUN npm run build

# Etapa 2: Servidor web ligero para servir la aplicación
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
