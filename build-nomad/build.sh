#! /bin/sh

docker rmi local/tmp
docker build -t local/tmp . || exit 1
ctid=$(docker run -d local/tmp exit)
docker cp $ctid:/nomad ./
docker rm $ctid
#docker rmi local/tmp
zip nomad.zip nomad
mkdir -p ../ansible/roles/nomad/files/
cp nomad.zip ../ansible/roles/nomad/files/
