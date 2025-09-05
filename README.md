# Azure Fabric Automation
Automação de recursos do Azure Fabric usando Terraform, seguindo as melhores práticas de infraestrutura como código (IaC).

## 📂 Estrutura do projeto
```
terraform-fabric/
│
├── global/
│   ├── variables.tf          # Variáveis globais (tags, convenções de nomes)
│   ├── providers.tf          # Configuração do provider + backend remoto
│   ├── main.tf               # Configurações comuns
│   └── outputs.tf
│
├── modules/
│   ├── fabric_workspace/     # Criação de workspaces + roles
│   ├── fabric_capacity/      # Capacities (dedicadas/compartilhadas)
│   ├── fabric_items/         # Lakehouses, Warehouses, Pipelines, Notebooks
│   ├── fabric_networking/    # Managed private endpoints, data factories montadas
│   └── fabric_admin/         # RBAC, role assignments, governance
│
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   ├── pre/
│   │   ├── main.tf
│   │   └── terraform.tfvars
│   └── prd/
│       ├── main.tf
│       └── terraform.tfvars
│
└── README.md                 # Documentação inicial
```

## 🚀 Exemplo de uso
No arquivo `envs/dev/main.tf`, podemos ter:

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

## 🚀 Primeira execução do projeto Azure Fabric Automation
Este projeto utiliza Terraform para automatizar a criação e gestão de ambientes no Microsoft Fabric (DEV, PRE e PRD).

### 📌 Pré-requisitos
- Terraform >= 1.9
- Acesso ao Azure com permissões para criar recursos do Fabric
- Variável de ambiente/secret AZURE_CREDENTIALS configurada no formato JSON de um Service Principal (se estiver rodando em CI/CD)

### ⚡ Passo a passo para a primeira execução
1. Escolha o ambiente que deseja aplicar (dev, pre ou prd):
```bash 
cd envs/dev
# ou
cd envs/pre
# ou
cd envs/prd
```

2. Inicialize o Terraform para baixar os módulos e providers necessários:
```bash
terraform init
```
🔎 Este passo deve ser feito sempre na primeira execução ou se houver alterações de módulos.

3. Visualize o plano de execução:
```bash
terraform plan -var-file="terraform.tfvars"
```

4. Aplicar a configuração:
```bash
terraform apply -auto-approve -var-file="terraform.tfvars"
```

5. Consultar os outputs consolidados (capacity, workspace, items, networking, admin):
```bash
terraform output -json | jq
```

## ❗ Possíveis erros
- Error: Module not installed → significa que você esqueceu de rodar terraform init.
- Error: Authentication failed → verifique se está autenticado no Azure (az login) ou se as credenciais do Service Principal estão corretas.

✅ Após esses passos, o ambiente estará provisionado e os outputs estarão disponíveis para integração com outros sistemas ou verificação manual.

## 🎯 Boas práticas

- Governança: prevent_destroy = true em PRD para workspaces/capacities.
- Tags obrigatórias: project, env, owner, cost_center.
- Naming Convention:
```
    <fabric>-<env>-<tipo>-<nome>
    ex: fabric-dev-ws-datahub
```
- Ambientes isolados: cada pasta envs/ tem seu main.tf chamando módulos reutilizáveis.
- Backend remoto (Azure Storage + Key Vault) para guardar state com segurança.
- Variáveis sensíveis: armazenadas no Key Vault e referenciadas via data source.

## 🧩 Recursos disponíveis no Provider 1.5.0
Segundo o changelog do release 1.5.0 (04/09/2025), temos suporte aos seguintes recursos:
### Core
- fabric_workspace
- fabric_workspace_role_assignment
- fabric_capacity
### Compute & Storage
- fabric_lakehouse
- fabric_warehouse
- fabric_kql_database
- fabric_notebook
- fabric_data_pipeline
- fabric_eventstream
### Networking & Integração
- fabric_workspace_managed_private_endpoint
- fabric_mounted_data_factory
### Governança
- RBAC via fabric_workspace_role_assignment
- Políticas de acesso granular


### 🔹 Managed Private Endpoints (fabric_workspace_managed_private_endpoint)

No provider 1.5.0, os atributos obrigatórios são:
- workspace_id
- name
- target_private_link_resource_id (ARM ID do recurso alvo)
- target_subresource_type (ex.: "blob" para Storage, "sqlServer" para SQL)
- request_message (opcional, mas recomendado)

### 🔹 Mounted Data Factories (fabric_mounted_data_factory
Na release 1.5.0, esse recurso não aceita mais simplesmente data_factory_id. Ele exige:
- workspace_id
- display_name (nome lógico visível no Fabric)
- format (ex.: "DataFactoryV2")
- definition (bloco JSON ou string com a definição da conexão do ADF)

## 🧪 Testes Terraform

Para garantir a qualidade e segurança da infraestrutura, recomenda-se utilizar testes automatizados com o Terraform. Algumas abordagens e ferramentas:

- **terraform validate**: Valida a sintaxe e a estrutura dos arquivos.
  ```bash
  terraform validate
  ```
- **terraform plan**: Simula a aplicação das mudanças e permite revisão antes do deploy.
  ```bash
  terraform plan
  ```
- **terraform fmt -check**: Garante o padrão de formatação do código.
  ```bash
  terraform fmt -check
  ```
- **terraform test** (experimental): Permite criar testes automatizados para módulos e recursos.
  ```bash
  terraform test
  ```
- **tflint**: Ferramenta externa para lint e boas práticas.
  ```bash
  tflint
  ```
> Recomenda-se integrar esses comandos em pipelines CI/CD para garantir validação contínua.

## 🔑 Configuração necessária no GitHub
Criar o secret AZURE_CREDENTIALS no repositório, com JSON de um Service Principal:
```bash
{
  "clientId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "clientSecret": "xxxxxxxxxxxxxxxxxxxxxxxx",
  "subscriptionId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
  "tenantId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```

Esse SP precisa de permissões em:
- Resource Group
- Subscrição onde os recursos do Fabric estão sendo criados


✅ Como corrigir erro de provider após upgrade do Terraform
Se após atualizar o Terraform você encontrar erros relacionados ao provider, siga estes passos:

1. Apague o cache local e o lockfile no diretório do ambiente:
```bash
rm -rf .terraform .terraform.lock.hcl
```

2. Refaça o init:
```bash
terraform init -upgrade
```

3. Verifique os providers usados:
```bash
terraform providers
```