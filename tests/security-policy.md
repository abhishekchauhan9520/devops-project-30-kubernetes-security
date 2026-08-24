# Expected security behavior

| Control | Expected |
|---|---|
| Namespace Pod Security | Restricted enforce |
| App service account token | Not automounted |
| App API permissions | Read ConfigMaps only |
| Create Pods | Denied |
| Read Secrets | Denied |
| RBAC modification | Denied |
| Default network ingress | Denied |
| Default network egress | Denied |
| DNS | Allowed |
| Ingress controller → app | Allowed |
| App → Postgres | Allowed |
| App privilege escalation | Denied |
| Root execution | Denied |
