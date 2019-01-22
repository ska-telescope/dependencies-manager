#/bin/bash

echo "  [-] Extract system packages"
rm -f system_deps.txt
dpkg -l >> system_deps.txt

echo "  [-] Parse system packages"
rm -f system_deps.csv
echo "package, version" > system_deps.csv
awk 'FNR>5 {print $2 ", " $3}' system_deps.txt >> system_deps.csv

mv system_deps.txt /tmp/dependencies
mv system_deps.csv /tmp/dependencies