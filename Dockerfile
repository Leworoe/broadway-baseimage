FROM ubuntu:latest

ENV GDK_BACKEND="broadway"
ENV BROADWAY_DISPLAY=":5"
ENV DARK_MODE="false"

RUN apt update && apt upgrade -y
RUN apt install -y --no-install-recommends libgtk-3-0 libgtk-3-bin nginx gettext-base tmux wget materia-gtk-theme papirus-icon-theme gnome-icon-theme
RUN apt clean && apt autoclean && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate -O /usr/bin/ttyd "https://github.com/tsl0922/ttyd/releases/latest/download/ttyd.$(uname -m)"
RUN chmod +x /usr/bin/ttyd

COPY start.sh /usr/local/bin/start
COPY nginx.tmpl /etc/nginx/nginx.tmpl
COPY terminal-outline.svg /www/data/images/terminal-outline.svg
EXPOSE 80

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/usr/local/bin/start"]
