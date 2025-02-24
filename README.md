# devsecops-jomacs

```plaintext
.
├── app
│   ├── ciphertool
│   │   └── ciphertool.md
│   ├── python
│   │   ├── app.py
│   │   ├── requirements.txt
│   │   ├── static
│   │   │   ├── css
│   │   │   │   └── styles.css
│   │   │   ├── fonts
│   │   │   └── images
│   │   └── templates
│   │       └── index.html
│   └── security
│       └── config
├── cicd
├── docs
├── images
│   ├── bandit.png
│   └── safety.png
├── infra
│   ├── ec2
│   │   ├── main.tf
│   │   ├── modules
│   │   │   ├── ec2
│   │   │   │   ├── ec2.tf
│   │   │   │   ├── iam.tf
│   │   │   │   ├── output.tf
│   │   │   │   ├── providers.tf
│   │   │   │   └── vars.tf
│   │   │   └── vpc
│   │   │       ├── output.tf
│   │   │       ├── providers.tf
│   │   │       ├── vars.tf
│   │   │       └── vpc.tf
│   │   ├── output.tf
│   │   ├── providers.tf
│   │   └── vars.tf
│   ├── ecs
│   │   └── main.tf
│   └── local
│       └── docker
│           ├── main.tf
│           ├── modules
│           │   ├── container
│           │   │   ├── container.tf
│           │   │   ├── output.tf
│           │   │   ├── provider.tf
│           │   │   └── vars.tf
│           │   └── image
│           │       ├── image.tf
│           │       ├── output.tf
│           │       ├── provider.tf
│           │       └── var.tf
│           ├── output.tf
│           ├── provider.tf
│           ├── terraform.tfstate
│           ├── terraform.tfstate.backup
│           └── vars.tf
└── README.md

25 directories, 36 files
```