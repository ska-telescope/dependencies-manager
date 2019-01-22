# ska-python-skeleton-deps
Checks the minimum system and python packages dependencies for the ska-skeleton project

## Usage:
Build the docker image from scratch and get the system dependencies under `system_deps.txt` and python package dependencies under `pipenv_deps.txt`:
```
> ./get-clean-deps.sh
```

## Base project

The base project is achieved with the following:
- python:3.5-slim docker image comprised of:
    - debian stable slim image
    - minimal python instalation on top of debian stable slim image
- git tooling
- make
- pipenv

