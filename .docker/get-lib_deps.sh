#/bin/bash

echo "  [-] Extract libraries"
rm -f lib_deps.txt
dpkg -S $(/sbin/ldconfig -p | awk 'NR>1 { print $NF }') 2>/dev/null | sed 's/\: .*$//' | sort -u >> lib_deps.txt

mv lib_deps.txt dependencies