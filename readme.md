## Intro 

The ArgoCD app-of-app pattern involves defining an application (app) that deploys other apps.


![](https://github.com/nkzk/example-argo-gitops-repo/blob/main/argo.gif)

In the gif above, `.bootstrap/dev.yaml` creates an App that points to the `dev` directory in this repository.

The `dev` directory in this repository contains the manifests for the desired ArgoCD Projects and Applications.

The `bootstrap` ArgoApp will make sure the ArgoProjects and Argoapps defined in `dev` exists when pressing `Sync`




The process of adding new applications could be further streamlined with a Backstage template.

## Running locally:


Run `./.local/install.sh` script to create local Kind-cluster and start argoCD

Create bootstrap app with `kubectl apply -f .bootstrap/dev.yaml`
