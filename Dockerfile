## --- Running as Dev serve without [STatic files] Build---- #
# --- Without @angular/cli installation in global ----
# FROM node
# WORKDIR /app
# COPY package.json .
# RUN npm install
# COPY . .
# CMD ["npx", "ng", "serve", "--host", "0.0.0.0", "--port", "4200"]

# --- With @angular/cli installation in global [Not recommended as Docker layer increares inturn increasing docker image size] ----
# FROM node
# WORKDIR /app
# COPY package.json .
# RUN npm install -g @angular/cli
# RUN npm install
# COPY . .
# CMD ["ng", "serve", "--host", "0.0.0.0", "--port", "4200"]

## --- Running as Prod serve with Build[STatic files] [/dist]---- #

FROM node AS build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm install -g @angular/cli 
RUN ng build

FROM nginx
COPY --from=build /app/dist/angular-docker/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]