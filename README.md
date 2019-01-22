# ska-python-skeleton-deps
Checks the minimum system and python packages dependencies for the ska-skeleton project

## Usage:
Build the docker image from scratch and get the system dependencies under `system_deps.txt` and python package dependencies under `pipenv_deps.txt`:
```
> ./get-clean-deps.sh
```

## Principles
The dependencies for every of the ska-telescope repositories will be defined on what packages from different origins need to be added to a *base image*.

These packages are allowed to be installed through the following:
- the OS' package management tools, namely, `apt`
- from the python package index `PyPI` using `pipenv`

## Definition of *base project*
The base project is defined as the following
- python:3.5-slim docker image comprised of:
    - debian stable slim image
    - minimal python installation on top of debian stable slim image
- git tooling
- make
- pipenv

## Requests for adding packages to the *base project*
For the present, the System Team can be contacted in order to update the definition of *base project* and add new base dependencies to it.

## Defining dependencies to install
Each project is responsible to script the steps needed to build them and install their needed dependencies in the form of simple shell commands as expressed in the file `get-deps.sh`.