# Provider Releases - Microsoft Fabric

This directory tracks **Microsoft Fabric Provider versions** and their impact on our project.

## 📦 **Provider Version History**

### **Microsoft Fabric Provider 1.6.0** 
**Released:** September 2025 | **Our Adoption:** v0.0.1 ✅

**Key Changes from 1.5.0:**
- ✅ Enhanced `fabric_workspace_role_assignment` principal format
- ✅ Improved `fabric_workspace` capacity assignment
- ⚠️ Preview features require special configuration
- 🚧 `fabric_mounted_data_factory` definition schema changes

**Impact on Our Project:**
- ✅ Successful upgrade completed in v0.0.1
- ✅ All existing resources remain compatible
- 🚧 New features require investigation (MPE, MDF)

---

### **Microsoft Fabric Provider 1.5.0**
**Released:** September 2025 | **Our Usage:** Legacy

**Initial Resources Supported:**
- `fabric_workspace`
- `fabric_workspace_role_assignment` 
- `fabric_capacity`
- `fabric_lakehouse`, `fabric_warehouse`
- `fabric_data_pipeline`, `fabric_eventstream`
- `fabric_notebook`, `fabric_kql_database`
- `fabric_workspace_managed_private_endpoint`
- `fabric_mounted_data_factory`

**Migration Status:** ✅ **COMPLETED** in v0.0.1

---

## 🔄 **Migration Guide**

### **1.5.0 → 1.6.0 (Completed)**

**Required Changes:**
1. ✅ Update `required_providers` block
2. ✅ Convert `principal` from string to object format  
3. ✅ Add provider `features` block for azurerm
4. ⚠️ Comment preview resources temporarily

**Command:**
```bash
terraform init -upgrade
```

**Validation:**
```bash
terraform plan  # Should show 0 errors
```

---

## 🔮 **Future Provider Releases**

### **Expected 1.7.0+** (Monitoring)
**Potential Features:**
- 🔍 Native policy management resources
- 🔍 Enhanced preview mode configuration
- 🔍 Improved MDF definition schema
- 🔍 Additional governance features

**Our Preparation:**
- Monitor Microsoft Fabric provider roadmap
- Test preview features in development
- Plan integration for v0.0.2+

---

## 📊 **Compatibility Matrix**

| Provider Version | Project Release | Status | Resources |
|-----------------|----------------|---------|-----------|
| 1.6.0 | v0.0.1 | ✅ Active | 11 working |
| 1.5.0 | Legacy | 📦 Archived | 9 working |
| 1.7.0+ | v0.0.2+ | 🔮 Future | TBD |

---

## 🚨 **Breaking Changes Tracking**

### **1.6.0 Breaking Changes:**
- **principal format**: String → Object `{id, type}`
- **definition schema**: Enhanced validation for MDF

### **Migration Impact:**
- **Low**: Automated fixes in v0.0.1  
- **Testing**: Full terraform plan validation passed

---

## 🔗 **External Resources**
- [Microsoft Fabric Provider Documentation](https://registry.terraform.io/providers/microsoft/fabric/latest/docs)
- [Provider GitHub Repository](https://github.com/microsoft/terraform-provider-fabric)
- [Release Changelog](https://github.com/microsoft/terraform-provider-fabric/releases)