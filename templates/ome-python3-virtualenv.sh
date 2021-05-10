#!/usr/bin/env bash
# There are multiple ways of creating Python virtualenvs including
# virtualenv, python3 -mvenv, but these may take different parameters.
# In some situations, particularly if ansible_python_interpreter is set,
# the Ansible pip modules passes unrecognised parameters.
# This wrapper script should work in all cases.

set -eu

for arg in "$@"; do
    # Ignore -p argument
    if [[ $arg = -p ]]; then
        shift
        shift
    elif [[ "$arg" = -p* ]]; then
        shift
    fi
done
{% if python3_miniconda -%}
{{ python3_miniconda_prefix }}/python3 -mvenv "$@"
{% else -%}
python3 -mvenv "$@"
{% endif -%}
