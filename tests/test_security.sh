#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

for file in namespace.yaml service-account.yaml rbac.yaml workload.yaml service.yaml network-policies.yaml security-boundaries.yaml; do
  test -s "$ROOT/k8s/$file"
done

grep -q 'pod-security.kubernetes.io/enforce: restricted' "$ROOT/k8s/namespace.yaml"
grep -q 'automountServiceAccountToken: false' "$ROOT/k8s/service-account.yaml"
grep -q 'resources: \["configmaps"\]' "$ROOT/k8s/rbac.yaml"
! grep -q 'verbs: \["\*"\]' "$ROOT/k8s/rbac.yaml"
! grep -q 'resources: \["\*"\]' "$ROOT/k8s/rbac.yaml"
grep -q 'policyTypes: \[Ingress, Egress\]' "$ROOT/k8s/network-policies.yaml"
grep -q 'name: default-deny-ingress-egress' "$ROOT/k8s/network-policies.yaml"
grep -q 'allowPrivilegeEscalation: false' "$ROOT/k8s/workload.yaml"
grep -q 'readOnlyRootFilesystem: true' "$ROOT/k8s/workload.yaml"
grep -q 'type: RuntimeDefault' "$ROOT/k8s/workload.yaml"
grep -q 'drop: \["ALL"\]' "$ROOT/k8s/workload.yaml"

printf 'Project 30 offline security tests passed.\n'
