#!/usr/bin/env bash
set -xeuo pipefail

PROJECT_DIR=${PROJECT_DIR:-"${PWD}/nemotron-research-reasoning-qwen-1.5b"}

project_name='DAPO'
exp_name='DAPO-DS-R1-Distill-Qwen-1.5B'

# Ray
RAY_ADDRESS=${RAY_ADDRESS:-"http://localhost:8265"}
WORKING_DIR=${WORKING_DIR:-"${PWD}"}
RUNTIME_ENV=${RUNTIME_ENV:-"${WORKING_DIR}/dapo/runtime_env.yaml"}
# Paths
RAY_DATA_HOME=${RAY_DATA_HOME:-"${HOME}/nemotron-research-reasoning-qwen-1.5b"}
TRAIN_FILE=${TRAIN_FILE:-"${RAY_DATA_HOME}/data/deepscaler/train.parquet"}


ray job submit --no-wait --runtime-env="${RUNTIME_ENV}" \
    --working-dir "${WORKING_DIR}" \
    -- python3 -m verl.recipe.dapo.main_dapo \
    data.train_files="${TRAIN_FILE}" \
    custom_reward_function.path=${PROJECT_DIR}/data_preprocess/deepscaler_dataset.py \
    custom_reward_function.name=rllm_reward_fn_math_transformed \

