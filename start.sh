#!/bin/bash

eksctl create cluster -f eks-demo.yaml

helm repo add eks https://aws.github.io/eks-charts

helm install aws-load-balancer-controller \
  eks/aws-load-balancer-controller \
  --namespace kube-system \
  --set clusterName=eks-demo \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

kubectl apply -f eks-demo-app/deployment/service.yaml
kubectl apply -f eks-demo-app/deployment/deployment.yaml
kubectl apply -f eks-demo-app/deployment/ingress.yaml
