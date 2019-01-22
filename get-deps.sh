#/bin/bash

ska_python_skeleton_dir="ska-skeleton"
ska_python_skeleton_url="https://github.com/ska-telescope/ska-skeleton.git"
developer_ska_telescope_dir="developer.skatelescope.org"
developer_ska_telescope_url="https://github.com/ska-telescope/developer.skatelescope.org.git"

# BASE SYSTEM --------------------------------------------------------------------------------------------------------------------------------------------
echo "[+] Parsing base image"
rm -rf ${PWD}/dependencies/base
mkdir -p ${PWD}/dependencies/base;
docker run --name python_bash -v ${PWD}/dependencies/base:/tmp/dependencies/ -v ${PWD}/.utils/:/tmp/utils/ --rm -t spsr /bin/bash -c \
    "rm -rf /tmp/repo && \
    mkdir /tmp/repo && \
    cd /tmp/repo && \
    /tmp/utils/get-lib_deps.sh && \
    /tmp/utils/get-system_deps.sh"

# SKA-PYTHON-SKELETON -----------------------------------------------------------------------------------------------------------------------------------
working_dir=${ska_python_skeleton_dir}
working_url=${ska_python_skeleton_url}

## get dependencies
echo "[+] Parsing ska-python-skeleton project"
rm -rf ${PWD}/dependencies/${working_dir}
mkdir -p ${PWD}/dependencies/${working_dir};
docker run --name python_bash -v ${PWD}/dependencies/${working_dir}:/tmp/dependencies/ -v ${PWD}/.utils/:/tmp/utils/ --rm -t spsr /bin/bash -c \
    "rm -rf /tmp/repo && \
    git clone ${working_url} /tmp/repo && \
    cd /tmp/repo && \
    pipenv install && \
    /tmp/utils/get-lib_deps.sh && \
    /tmp/utils/get-pipenv_deps.sh && \
    /tmp/utils/get-system_deps.sh"

## get installed dependencies on top of base
diff ${PWD}/dependencies/base/system_deps.txt ${PWD}/dependencies/${working_dir}/system_deps.txt | perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/system_deps_diff.txt
diff ${PWD}/dependencies/base/system_deps.csv ${PWD}/dependencies/${working_dir}/system_deps.csv perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/system_deps_diff.csv
diff ${PWD}/dependencies/base/lib_deps.txt ${PWD}/dependencies/${working_dir}/lib_deps.txt perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/lib_deps_diff.txt

# DEVELOPER.SKA.TELESCOPE ---------------------------------------------------------------------------------------------------------------------------------
# working_dir=${developer_ska_telescope_dir}
# working_url=${developer_ska_telescope_url}

# ## get dependencies
# echo "[+] Parsing ska-python-skeleton project"
# if [ ! -d ${PWD}/dependencies/${working_dir} ]; then
#   mkdir -p ${PWD}/dependencies/${working_dir};
# fi
# docker run --name python_bash -v ${PWD}/dependencies/${working_dir}:/tmp/repo/dependencies/ -v ${PWD}/.docker/:/tmp/repo/.docker/ --rm -t spsr /bin/bash -c \
#     "cd /tmp && git clone ${working_url} repotmp && \
#     cp -R repotmp/* repo/ && \
#     cd repo && \
#     pipenv install && \
#     make html && \
#     /tmp/utils/get-lib_deps.sh && \
#     /tmp/utils/get-pipenv_deps.sh && \
#     /tmp/utils/get-system_deps.sh"

# ## get installed dependencies on top of base
# diff ${PWD}/dependencies/base/system_deps.txt ${PWD}/dependencies/${working_dir}/system_deps.txt | perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/system_deps_diff.txt
# diff ${PWD}/dependencies/base/system_deps.csv ${PWD}/dependencies/${working_dir}/system_deps.csv perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/system_deps_diff.csv
# diff ${PWD}/dependencies/base/lib_deps.txt ${PWD}/dependencies/${working_dir}/lib_deps.txt perl -lne 'if(/^[<>]/){s/^..//g;print}' > ${PWD}/dependencies/${working_dir}/lib_deps_diff.txt