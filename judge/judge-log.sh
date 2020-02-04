#!/bin/sh

docker logs -f $(docker-compose ps -q judge)
