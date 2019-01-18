#/bin/bash

echo "Get python dependencies"
rm -f pipenv_deps.txt
touch pipenv_deps.txt
docker run --name python_bash -v ${PWD}/pipenv_deps.txt:/tmp/ska-skeleton/pipenv_deps.txt --rm -t spsr /bin/bash -c "cd /tmp/ska-skeleton && pipenv graph >> pipenv_deps.txt"

echo "Get system dependencies"
rm -f system_deps.txt
touch system_deps.txt
docker run --name python_bash -v ${PWD}/system_deps.txt:/tmp/ska-skeleton/system_deps.txt --rm -t spsr /bin/bash -c "cd /tmp/ska-skeleton && dpkg -l >> system_deps.txt"

echo "Parse system dependencies"
echo "package, version" > system_deps.csv
awk 'FNR>5 {print $2 ", " $3}' system_deps.txt >> system_deps.csv