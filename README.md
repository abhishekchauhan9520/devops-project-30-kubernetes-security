# Project 30 — Kubernetes RBAC, Security & Network Policies

A security-focused Kubernetes lab demonstrating least-privilege RBAC, namespace isolation, Pod Security Admission, default-deny networking, and explicit application-to-database traffic rules.

## Security model

```text
security-demo namespace
├── app ServiceAccount (no API token mount)
├── app Role (read ConfigMaps only)
├── RoleBinding (app → Role)
├── default-deny ingress/egress
├── allow ingress from ingress namespace
├── allow app → database
├── deny app → database from other workloads
└── Restricted Pod Security Admission
```

Kubernetes recommends namespace-scoped Roles/RoleBindings, least privilege, avoiding wildcard permissions, and minimizing privileged service-account tokens. citeturn255922search0turn255922search7

## Files

- `k8s/namespace.yaml` — namespace with Restricted Pod Security labels
- `k8s/service-account.yaml` — workload identity
- `k8s/rbac.yaml` — minimal Role/RoleBinding
- `k8s/workload.yaml` — hardened application
- `k8s/service.yaml` — internal service
- `k8s/network-policies.yaml` — default deny plus explicit allows
- `k8s/deny-escalation.yaml` — examples of permissions intentionally excluded
- `tests/test_security.sh` — offline security assertions
- `.github/workflows/security.yml` — manifest/security validation

## Runtime testing

Run with a cluster whose CNI enforces NetworkPolicy. Kubernetes documents that NetworkPolicy enforcement depends on a network plugin that supports it. citeturn255922search10

```bash
kubectl apply -f k8s/
kubectl auth can-i get configmaps --as=system:serviceaccount:security-demo:security-demo-app -n security-demo
kubectl auth can-i create pods --as=system:serviceaccount:security-demo:security-demo-app -n security-demo
```

The first command should return `yes`; the second should return `no`.

## Pod Security

The namespace enforces the Restricted Pod Security Standard and also audits/warns on Restricted policy. Kubernetes Pod Security Admission supports namespace-level `enforce`, `audit`, and `warn` modes. citeturn255922search5turn255922search9

## Important limitation

Offline tests validate manifest intent. They cannot prove runtime network enforcement without a real Kubernetes cluster and a NetworkPolicy-capable CNI.
