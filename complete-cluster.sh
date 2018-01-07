#!/usr/bin/env bash
gcloud container clusters create gribd-cluster-1 --cluster-version=1.8.5-gke.0  --num-nodes=3 --machine-type=f1-micro

# deploy influx
kubectl create -f influx.yml --save-config
kubectl create -f influx-service.yml

## deploy grafana
kubectl apply -f grafana-config.yml
kubectl create -f grafana.yml --save-config
kubectl create -f grafana-service.yml


## deploy cron

kubectl create -f ./cron-yr.yml --save-config