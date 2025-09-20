# Release Management Overview

This directory organises **two distinct types of releases** for the Azure Fabric Automation project.

## 📦 **Provider Releases vs Project Releases**

### **🔧 Provider Releases (Microsoft Fabric)**
- **Control**: Microsoft (external dependency)
- **Impact**: Resources and capabilities available in Terraform
- **Format**: Semantic versioning (1.5.0, 1.6.0, etc.)
- **Documentation**: [provider-releases/](provider-releases/)

### **🚀 Project Releases (Azure Fabric Automation)**
- **Control**: Our team (internal milestones)
- **Impact**: Implemented features, fixes and improvements
- **Format**: Development versioning (v0.0.1, v0.0.2, etc.)
- **Documentation**: [project-releases/](project-releases/)

---

## 📋 **Quick Reference Matrix**

| Project Release | Provider Version | Key Features | Status |
|----------------|------------------|--------------|---------|
| v0.0.1 | 1.6.0 | Initial implementation, 11 resources | ✅ Released |
| v0.0.2 | 1.6.0+ | Networking features, preview mode | 🚧 Planned |
| v0.1.0 | TBD | Advanced policies, governance | 📋 Roadmap |

---

## 🔄 **Release Relationship**

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

## 📚 **Navigation**

### **For Developers:**
- [Project Releases](project-releases/) - Our development milestones
- [Current Release: v0.0.1](project-releases/v0.0.1.md)

### **For Infrastructure Teams:**
- [Provider Compatibility](provider-releases/) - Microsoft Fabric versions  
- [Provider Migration Guide](provider-releases/migration-guide.md)

### **For Management:**
- [Combined Roadmap](ROADMAP.md) - Strategic overview
- [Release Planning](PLANNING.md) - Process documentation