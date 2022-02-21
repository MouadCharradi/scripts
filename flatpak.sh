#!/bin/bash

flatpak install $2
touch /bin/$1
printf '#!/bin/sh\n\nflatpak run %s' "$2" > /bin/$1
chmod 755 /bin/$1
