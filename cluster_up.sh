#!/usr/bin/env bash


gcloud config set project aztechiot
gcloud config set container/cluster $1
gcloud container clusters get-credentials $1

kubectl create -f kubernetes/volumes.yaml


kubectl create -f kubernetes/eventstore-controller.yaml
kubectl create -f kubernetes/eventstore-service.yaml
kubectl create -f kubernetes/eventstore-lb.yaml

sleep 60

kubectl create -f kubernetes/mqtt-broker-controller.yaml
kubectl create -f kubernetes/mqtt-broker-service.yaml

kubectl get services
