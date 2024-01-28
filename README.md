# Terraform Static Website Deployment to AWS S3

This Terraform project automates the deployment of a static website to an AWS S3 bucket. The infrastructure includes the S3 bucket and necessary configurations.

## Prerequisites

Before you begin, ensure that you have the following prerequisites installed:

1. **Terraform:**
   - Install Terraform by following the instructions on the official [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli).

## Getting Started

Follow the steps below to deploy your static website using Terraform:

1. **Clone the Repository:**

   ```bash
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Initialize Terraform:**

   ```bash
   terraform init
   ```

3. **Review Configuration:**

Open the main.tf file and review the configuration. Adjust any variables or settings according to your requirements.

4. **Deploy Infrastructure:**

   ```bash
   terraform apply
   ```

Enter yes when prompted to confirm the deployment. Terraform will then create the necessary infrastructure resources to host your static website on AWS S3.

5. **Access the Website:**

Once the deployment is complete, your static website is hosted on the S3 bucket. Access it through the provided S3 bucket URL or configure a custom domain if you have set it up.
