#!/bin/bash
echo "*** Building image..."
docker build -t my-image . --platform amd64
echo "*** Image successfully built."
echo
echo "*****************************"
echo

echo "*** Running container..."
docker run --env-file .local/env my-image
