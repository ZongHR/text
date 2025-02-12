#!/usr/bin/env bash

unset PYTORCH_VERSION
# For unittest, nightly PyTorch is used as the following section,
# so no need to set PYTORCH_VERSION.
# In fact, keeping PYTORCH_VERSION forces us to hardcode PyTorch version in config.

set -e

eval "$(./conda/bin/conda shell.bash hook)"
conda activate ./env

printf "* Installing PyTorch\n"
conda install -y -c "pytorch-${UPLOAD_CHANNEL}" ${CONDA_CHANNEL_FLAGS} pytorch cpuonly

printf "Installing torchdata from source\n"
pip install git+https://github.com/pytorch/data.git

printf "* Installing torchtext\n"
git submodule update --init --recursive
python setup.py develop

printf "* Installing parameterized\n"
pip install parameterized
