# Migration Guide: Microsoft Fabric Provider Upgrades

## 🎯 **Overview**

This guide documents how to migrate between Microsoft Fabric Provider versions, with impact on our project.

---

## ⬆️ **1.5.0 → 1.6.0 Migration (COMPLETED)**

### **Pre-Migration Checklist**
- [x] Backup current terraform state
- [x] Test in development environment first
- [x] Review breaking changes documentation
- [x] Plan downtime if needed

### **Step-by-Step Process**

#### **1. Update Provider Configuration**
```hcl
# Before (1.5.0)
terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = ">= 1.5.0"
    }
  }
}

# After (1.6.0)  
terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"  
      version = "1.6.0"
    }
  }
}
```

#### **2. Fix Breaking Changes**

**Principal Format Update:**
```hcl
# Before (1.5.0)
resource "fabric_workspace_role_assignment" "example" {
  principal = "user-guid-here"
  role      = "Admin"
}

# After (1.6.0)
resource "fabric_workspace_role_assignment" "example" {
  principal = {
    id   = "user-guid-here"
    type = "User"
  }
  role = "Admin"
}
```

#### **3. Execute Migration**
```bash
# 1. Initialise with new provider
terraform init -upgrade

# 2. Validate configuration  
terraform validate

# 3. Plan changes
terraform plan

# 4. Apply if plan looks good
terraform apply
```

### **Validation Results**
- ✅ **Plan Status**: SUCCESS (0 errors)
- ✅ **Resources**: 11/11 compatible
- ✅ **Modules**: 4/4 functional
- ⚠️ **Preview Features**: 2 temporarily disabled

---

## 🔮 **Future Migrations**

### **1.6.0 → 1.7.0+ (PLANNED)**

**Expected Changes:**
- Enhanced preview mode configuration
- Native policy management resources
- Improved MDF definition schema

**Preparation:**
- Monitor provider release notes
- Test preview features early
- Update compatibility matrix

### **Migration Template:**
```bash
# 1. Review changelog
# 2. Update version constraints
# 3. Address breaking changes
# 4. Test in dev environment
# 5. Execute upgrade process
# 6. Update documentation
```

---

## 🚨 **Rollback Procedures**

### **Emergency Rollback (1.6.0 → 1.5.0)**

**If critical issues found:**
```bash
# 1. Revert provider version
terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.5.0"
    }
  }
}

# 2. Revert configuration changes
# - Convert principal back to string format
# - Remove new features

# 3. Re-initialise
terraform init -upgrade

# 4. Validate rollback
terraform plan
```

**⚠️ Warning**: Only use in emergencies. Forward compatibility preferred.

---

## 📊 **Migration History Log**

| Date | From | To | Status | Issues | Resolution Time |
|------|------|-------|--------|---------|----------------|
| 2025-09-19 | 1.5.0 | 1.6.0 | ✅ SUCCESS | Principal format | 2 hours |

---

## 🔗 **Resources**
- [Provider Release Notes](https://github.com/microsoft/terraform-provider-fabric/releases)
- [Breaking Changes Documentation](https://registry.terraform.io/providers/microsoft/fabric/latest/docs/guides/migration)
- [Our Project Release Notes](../project-releases/)