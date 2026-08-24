# Test notes

`test_security.sh` performs offline assertions against repository intent. It does not replace runtime authorization or network-enforcement tests.

For a real cluster, verify:

```bash
kubectl auth can-i get configmaps --as=system:serviceaccount:security-demo:security-demo-app -n security-demo
kubectl auth can-i create pods --as=system:serviceaccount:security-demo:security-demo-app -n security-demo
```

Expected results: `yes` and `no` respectively.

For NetworkPolicy, use a CNI that supports NetworkPolicy and test both permitted and denied connections.
