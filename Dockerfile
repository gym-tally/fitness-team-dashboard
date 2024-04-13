FROM node AS builder
WORKDIR /app
COPY ./package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/out /usr/share/nginx/html
