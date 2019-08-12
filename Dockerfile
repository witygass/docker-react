# Build phase
FROM node:alpine as builder

WORKDIR /app

COPY package.json .
# Don't need node modules anymore when we've transpiled the app
RUN npm install
COPY . .
RUN npm run build

# Run phase
FROM nginx
COPY --from=builder /app/build  /usr/share/nginx/html
