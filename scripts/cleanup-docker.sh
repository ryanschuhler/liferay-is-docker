#!/bin/bash -x

docker rm $(docker ps -a -q)

docker rmi $(docker images --filter "dangling=true" -q --no-trunc)