# devsecops-jomacs
![bandit report](./images/bandit.png)

- Secure CI/CD Pipeline with Automated Scanning
- Local Infrastructure-as-Code with Policy Enforcement
- Container Scanning & Registry Compliance
- Centralized Logging & Security Monitoring
- Lightweight Incident Response “Runbook” + Security Dashboard

![safety scan](./images/safety.png)

```plaintext
.
├── app
│   ├── ciphertool
│   │   └── ciphertool.md
│   ├── python
│   │   ├── app.py
│   │   ├── appspec.yaml
│   │   ├── __pycache__
│   │   │   └── app.cpython-310.pyc
│   │   ├── requirements.txt
│   │   ├── static
│   │   │   ├── css
│   │   │   │   └── styles.css
│   │   │   ├── fonts
│   │   │   └── images
│   │   └── templates
│   │       └── index.html
│   └── security
│       └── config
├── cicd
├── docs
├── images
│   ├── bandit.png
│   └── safety.png
├── infra
│   ├── aws
│   │   ├── ec2.md
│   │   ├── main.tf
│   │   ├── modules
│   │   │   ├── ec2
│   │   │   │   ├── custome_ssh.sh
│   │   │   │   ├── ec2.tf
│   │   │   │   ├── iam.tf
│   │   │   │   ├── output.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   ├── jumper
│   │   │   │   ├── bastion.tf
│   │   │   │   ├── custome_ssh.sh
│   │   │   │   ├── output.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   ├── lb
│   │   │   │   ├── lb.tf
│   │   │   │   ├── outputs.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   └── vpc
│   │   │       ├── output.tf
│   │   │       ├── providers.tf
│   │   │       ├── vars.tf
│   │   │       └── vpc.tf
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
│           ├── terraform.tfstate
│           ├── terraform.tfstate.backup
│           └── vars.tf
└── README.md

28 directories, 49 files

```