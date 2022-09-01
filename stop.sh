#!/bin/bash

flux suspend kustomization flux-system
flux delete kustomization --silent eks-demo-app
sleep 30

eksctl delete cluster eks-demo --wait
