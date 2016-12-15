#!/usr/bin/env bash

cd java-server
./gradlew installDist
./build/install/examples/bin/hello-world-server
