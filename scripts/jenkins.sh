#!/bin/bash

# Set strict mode for better error handling
set -euo pipefail

# Log file for tracking script execution
LOG_FILE="/var/log/jenkins/terraform_deployment.log"

# Ensure log directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Function to log messages
log_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to handle errors
error_exit() {
    log_message "ERROR: $1"
    exit 1
}

# Function to validate Terraform configuration
validate_terraform() {
    log_message "Validating Terraform configuration..."
    terraform validate || error_exit "Terraform validation failed"
}

# Initialize Terraform
init_terraform() {
    log_message "Initializing Terraform..."
    terraform init \
        -input=false \
        -backend=true \
        || error_exit "Terraform initialization failed"
}

# Plan Terraform changes
plan_terraform() {
    log_message "Planning Terraform changes..."
    terraform plan \
        -input=false \
        -out=tfplan \
        || error_exit "Terraform plan failed"
}

# Apply Terraform changes
apply_terraform() {
    log_message "Applying Terraform changes..."
    terraform apply \
        -input=false \
        -auto-approve \
        tfplan \
        || error_exit "Terraform apply failed"
}

# Destroy Terraform infrastructure
destroy_terraform() {
    log_message "Destroying Terraform infrastructure..."
    terraform destroy \
        -input=false \
        -auto-approve \
        || error_exit "Terraform destroy failed"
}

# Main script logic
main() {
    # Change to the directory containing Terraform files
    cd "$(dirname "$0")/.."

    # Ensure AWS credentials are available
    if [[ -z "${AWS_ACCESS_KEY_ID:-}" || -z "${AWS_SECRET_ACCESS_KEY:-}" ]]; then
        error_exit "AWS credentials are not set"
    fi

    # Validate Terraform configuration first
    validate_terraform

    # Execute command based on input argument
    case "${1:-}" in
        "init")
            init_terraform
            ;;
        "plan")
            init_terraform
            plan_terraform
            ;;
        "apply")
            init_terraform
            plan_terraform
            apply_terraform
            ;;
        "destroy")
            init_terraform
            destroy_terraform
            ;;
        *)
            error_exit "Usage: $0 {init|plan|apply|destroy}"
            ;;
    esac

    log_message "Terraform operation completed successfully"
}

# Execute main function with script arguments
main "$@"