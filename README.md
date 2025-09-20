[Start](docs/README.md) | [Objective](docs/01-objective.md) | [Scope](docs/02-scope.md) | [Process](docs/03-process-overview.md) | [Change Control](docs/04-change-control.md) | [Risks](docs/05-risks.md) | [Tools](docs/06-tools.md) | [Timeline](docs/07-timeline.md) | [Success Criteria](docs/08-success-criteria.md) | 
[Conclusion](docs/09-conclusion.md) | 
[Delta Table Files](docs/delta-file-benefits.md)

---
# Azure Fabric Automation
Azure Fabric resource automation using Terraform, following infrastructure as code (IaC) best practices.

## 📂 Project structure
```
azure_fabric_automation/
│
├── .github/
│   └── workflows/            # CI/CD pipeline configurations
│
├── global/
│   ├── main.tf               # Common configurations
│   ├── outputs.tf            # Global outputs
│   ├── providers.tf          # Provider configuration + remote backend
│   └── tags/                 # Global tags module
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
│
├── modules/
│   ├── fabric_workspace/     # Workspace creation + roles
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── fabric_capacity/      # Capacities (dedicated/shared)
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── fabric_items/         # Lakehouses, Warehouses, Pipelines, Notebooks
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   ├── lakehouse.tf
│   │   ├── warehouse.tf
│   │   ├── pipeline.tf
│   │   ├── notebook.tf
│   │   ├── eventstream.tf
│   │   └── kql_database.tf
│   ├── fabric_networking/    # Managed private endpoints, mounted data factories
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   ├── mpe.tf            # Managed Private Endpoints
│   │   └── mdf.tf            # Mounted Data Factories
│   └── fabric_admin/         # RBAC, role assignments, governance
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       ├── rbac.tf
│       ├── policies.tf
│       ├── README.md
│       └── scripts/
│           └── apply_fabric_policies.py
│
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── pre/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prd/
│       ├── main.tf
│       └── terraform.tfvars
│
├── docs/                     # Comprehensive documentation
│   ├── README.md
│   ├── 01-objective.md
│   ├── 02-scope.md
│   ├── 03-process-overview.md
│   ├── 05-risks.md
│   ├── 08-success-criteria.md
│   ├── CONTRIBUTING.md
│   ├── delta-file-benefits.md
│   ├── change-management/
│   ├── technical-stack/
│   ├── workflow/
│   ├── templates/
│   └── images/
│
├── releases/                 # Release management and documentation
│   ├── README.md
│   ├── project-releases/
│   └── provider-releases/
│
├── fix-providers.sh          # Provider fix utility script
├── .gitignore
├── LICENSE
└── README.md                 # Main project documentation
```

## 🚀 Usage example
In the `envs/dev/main.tf` file, we can have:

```hcl
module "capacity" {
  source       = "../../modules/fabric_capacity"
  name         = "cap-dev"
  sku_name     = "F64"
  location     = "westeurope"
  tags         = local.tags
}

module "workspace" {
  source      = "../../modules/fabric_workspace"
  name        = "fabric-dev-ws"
  capacity_id = module.capacity.id
  location    = "westeurope"
  tags        = local.tags
}

module "lakehouse" {
  source        = "../../modules/fabric_items"
  workspace_id  = module.workspace.id
  lakehouse_name = "lakehouse_dev"
}
```

## 🚀 First execution of the Azure Fabric Automation project
This project uses Terraform to automate the creation and management of Microsoft Fabric environments (DEV, PRE and PRD).

### 📌 Prerequisites
- Terraform >= 1.8, < 2.0
- Microsoft Fabric Provider 1.6.0
- Azure access with permissions to create Fabric resources
- Environment variable/secret AZURE_CREDENTIALS configured in Service Principal JSON format (if running in CI/CD)

### az login
Ensure you are authenticated in Azure CLI:
```bash
az login --tenant "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" --scope "https://management.azure.com/.default"
az account set --subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
```

### ⚡ Step-by-step for first execution
1. Choose the environment you want to apply (dev, pre or prd):
```bash 
cd envs/dev
# or
cd envs/pre
# or
cd envs/prd
```

2. Initialise Terraform to download necessary modules and providers:
```bash
terraform init
```
🔎 This step must be done on first execution or if there are module changes.

3. View the execution plan:
```bash
terraform plan -var-file="terraform.tfvars"
```

> 📝 **Note**: As the `-out` option above is not used to save this plan, Terraform cannot guarantee that it will execute exactly these actions if you run `terraform apply` at this point. To ensure exact execution of the plan, always save it and then apply the generated file:
> ```bash
> # Save the plan to a file
> terraform plan -out=tfplan -var-file="terraform.tfvars"
> 
> # Apply the saved plan
> terraform apply "tfplan"
> ```

