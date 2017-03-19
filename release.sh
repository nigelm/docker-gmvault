#!/bin/sh

set -ex
# SET THE FOLLOWING VARIABLES
# docker hub username
USERNAME=nigelm
# image name
IMAGE=docker-gmvault

# ensure we're up to date
git pull
# bump version
docker run --rm -v "$PWD":/app treeder/bump patch
version=`cat VERSION`
echo "version: $version"
perl -i -pe "s|\d\.\d\.\d|${version}| if (/org\.freenas\.version=/)" Dockerfile
# run build
./build.sh
# tag it
git add -A
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push
git push --tags
# We use the hooks to do the build
## docker tag $USERNAME/$IMAGE:latest $USERNAME/$IMAGE:$version
## # push it
## docker push $USERNAME/$IMAGE:latest
## docker push $USERNAME/$IMAGE:$version
