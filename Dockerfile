FROM node:20-alpine AS builder
WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN --mount=type=cache,target=/root/.npm npm ci
COPY . .
RUN npm run build

FROM nginx:1.25.4-alpine
COPY --from=builder /app/out /usr/share/nginx/html
