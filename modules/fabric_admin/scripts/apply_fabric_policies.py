#!/usr/bin/env python3
"""Apply Microsoft Fabric workspace policies (limited support - only Network Communication Policy).

Based on official REST API docs (2024-09), only Network Communication Policy is supported:
- PUT /v1/workspaces/{workspaceId}/networking/communicationPolicy
- GET /v1/workspaces/{workspaceId}/networking/communicationPolicy

General governance policies (RBAC, naming, compliance) do NOT have official endpoints yet.
This script handles Network Communication Policy and logs/simulates others as placeholders.

Arguments:
  --workspace-id <GUID>
  --policy-name <string> (only "communicationPolicy" is real)
  --definition <JSON string>

Example communicationPolicy definition:
{
  "allowInternetAccess": false,
  "allowPublicNetworkAccess": true,
  "virtualNetworkRules": []
}
"""
import argparse
import json
import os
import subprocess
import sys
from typing import Any, Dict

FABRIC_RESOURCE = "https://api.fabric.microsoft.com/.default"
API_BASE = "https://api.fabric.microsoft.com/v1"


def get_token() -> str:
    try:
        result = subprocess.run(
            ["az", "account", "get-access-token", "--resource", FABRIC_RESOURCE],
            capture_output=True,
            text=True,
            check=True,
        )
        data = json.loads(result.stdout)
        return data["accessToken"]
    except Exception as exc:  # noqa: BLE001
        print(f"[ERROR] Failed to acquire token: {exc}", file=sys.stderr)
        sys.exit(1)


def apply_policy(workspace_id: str, policy_name: str, definition: Dict[str, Any]):
    token = get_token()
    
    if policy_name.lower() == "communicationpolicy":
        # Official endpoint for Network Communication Policy (preview)
        url = f"{API_BASE}/workspaces/{workspace_id}/networking/communicationPolicy"
        print(f"[INFO] Applying Network Communication Policy to workspace {workspace_id}")
        print(f"[DEBUG] Payload: {json.dumps(definition, indent=2)}")
        
        # Real API call (uncomment when ready)
        # import requests
        # resp = requests.put(
        #     url,
        #     headers={
        #         "Authorization": f"Bearer {token}",
        #         "Content-Type": "application/json",
        #     },
        #     json=definition,
        #     timeout=30,
        # )
        # if resp.status_code >= 300:
        #     print(f"[ERROR] API response {resp.status_code}: {resp.text}", file=sys.stderr)
        #     sys.exit(1)
        # print("[SUCCESS] Network Communication Policy applied.")
        print("[SIMULATION] Network Communication Policy request prepared (uncomment to execute).")
    else:
        # No official endpoint for general governance policies yet
        print(f"[INFO] Policy '{policy_name}' - NO OFFICIAL ENDPOINT")
        print(f"[DEBUG] Would apply to workspace {workspace_id}: {json.dumps(definition, indent=2)}")
        print("[PLACEHOLDER] General governance policies not supported by Fabric REST API yet.")
        print("Consider using:")
        print("- Azure Policy for infrastructure-level governance")
        print("- Purview for data classification/protection policies")
        print("- Custom governance through PowerBI Admin API (legacy)")
        
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--workspace-id", required=True)
    parser.add_argument("--policy-name", required=True)
    parser.add_argument("--definition", required=True, help="Raw JSON string")
    args = parser.parse_args()

    try:
        definition = json.loads(args.definition)
    except json.JSONDecodeError as e:  # noqa: N818
        print(f"[ERROR] Invalid JSON in definition: {e}", file=sys.stderr)
        sys.exit(1)

    apply_policy(args.workspace_id, args.policy_name, definition)


if __name__ == "__main__":  # pragma: no cover
    main()
