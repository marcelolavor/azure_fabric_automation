[Início](README.md) | [Objetivo](01-objective.md) | [Escopo](02-scope.md) | [Processo](03-process-overview.md) | [Controle de Mudanças](04-change-control.md) | [Riscos](05-risks.md) | [Ferramentas](06-tools.md) | [Timeline](07-timeline.md) | [Critérios de Sucesso](08-success-criteria.md) | 
[Conclusão](09-conclusion.md) | 
[Delta Table Files](delta-file-benefits.md)

---
# Azure Fabric Automation Documentation

## Benefícios da adoção de Delta Table Files
Esta imagem ilustra a estrutura do arquivo Delta Table, destacando o uso de Parquet e JSON para garantir auditabilidade, versionamento e interoperabilidade.

![Formato aberto Delta Table](./images/delta-table-format.png)

## Benefícios

- **Conformidade**: Formato auditável (Parquet + JSON), com histórico completo e suporte a GDPR/LGPD.
- **Governança**: Integração com catálogos (Unity Catalog, Purview), controle de acesso granular e lineage.
- **Interoperabilidade**: Padrão aberto, sem vendor lock-in, suportado em multicloud e on-prem.
- **Transparência**: Dados legíveis e inspecionáveis diretamente.
- **Time Travel & Auditoria**: Reconstituição de versões passadas para investigações e relatórios.
- **Flexibilidade**: Suporte a updates, deletes e merges (CDC, correções).
- **Performance**: Otimizações nativas (indexação, clustering, batch + streaming).
- **Sustentabilidade**: Projeto open source mantido pela Linux Foundation, com ampla adoção no mercado.

---
[Contribuição](CONTRIBUTING.md) | [Templates](templates/change-request-template.md) | 
[Governança](01-objective.md) | [Contato](mailto:contato@empresa.com) | [Licença](../LICENSE)
