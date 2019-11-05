# stage: 1
FROM node:dubnium as react-build
WORKDIR /app
COPY . ./
RUN yarn
RUN yarn build

# stage: 2 — the production environment
FROM nginx:alpine
WORKDIR /usr/share/nginx/html
COPY --from=react-build /app/build/index.html ./
COPY --from=react-build /app/build ./mui-calculator
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]