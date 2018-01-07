
This project is work in progress as I am learning more about kubernetes, use with caution


## References

* GKE Quickstart 
https://cloud.google.com/kubernetes-engine/docs/quickstart
* Kubernetes 101 
https://kubernetes.io/docs/user-guide/walkthrough/

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

    $ kubectl apply -f grafana-config.yml
    $ kubectl create -f grafana.yml --save-config
    $ kubectl create -f grafana-service.yml
    
## cron-job to fill data (experimental, needs kubernetes 1.8+)

With gcloud, you need to create the cluster with the version option. For example:

    $ gcloud container clusters create gribd-cluster-1 --cluster-version=1.8.5-gke.0  --num-nodes=3 --machine-type=f1-micro

To create the cron-job, execute

    $ kubectl create -f ./cron-yr.yaml --save-config
    
    
## update deployments

    $ kubectl apply -f <updatedfile.yml>
    

## debugging pods

    # logs for a pod:
    $ kubectl logs <podname>

    # describe pods:
    $ kubectl describe pods <podname>
    
    # ssh into pod:
    $ kubectl exec -it <podname> -- /bin/bash
