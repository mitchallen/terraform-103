terraform-103
==

A Kubernetes and Terraform example

[![Ko-fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/mitchallen)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/mitchallen)

## Using Make

This project includes a Makefile with helpful targets for common Terraform and Kubernetes tasks. Use `make help` to see available commands, and use targets like `make up`, `make get-services`, and `make check-nodeport` to streamline your workflow.

### Using `make up`

The `make up` target will:
- Check if Docker is running (and exit with a message if not)
- Check if your local Kubernetes cluster is available (and exit with a message if not)
- Run `terraform init`, `terraform plan`, and `terraform apply -auto-approve`
- Show the status of your pods with `kubectl get pod`

This is a convenient way to initialize, plan, and apply your Terraform configuration and verify your Kubernetes pods are running—all in one step.

```sh
make up
```

### After the server is running

Once your server is up, you can use the following Makefile targets to interact with your deployment:

- `make check-nodeport`: Get the NodePort and verify the service is responding with JSON using curl.
- `make get-nodeport`: Retrieve the NodePort for the random-example service.
- `make get-services`: List all services in your current Kubernetes namespace.

These commands help you quickly verify and interact with your running Kubernetes service.

### Cleaning up resources

To keep costs down and avoid running unnecessary resources, always run:

```sh
make destroy
```

when you are finished. This will destroy all Terraform-managed infrastructure and help ensure your environment is clean.

## Usage

### Install Terraform (Mac)

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform version
```

## Make sure Docker is running

### See if the docker daemon is running

```sh
docker ps
```

### Install Docker Desktop

If you need to install docker:

* https://docs.docker.com/desktop/install/mac-install/

### Open Docker Desktop

This will start the docker daemon if it isn't running:

```sh
open -a Docker
```

Check it again:

```sh
docker ps
```

## Kubernetes

### Enable Kubernetes

* Docker Desktop / Preferences 
* Enable Kubernetes
* Be sure to Apply and Restart

### Install kubectl

See: https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/

## Terraform

### Init the plan

```sh
terraform init
``` 

### Run the plan

```sh
terraform plan
```

### Apply the plan

```sh
terraform apply
```

### Verify the server is up

Check to see that the pod is running:

```sh
kubectl get pod
```

Expected:

```sh
NAME                READY     STATUS    RESTARTS   AGE
random-example      1/1       Running   1          80s
```

### Find the NodePort

```sh
kubectl get svc random-example -o jsonpath='{.spec.ports[0].nodePort}'
```

Replace **NODE_PORT** with the port returned above:

```sh
curl http://localhost:NOTE_PORT            

curl http://localhost:NODE_PORT/v1/people/1

curl http://localhost:NODE_PORT/v1/words/1

curl http://localhost:NODE_PORT/v1/values/1

curl http://localhost:NODE_PORT/v1/coords/1
```

### Destroy the plan

```sh
terraform destroy
```

### Verify the container is gone

```sh
docker ps
```

## kubectl commands

```sh
kubectl get svc random-example -o jsonpath='{.spec.ports[0].nodePort}'
```

```sh
kubectl get services

NAME                TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
kubernetes          ClusterIP   10.96.0.1        <none>        443/TCP        179m
random-example      NodePort    10.103.222.154   <none>        80:30590/TCP   117s
```

Note that in this example 30590 is the nodeport


## References

* https://kubernetes.io/docs/reference/kubectl/cheatsheet/
* https://medium.com/@naswani91/in-this-blog-we-will-discuss-what-is-terraform-kubernetes-provider-how-to-use-it-and-difference-f576158b1531
* https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs
* https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service
* https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/
* https://gist.github.com/ivaravko/501b4e8e5f1bc1bf5fecd149186b99b9
* https://developer.hashicorp.com/terraform/cli/commands/plan
* https://spacelift.io/blog/terraform-plan
* https://developer.hashicorp.com/terraform/downloads
* https://hub.docker.com/r/mitchallen/random-server
* https://dev.to/pavanbelagatti/using-terraform-to-manage-infrastructure-resources-32da
* https://dockerlabs.collabnix.com/advanced/automation/terraform/terraform-mac-nginx.html
* https://developer.hashicorp.com/terraform/tutorials/docker-get-started/docker-build
* https://stackoverflow.com/questions/73451024/where-to-find-information-about-the-following-terraform-provider-attribute-depre
* https://raw.githubusercontent.com/github/gitignore/main/Terraform.gitignore
