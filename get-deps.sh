#/bin/bash

ska_python_skeleton_dir="ska-skeleton"
ska_python_skeleton_url="https://github.com/ska-telescope/ska-skeleton.git"

# BASE
echo "[+] Parsing base image"
if [ ! -d ${PWD}/dependencies/base ]; then
  mkdir -p ${PWD}/dependencies/base;
fi
docker run --name python_bash -v ${PWD}/dependencies/base:/tmp/repo/dependencies/ -v ${PWD}/.docker/:/tmp/repo/.docker/ --rm -t spsr /bin/bash -c \
    "cd /tmp/repo && \
    .docker/get-lib_deps.sh && \
    .docker/get-system_deps.sh"

# SKA-PYTHON-SKELETON
echo "[+] Parsing ska-python-skeleton project"
if [ ! -d ${PWD}/dependencies/${ska_python_skeleton_dir} ]; then
  mkdir -p ${PWD}/dependencies/${ska_python_skeleton_dir};
fi
docker run --name python_bash -v ${PWD}/dependencies/${ska_python_skeleton_dir}:/tmp/repo/dependencies/ -v ${PWD}/.docker/:/tmp/repo/.docker/ --rm -t spsr /bin/bash -c \
    "cd /tmp && git clone ${ska_python_skeleton_url} repotmp && \
    cp -R repotmp/* repo/ && \
    cd repo && \
    pipenv install && \
    .docker/get-lib_deps.sh && \
    .docker/get-pipenv_deps.sh && \
    .docker/get-system_deps.sh"