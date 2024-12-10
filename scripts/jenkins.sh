#!/bin/bash

# Ensure Terraform is installed
terraform --version

# Function to initialize Terraform
init() {
    echo "Initializing Terraform..."
    terraform init
}

# Function to run terraform plan
plan() {
    echo "Running Terraform Plan..."
    terraform plan -out=tfplan
}

# Function to apply terraform plan
apply() {
    echo "Applying Terraform configuration..."
    terraform apply -auto-approve tfplan
}

# Function to destroy terraform infrastructure
destroy() {
    echo "Destroying Terraform infrastructure..."
    terraform destroy -auto-approve
}

# Choose the correct function based on the script argument
case "$1" in
    init)
        init
        ;;
    plan)
        plan
        ;;
    apply)
        apply
        ;;
    destroy)
        destroy
        ;;
    *)
        echo "Usage: $0 {init|plan|apply|destroy}"
        exit 1
        ;;
esac
