# CipherTool - Secure Text Encryption 🔒
- **Local Deployment using [Terraform](https://www.terraform.io/downloads)**

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker)

A complex encryption tool that converts text to binary.  
**Docker Image**: [michaelkedey/cipher-tool:v2](https://hub.docker.com/r/michaelkedey/cipher-tool/tags)
- please use v2.
**Live Demo**: http://localhost:5000

#### ✨ Features
- **Complex Encryption**: Transform text using a proprietary algorithm
- **4-Digit Code Security**: PIN-protected encryption/decryption
- **Terraform Automation**: Single-command deployment/destruction
- **Docker Containerization**: Lightweight and portable

#### 🚀 Quick Start

##### Prerequisites
  - [Terraform](https://www.terraform.io/downloads) 
  - [Docker](https://www.docker.com/products/docker-desktop) 
  - [Git](https://git-scm.com/) 

#### Installation & 🛠️ Usage
- Clone the repository: `https://github.com/michaelkedey/devsecops-jomacs.git`
    ```
    git clone https://github.com/michaelkedey/devsecops-jomacs.git
    cd devsecops-jomacs/infra/local/docker
    ```
- Deploy Infrastructure
    ```
    terraform fmt --recursive    
    terraform plan     
    terraform apply --auto-approve
    ```
- **Get the App Link:** After applying the Terraform configuration, Terraform will output the link to access the app. You can open the app in your browser to start using it. The app runs on port 5000. Once the deployment is complete, open the app and try encrypting text by entering a 4-digit encryption code.
- **Live Demo**: http://localhost:5000
- Destroy Infrastructure
  ```
  terraform destroy --auto-approve
  ```