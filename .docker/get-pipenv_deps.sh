#/bin/bash

echo "  [-] Extract pipenv graph"
rm -f pipenv_graph.txt
pipenv graph >> pipenv_graph.txt

echo "  [-] Parse pipenv graph"
rm -f pipenv_graph.csv
echo "package, version" > pipenv_graph.csv
awk '{print $1}' pipenv_graph.txt | awk '!/^-/' | awk -F"==" '{print $1 ", " $2}' >> pipenv_graph.csv

echo "  [-] Parse pipfile"
rm -f pipfile_deps.csv
echo "package, version" > pipfile_deps.csv
awk '/\[packages\]/{flag=1;next}/\[dev-packages\]/{flag=0}flag' Pipfile | awk 'NF > 0' | awk -F" = " '{print $1 ", " $2}' | sed 's/"//g' >> pipfile_deps.csv

mv pipenv_graph.txt dependencies
mv pipenv_graph.csv dependencies
mv pipfile_deps.csv dependencies