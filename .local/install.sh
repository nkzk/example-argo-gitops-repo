#!/bin/bash

GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
NORMAL=$(tput sgr0)
BRIGHT=$(tput bold)
COLOR=$BLUE
STAR='\U1F31F'

kind create cluster --name my-cluster --config ./kind-config.yaml

printf "\n${STAR}${COLOR}installing nginx ingress controller...${NORMAL}\n"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

printf "\n${STAR}${COLOR}waiting for ingress controller to get ready...${NORMAL}\n"
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

printf "\n${STAR}${COLOR}installing argocd...${NORMAL}\n"
kubectl apply -k argocd

printf "\n${STAR}${COLOR}waiting for argocd to get ready...${NORMAL}\n"
kubectl wait -n argocd \
  --for=condition=ready pod \
  --timeout=90s \
  --selector=app.kubernetes.io/name=argocd-server

argo_password=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argo_host=$(kubectl -n argocd get ingress argocd-server-ingress -o jsonpath="{.spec.rules[0].host}")
argo_path=$(kubectl get ingress -n argocd argocd-server-ingress -o jsonpath="{.spec.rules[0].http.paths[0].path}")
printf "\nArgoCD now available at http://${argo_host:=localhost}$argo_path"
printf "\nusername: ${BRIGHT}admin${NORMAL}"
printf "\npassword: ${BRIGHT}$argo_password${NORMAL}"

printf "\n\nNOTE:"
printf "\nbootstrap argocd with:"
printf "\n > kubectl apply -f argocd-bootstrapper.yaml"