#!/bin/bash

echo "============== Validate Docker =========="
docker version
docker images
echo "========== Validate Docker Compose ======"
docker-compose  version

echo "============== Validate version =========="
go version

# echo "============== GOPATH =========="
# echo $GOPATH


echo "============== VAlidate NodeJS and NPM =========="
node --version
npm -v