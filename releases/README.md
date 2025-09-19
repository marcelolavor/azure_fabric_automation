# Release Management Overview

Este diretório organiza **dois tipos distintos de releases** para o projeto Azure Fabric Automation.

## � **Provider Releases vs Project Releases**

### **🔧 Provider Releases (Microsoft Fabric)**
- **Controle**: Microsoft (external dependency)
- **Impacto**: Recursos e capacidades disponíveis no Terraform
- **Formato**: Semantic versioning (1.5.0, 1.6.0, etc.)
- **Documentação**: [provider-releases/](provider-releases/)

### **🚀 Project Releases (Azure Fabric Automation)**
- **Controle**: Nossa equipe (internal milestones)
- **Impacto**: Features implementadas, correções e melhorias
- **Formato**: Development versioning (v0.0.1, v0.0.2, etc.)
- **Documentação**: [project-releases/](project-releases/)

---

## � **Quick Reference Matrix**

| Project Release | Provider Version | Key Features | Status |
|----------------|------------------|--------------|---------|
| v0.0.1 | 1.6.0 | Initial implementation, 11 resources | ✅ Released |
| v0.0.2 | 1.6.0+ | Networking features, preview mode | 🚧 Planned |
| v0.1.0 | TBD | Advanced policies, governance | 📋 Roadmap |

---

## � **Release Relationship**

```
Microsoft Provider Releases ──┐
                              ├─► Project Implementation  
Our Development Milestones ───┘     
```

**Example:**
- Provider 1.6.0 (Microsoft) enables new resources
- Project v0.0.1 (Ours) implements those resources  
- Provider 1.7.0 (Microsoft) adds preview features
- Project v0.0.2 (Ours) will implement preview features

---

## � **Navigation**

### **For Developers:**
- [Project Releases](project-releases/) - Our development milestones
- [Current Release: v0.0.1](project-releases/v0.0.1.md)

### **For Infrastructure Teams:**
- [Provider Compatibility](provider-releases/) - Microsoft Fabric versions  
- [Provider Migration Guide](provider-releases/migration-guide.md)

### **For Management:**
- [Combined Roadmap](ROADMAP.md) - Strategic overview
- [Release Planning](PLANNING.md) - Process documentation