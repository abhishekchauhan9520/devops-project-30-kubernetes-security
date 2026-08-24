#!/usr/bin/env bash
set -euo pipefail
bash tests/test_security.sh
python tests/validate-workload.py
printf 'Project 30 validation passed.\n'
