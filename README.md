# python-oracle-img
A docker image with python and oracle

## build image
`docker build -t my-image .`

## create a runtine configuration file
* copy `.local/env.example` to `.local/env`
* adjust values to connect to your own Oracle database

## run it
`docker run --env-file .local/env my-image`

## explore image content
`docker run -it --entrypoint "" my-image bash`

## Build and run in one single convenient command
`./run.sh`
