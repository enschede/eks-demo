#!/bin/bash

AWS_ACCOUNT_ID=$(aws --output json sts get-caller-identity  | jq -r '.Account')

eksctl create cluster -f eks-demo.yaml

kubectl create secret generic aws --namespace flux-system \
  --from-literal=AWS_ACCOUNT_ID=$AWS_ACCOUNT_ID \
  --from-literal=AWS_REGION=us-west-2 \
  --from-literal=CLUSTER_NAME=eks-demo &

kubectl create secret generic github-credentials --namespace flux-system \
  --from-literal=username=$GITHUB_USER \
  --from-literal=password=$GITHUB_TOKEN &
