## Intro 

The ArgoCD app-of-app pattern involves defining an application (app) that deploys other apps.


![](https://github.com/nkzk/example-argo-gitops-repo/blob/main/argo.gif)


In the GIF above, `.bootstrap/dev.yaml` creates an app configured with this repository URL and the "dev" directory as path:

```
    path: 'dev'
    repoURL: 'https://github.com/nkzk/example-argo-gitops-repo.git'

```

The `dev` directory/path contains the manifests for the desired ArgoCD Projects and Applications.


When pressing sync on the bootstrap-app, all the projects and applications defined in the `dev` directory will be created.


The process of adding new apps to this project could be further streamlined with a Backstage template.


## Running locally:


Run `./.local/install.sh` script to create local Kind-cluster and start argoCD

Create bootstrap app with `kubectl apply -f .bootstrap/dev.yaml`