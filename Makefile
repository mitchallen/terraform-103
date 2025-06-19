# Makefile for Terraform project

FMT = terraform fmt -recursive
INIT = terraform init
VALIDATE = terraform validate
PLAN = terraform plan
APPLY = terraform apply

.PHONY: all fmt init validate plan apply help up kube-system-status

all: fmt init validate plan

fmt:
	$(FMT)

init:
	$(INIT)

validate:
	$(VALIDATE)

plan:
	$(PLAN)

apply:
	$(APPLY)

up:
	@if ! docker info > /dev/null 2>&1; then \
		echo "Docker is not running. Please start Docker and try again."; \
		exit 1; \
	fi
	@if ! kubectl cluster-info > /dev/null 2>&1; then \
		echo "Kubernetes cluster is not available. Please start your local Kubernetes cluster and try again."; \
		exit 1; \
	fi
	$(INIT)
	$(PLAN)
	$(APPLY) -auto-approve
	kubectl get pod

kube-system-status:
	kubectl get all -n kube-system

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  fmt       Run terraform fmt -recursive"
	@echo "  init      Run terraform init"
	@echo "  validate  Run terraform validate"
	@echo "  plan      Run terraform plan"
	@echo "  apply     Run terraform apply"
	@echo "  up        Check if Docker is running, then run init, plan, apply, and kubectl get pod"
	@echo "  kube-system-status  Show the status of all resources in the kube-system namespace"

.DEFAULT_GOAL := help
