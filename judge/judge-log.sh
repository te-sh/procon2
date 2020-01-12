#!/bin/bash

docker logs -f $(docker-compose ps -q judge)
