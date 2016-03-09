# docker-oracle-xe

Docker Container for Oracle XE

## Requirements

Building this container requires that a version of the oracle xe rpm be present in the build directory.  The current latest version is ```oracle-xe-11.2.0-1.0.x86_64.rpm``` - but it should be possible to substitute this with another version, provided that the Dockerfile is updated accordingly.

At time of writing, the oracle xe rpm can be found here:  http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

Python is also required to be present on the build system.

## How to build the docker image from this repo

Ensure that you have the oracle xe rpm present.  Python will be used to start a temporary http server in your build directory, and the docker build process will pull the install file into the container from here.

```bash
./build.sh
```

This should create a docker container with oracle xe deployed and configured within it.  It does *not* start oracle-xe.  The suggestion is that this container should be used as the basis for your own oracle xe container implementation.


