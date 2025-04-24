# devsecops-jomacs

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python)

### 1. Secure CI/CD Pipeline with Automated Scanning

#### [cicd](./cicd/)
[![Full Infra + App Deploy + ELK Deploy](https://github.com/michaelkedey/devsecops-jomacs/actions/workflows/ochestrator.yaml/badge.svg)](https://github.com/michaelkedey/devsecops-jomacs/actions/workflows/ochestrator.yaml)

 ![workflow](./images/cicddddddddddddddddddddddddddddddd.png)

- **[infra.yaml](./cicd/infra.yaml)**
  - designed to to create the necessary AWS resources for the pipeline,including;
      * a vpc with private and public subnets in multiple availability zones
      * a private application server, in a private subnet
      * a private elk server, in another private subnet
      * a jumper server in a public subnet fo secure acces to the private servers
      * a loadbalancer for public access to the private servers via dns
      * a nat gateway for outbound access from the private subnets
      * an internet gateway for public access to the loadbalancer
      * custom ssh ports for secure access to all servers
    * this workflow is trgiggerd either automatically via changes in the `infra/aws` directory on branch `main`, or manually, by selecting either an aplly or destroy job
- **[app.yaml](./cicd/app.yaml):** designed to securely deploy the application to the private server, employing multiple strategies to ensure the application is deployed securely, including;
    * safety scan for vulnerabilities 
        * [safety-scan.json](./app/python/scan-reports/safety-report.json)
        * ![safety scan](./images/safety.png)
    * bandit scans for security issues
        * [bandit-scan.json](./app/python/scan-reports/bandit-report.json)
        * ![bandit report](./images/bandit.png)
    * generating scan reports for auditing
    * failing app deployments if any security issues are found, to prevent insecure deployments.
    * using ssh and rsync to securely transfer files to the private server from the bastion via custom ssh ports, only when the sfacety and security checks pass.
    * starting the app and verifying it is running on the private server
    * this workflow is triggerd manually only after submitting required inputs for the `bastion_public_ip` and `ec2_private_ip`
- **[docker.yaml](./cicd/):** this workflow securely automates the scanning, creation and deployment of the created docker image to dockerhub. It performs a trivy scan of the created image, and on success, the image is deployed to dockerhub. On failure however, the image is not deployed. ;
    * trivy scan for vulnerabilities
        * [trivy-scan.json](./app/python/scan-reports/trivy-scanreport.json)
    * generating scan reports for auditing
    * failing image deployments to dockerhub if any security issues are found.
  
#### [app](./app/)
- [ciphertool](./app/ciphertool/ciphertool.md)
    * contains docker pull command to run the cipher-tool application
      * ✨ Features - CipherTool - Secure text encryption tool. 
        *   **Complex Encryption**: Transform text using a proprietary algorithm
        *   **4-Digit Code Security**: PIN-protected encryption/decryption
        *   **Terraform Automation**: Single-command deployment/destruction
        *   **Docker Containerization**: Lightweight and portable 
    * Docker Image: [michaelkedey/cipher-tool:v2](https://hub.docker.com/r/michaelkedey/cipher-tool/tags)
        - please use v2.
    * Live Demo: http://localhost:5000
    * please see [installation guide](./infra/local/docker/README.md): on how to lunch the application

- [python](./app/python/)
    * contains the python application code which runs on the private server

#### [infra](./infra/)
- [aws](./infra/aws/): employs terraform iac, including terraform modules to create the base infrsatructure of 26 aws resuorces for the application server. Resources include:
    * 1 vpc
    * 2 ec2 instances (jumper server and app server)
    * 1 loadbalancer and a listener
    * 1 target group and attachement
    * 3 security groups (jumper, app, and loadbalancer)
    * 1 eip
    * 1 internet gatway
    * 1 nat gateway
    * 2 route tables (private, public)
    * 3 route-table associations (private, public, public1)
    * 3 subnets (private, public, public1)
    * ssm resources
  
### 2. Local Infrastructure-as-Code with Policy Enforcement

#### [infra](./infra/)
- [local/docker](./infra/local/docker/): uses terraform iac, including terraform modules to create the local infrsatructure of 4 docker resources for local docker container deplyment. Resources include:
    * 2 containers
    * 2 [docker images](https://hub.docker.com/r/michaelkedey/)
      * [michaelkedey/cipher-tool:v2](https://hub.docker.com/r/michaelkedey/cipher-tool/tags)
        * please use V2
      * [michaelkedey/jomacsdevsecops:latest](https://hub.docker.com/r/michaelkedey/jomacsdevsecops/tags)
    * Installation & 🛠️ Usage
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
        * * ![terraform apply docker](./images/docker.png)
      - **Get the App Link:** After applying the Terraform configuration, Terraform will output the link to access the app. You can open the app in your browser to start using it. The app runs on port 5000. Once the deployment is complete, open the app and try encrypting text by entering a 4-digit encryption code.
      - **Live Demo**
        *  http://localhost:5000
           *   ![docker container1](./images/docker3c.png)
        *  http://localhost:80
           *  * ![docker container2](./images/docker1j.png)
      - Destroy Infrastructure
        ```
        terraform destroy --auto-approve
        ```

### 3. Container Scanning & Registry Compliance

#### [app](./app/)
- [python](./app/python/)
  * contains the python application code bundled into a container image
  * [Dokerfile](./app/containerization/Dockerfile): used to create the containerized image of the [python-app](./app/python/)
- **[docker.yaml](./cicd/):** this workflow securely automates the scanning, creation and deployment of the created docker image to dockerhub. It performs a trivy scan of the created image, and on success, the image is deployed to dockerhub. On failure however, the image is not deployed. ;
    * trivy scan for vulnerabilities
        * [trivy-scan.json](./app/python/scan-reports/trivy-scanreport.json)
    * generating scan reports for auditing
    * failing image deployments to dockerhub if any security issues are found.

### 4. Centralized Logging & Security Monitoring

### directory structure
```plaintext
.
├── app
│   ├── ciphertool
│   │   └── ciphertool.md
│   ├── containerization
│   │   └── Dockerfile
│   ├── python
│   │   ├── app.py
│   │   ├── appspec.yaml
│   │   ├── nohup.out
│   │   ├── __pycache__
│   │   │   └── app.cpython-310.pyc
│   │   ├── requirements.txt
│   │   ├── scan-reports
│   │   │   ├── bandit-report.json
│   │   │   ├── safety-report.json
│   │   │   └── trivy-scanreport.json
│   │   ├── static
│   │   │   └── css
│   │   │       └── styles.css
│   │   └── templates
│   │       └── index.html
│   └── security
│       └── config
├── cicd
│   ├── app.yaml
│   ├── docker.yaml
│   └── infra.yaml
├── images
│   ├── bandit.png
│   ├── cicddddddddddddddddddddddddddddddd.png
│   ├── docker1j.png
│   ├── docker3c.png
│   ├── docker.png
│   ├── README.md
│   ├── safety.png
│   └── workflow.png
├── infra
│   ├── aws
│   │   ├── ec2.md
│   │   ├── main.tf
│   │   ├── modules
│   │   │   ├── compute
│   │   │   │   ├── custome_ssh.sh
│   │   │   │   ├── ec2.tf
│   │   │   │   ├── output.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   ├── listener_and_tgs
│   │   │   │   ├── output.tf
│   │   │   │   ├── tg.tf
│   │   │   │   └── vars.tf
│   │   │   ├── loadbalancer
│   │   │   │   ├── lb.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   ├── networking
│   │   │   │   ├── output.tf
│   │   │   │   ├── providers.tf
│   │   │   │   ├── vars.tf
│   │   │   │   └── vpc.tf
│   │   │   └── secrets_manager
│   │   │       ├── secrets.tf
│   │   │       └── variables.tf
│   │   ├── output.tf
│   │   ├── providers.tf
│   │   └── vars.tf
│   ├── ecs
│   │   └── main.tf
│   └── local
│       └── docker
│           ├── main.tf
│           ├── modules
│           │   ├── container
│           │   │   ├── container.tf
│           │   │   ├── output.tf
│           │   │   ├── provider.tf
│           │   │   └── vars.tf
│           │   └── image
│           │       ├── image.tf
│           │       ├── output.tf
│           │       ├── provider.tf
│           │       └── var.tf
│           ├── output.tf
│           ├── provider.tf
│           ├── README.md
│           └── vars.tf
├── password.txt
└── README.md

28 directories, 62 files


```
