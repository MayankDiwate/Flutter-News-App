FROM fischerscode/flutter-sudo:3.7.12 as build

WORKDIR /usr/src/app

# Install dependencies
COPY pubspec.* ./
RUN sudo chmod 777 pubspec.*
RUN flutter pub get

# Copy rest of the app
COPY . .
RUN sudo chmod 777 pubspec.*
RUN flutter build web

FROM cgr.dev/chainguard/nginx:latest

# Copy built web app
COPY --from=build /usr/src/app/build/web /usr/share/nginx/html

EXPOSE 8080