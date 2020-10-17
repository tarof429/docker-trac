#!/bin/sh

IMAGE="tarof429/docker-trac"

echo "Building git revision ${SHA}"

docker build -t ${IMAGE}:latest -t ${IMAGE}:${SHA} .

echo "Pushing images to dockerhub"
docker push ${IMAGE}:latest
docker push ${IMAGE}:${SHA}

echo "Cleaning up images"
docker rmi ${IMAGE}:latest ${IMAGE}:${SHA}

echo "Running ansible scripts"
cd ansible
echo "Running ansible-playbook -e SHA=${SHA} deploy_to_k8s.yml"
ansible-playbook -e "SHA=${SHA}" deploy_to_k8s.yml