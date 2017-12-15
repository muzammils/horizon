# Table of Contents

- [Basic Horizon Layout](#basic-horizon-layout)
	- [/defaults](#defaults)
	- [/templates](#templates)
	- [/env](#env)
	- [/logs](#logs)
	- [/global.yaml](#globalyaml)
- [Horizon in Action](#horizon-in-action)
- [Adding a New Account](#adding-a-new-account)

# Basic Horizon Layout

## /defaults

Configuration data, in files laid out as:

`defaults/<account_name>/<environment>.<region>.<component>.vars`

* account\_name: short name of the set of accounts (e.g. soa\_core, microservices, etc)
* environment: the environment, or pipeline\_phase to affect (e.g. infra-pipeline, integ, prod)
* region: the region to affect on. (e.g. us-west-2, eu-east-1, etc)
    * Note: we also treat "global" as a pseudo region for non-region-specific resources, like IAM.
* component: further sub-grouping to isolate things to a particular app or component (e.g. chime, k8s, etc)

## /templates

This is the source of all terraform code. files are laid out as:

`templates/<account_name>/<vpc_name>/*.tf`
`templates/<account_name>/<vpc_name>/<component>/*.tf`

* Note: we also treat "global" as a pseudo VPC for non-VPC-specific resources, like IAM

## /env

Actual state of resources. Includes symlinks to files in `/defaults` and `/templates`, along with resulting `*.tfstate` files.

## /logs

The logs with output generated by terraform.

## /global.yaml

Contains variables/resource names that are shared from the global template
directory, with all other template directories for a given account.

# Horizon in Action

* Running Horizon against component_vpc will add peering routes in the infra_vpc routing tables.
  Running Horizon against infra_vpc will wipe those routes, so Horizon needs a subsequent run against
  component_vpc to recreate those routes.
* Bastion hosts reside in ASG's and can be rebuilt by terminating the EC2 instance. The user_data
  with pull the Ansible artifact from Nexus and run the bastion playbook locally.

# Adding a New Account

Follow the instructions in [Add a New Account](./docs/add_account.md)
