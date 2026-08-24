from pathlib import Path
import yaml

obj = next(x for x in yaml.safe_load_all(Path('k8s/workload.yaml').read_text()) if x)
container = obj['spec']['template']['spec']['containers'][0]
sec = container['securityContext']
assert obj['kind'] == 'Deployment'
assert obj['spec']['replicas'] == 2
assert sec['runAsNonRoot'] is True
assert sec['allowPrivilegeEscalation'] is False
assert sec['readOnlyRootFilesystem'] is True
assert sec['capabilities']['drop'] == ['ALL']
assert obj['spec']['template']['spec']['securityContext']['seccompProfile']['type'] == 'RuntimeDefault'
print('Workload security assertions passed.')
