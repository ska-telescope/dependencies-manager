#/bin/bash

echo "Building clean docker images"
docker build -t spsr . --no-cache --rm

echo "Get dependencies"
./get-deps.sh
