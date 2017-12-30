
This project is work in progress as I am learning more about kubernetes, use with caution

# set up cluster on GKE with gcloud cli

    # get list of your projects
    gcloud projects list
    
    # set current project
    gcloud config set project gribdown
    
    # set compute-zone
    # see valid zones at https://cloud.google.com/compute/docs/regions-zones/#available 
    gcloud config set compute/zone us-central1-a
    
    # create cluster "gribd-cluster-1" (takes a while)
    gcloud container clusters create gribd-cluster-1 --num-nodes=3 --machine-type=f1-micro
    
    # get authentication to use with kubectl
    gcloud container clusters get-credentials gribd-cluster-1 
    
    # create some persistent disks
    gcloud compute disks create --size 200GB influxdisk
    
## delete cluster
    
    # delete cluster "gribd-cluster-1"
    gcloud container clusters delete gribd-cluster-1 
    
    gcloud compute disks delete influxdisk
    
# deploy cluster

watch updates:

    $ kubectl get pods --watch
    $ kubectl get services --watch

## deploy influx

    $ kubectl create -f influx.yml --save-config
    $ kubectl create -f influx-service.yml

## deploy grafana

    $ kubectl create -f grafana.yml --save-config
    $ kubectl create -f grafana-service.yml
    
## update deployments

    $ kubectl apply -f <updatedfile.yml>
    
    
# TODOS

build a grafana-image with datasource and dashboards pre-configured
