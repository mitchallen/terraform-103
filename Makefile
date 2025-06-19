# Makefile for Terraform project

FMT = terraform fmt -recursive
INIT = terraform init
VALIDATE = terraform validate
PLAN = terraform plan
APPLY = terraform apply

.PHONY: all fmt init validate plan apply help

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

help:
	@echo "Usage: make [target]"
	@echo "Targets:"
	@echo "  fmt       Run terraform fmt -recursive"
	@echo "  init      Run terraform init"
	@echo "  validate  Run terraform validate"
	@echo "  plan      Run terraform plan"
	@echo "  apply     Run terraform apply"

.DEFAULT_GOAL := help
