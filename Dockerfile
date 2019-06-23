# Stage 0, "build-stage", based on Node.js, to build and compile the frontend
FROM node:12.4.0-alpine as build-stage
WORKDIR /app
COPY flask-app/ .
RUN npm install \
    && npm run build

# Stage 1, based on Nginx, to have only the compiled app, ready for production with Nginx
FROM nginx:1.15
COPY --from=build-stage /app/ /usr/share/nginx/html
COPY flask-app/templates/ /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