4. Apply the configuration:
If you saved the plan in the previous step, apply the plan file:
```bash
terraform apply "tfplan"
```
> 📝 **Note**: The `terraform apply "tfplan"` command applies the plan directly, without asking for confirmation, as the plan has already been reviewed.

Alternatively, if you didn't save the plan, you can apply directly, but Terraform will create a new plan:
```bash
terraform apply -auto-approve -var-file="terraform.tfvars"
```

5. Check consolidated outputs (capacity, workspace, items, networking, admin):
```bash
terraform output -json | jq
```

## 🎯 Best practices

- Governance: prevent_destroy = true in PRD for workspaces/capacities.
- Mandatory tags: project, env, owner, cost_centre.
- Naming Convention:
```
    <fabric>-<env>-<type>-<name>
    ex: fabric-dev-ws-datahub
```
- Isolated environments: each envs/ folder has its main.tf calling reusable modules.
- Remote backend (Azure Storage + Key Vault) to store state securely.
- Sensitive variables: stored in Key Vault and referenced via data source.

## 🧩 Available resources in Provider 1.6.0
According to the latest release changelog (v0.0.1 - September/2025), we have support for the following resources:

> 📋 **Release Notes**: For complete details about releases, fixes and roadmap, see the [releases documentation](releases/README.md).

### Core
- fabric_workspace
- fabric_workspace_role_assignment
- fabric_capacity
### Compute & Storage
> To learn more about the Delta Table File format used for storage, see the [Delta File benefits page](./docs/delta-file-benefits.md).
### Networking & Integration
 fabric_lakehouse
 fabric_warehouse
 fabric_kql_database
 fabric_notebook
 fabric_data_pipeline
 fabric_eventstream

> To learn more about the Delta Table File format used for storage, see the [Delta File benefits page](docs/delta-file-benefits.md).
- fabric_workspace_managed_private_endpoint
- fabric_mounted_data_factory
### Governance
- RBAC via fabric_workspace_role_assignment
- Granular access policies
> This project recommends using Delta Table File for data storage. See the [Delta File benefits](./docs/delta-file-benefits.md).


### 🔹 Managed Private Endpoints (fabric_workspace_managed_private_endpoint)

In provider 1.6.0, the mandatory attributes are:
- workspace_id
- name
- target_private_link_resource_id (ARM ID of target resource)
- target_subresource_type (e.g.: "blob" for Storage, "sqlServer" for SQL)
- request_message (optional, but recommended)

> ⚠️ **Status**: Requires preview mode configuration (documented in [v0.0.1](releases/v0.0.1.md))

### 🔹 Mounted Data Factories (fabric_mounted_data_factory)
In release 1.6.0, this resource no longer accepts simply data_factory_id. It requires:
- workspace_id
- display_name (logical name visible in Fabric)
- format (e.g.: "DataFactoryV2")
- definition (JSON block or string with ADF connection definition)

> ⚠️ **Status**: Schema under investigation (documented in [v0.0.1](releases/v0.0.1.md))

## 🧪 Terraform Testing

To ensure infrastructure quality and security, it's recommended to use automated testing with Terraform. Some approaches and tools:

- **terraform validate**: Validates file syntax and structure.
  ```bash
  terraform validate
  ```
- **terraform plan**: Simulates the application of changes and allows review before deployment.
  ```bash
  terraform plan
  ```
- **terraform fmt -check**: Ensures code formatting standards.
  ```bash
  terraform fmt -check
  ```
- **terraform test** (experimental): Allows creating automated tests for modules and resources.
  ```bash
  terraform test
  ```
- **tflint**: External tool for linting and best practices.
  ```bash
  tflint
  ```
> It's recommended to integrate these commands into CI/CD pipelines to ensure continuous validation.

## 🔑 Required GitHub configuration
Create the AZURE_CREDENTIALS secret in the repository, with Service Principal JSON:
```bash
{
  "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

This SP needs permissions on:
- Resource Group
- Subscription where Fabric resources are being created

## ❗ Possible errors
- Error: Module not installed → means you forgot to run terraform init.
- Error: Authentication failed → check if you are authenticated in Azure (az login) or if the Service Principal credentials are correct.

✅ After these steps, the environment will be provisioned and outputs will be available for integration with other systems or manual verification.

✅ How to fix provider error after Terraform upgrade
If after updating Terraform you encounter provider-related errors, follow these steps:

1. Delete local cache and lockfile in the environment directory:
```bash
rm -rf .terraform .terraform.lock.hcl
```

2. Re-run init:
```bash
terraform init -upgrade
```

3. Check used providers:
```bash
terraform providers
```
---
[Contributing](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governance](01-objective.md) | [Contact](mailto:contato@empresa.com) | [Licence](../LICENSE) | [**📋 Release Notes**](releases/README.md)

