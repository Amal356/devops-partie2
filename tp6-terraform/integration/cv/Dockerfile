FROM nginx:alpine
COPY index.html style.css /usr/share/nginx/html/
# Le nom du serveur (variable CV_HOST) est injecte au demarrage du conteneur
RUN printf '#!/bin/sh\nsed -i "s/__HOST__/${CV_HOST:-nginx}/" /usr/share/nginx/html/index.html\n' > /docker-entrypoint.d/99-cv-host.sh \
 && chmod +x /docker-entrypoint.d/99-cv-host.sh
EXPOSE 80
