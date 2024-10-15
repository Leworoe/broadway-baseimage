#!/bin/bash
set -e
if [ $DARK_MODE = true ] ; then
  export TERM_COLOR="filter: invert(14%) sepia(7%) saturate(14%) hue-rotate(16deg) brightness(102%) contrast(90%);"
  export GTK_THEME="Materia-dark"
  export BG_GRADIENT="#111, #222"
  rm -rf /usr/share/icons/hicolor && ln -s Papirus-Dark /usr/share/icons/hicolor
else
  export TERM_COLOR=""
  export GTK_THEME="Materia-light"
  export BG_GRADIENT="#ddd, #999"
  rm -rf /usr/share/icons/hicolor && ln -s Papirus-Light /usr/share/icons/hicolor
fi
envsubst '$$BG_GRADIENT $$FAVICON_URL $$APP_TITLE $$CORNER_IMAGE_URL $$TERM_COLOR' < /etc/nginx/nginx.tmpl > /etc/nginx/sites-enabled/default && nginx -g 'daemon off;' &
nohup /usr/bin/broadwayd :5 &> /var/log/broadway.log &
tmux new-session -d -s "ttyd" "tmux set -g status off && /bin/bash"
ttyd -W tmux a -t ttyd &
