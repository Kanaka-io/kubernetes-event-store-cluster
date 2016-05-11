#!/usr/bin/env bash

gcloud config set project aztechiot
gcloud config set container/cluster $1
gcloud container clusters get-credentials $1

kubectl delete -f kubernetes/mqtt-broker-service.yaml
kubectl delete -f kubernetes/mqtt-broker-controller.yaml
kubectl delete -f kubernetes/eventstore-lb.yaml
kubectl delete -f kubernetes/eventstore-service.yaml
kubectl delete -f kubernetes/eventstore-controller.yaml
kubectl delete -f kubernetes/volumes.yaml
