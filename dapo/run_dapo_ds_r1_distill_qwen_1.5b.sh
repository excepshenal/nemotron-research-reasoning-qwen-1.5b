#!/usr/bin/env bash
set -xeuo pipefail

# Params from "Scaling Up RL" paper unless otherwise specified

# Data

# DeepScaleR prompts are usually < 100 tokens, so this is very comfortable
max_prompt_length=1024
# "Scaling Up RL" sets context window limit at 8096
max_response_length=$((8096 - 1024))

# Actor

train_prompt_bsz=256
train_prompt_mini_bsz=64
# use dynamic micro batch size
ppo_max_token_len_per_gpu=16384 # from verl example dapo scripts

clip_ratio_low=0.2
clip_ratio_high=0.4

use_kl_loss=True
kl_loss_coef=0.0001

actor_optim_lr=2e-6

# Filepaths

PROJECT_DIR=${PROJECT_DIR:-"${HOME}/nemotron-research-reasoning-qwen-1.5b"}
MODEL_PATH=${MODEL_PATH:-"${HOME}/models/ds-r1-distill-qwen-1.5b"}
TRAIN_FILE=${TRAIN_FILE:-"${HOME}/data/deepscaler/train.parquet"}
TEST_FILE=${TEST_FILE:-"${HOME}/data/aime24/test.parquet"}

# Ray
RAY_ADDRESS=${RAY_ADDRESS:-"http://localhost:8265"}
WORKING_DIR=${WORKING_DIR:-"${PROJECT_DIR}"}
RUNTIME_ENV=${RUNTIME_ENV:-"${PROJECT_DIR}/dapo/runtime_env.yaml"}

# Defaults are set in verl/recipe/dapo/config/dapo_trainer.yaml,
# which itself references verl/trainer/config/ppo_trainer.yaml.
# Some defaults include:
# - actor_rollout_ref.actor.strategy: fsdp
# - fsdp offload params: False (unnecessary for 1.5b model)
ray job submit --no-wait --runtime-env="${RUNTIME_ENV}" \
    --working-dir "${WORKING_DIR}" \
    -- python3 -m verl.recipe.dapo.main_dapo \
    data.train_files="${TRAIN_FILE}" \
    data.val_files="${TEST_FILE}" \
    data.prompt_key=prompt \
    data.max_prompt_length=${max_prompt_length} \
    data.max_response_length=${max_response_length} \
    data.train_batch_size=${train_prompt_bsz} \
    actor_rollout_ref.model.path=${MODEL_PATH} \
    actor_rollout_ref.model.remove_padding=True \
    actor_rollout_ref.model.enable_gradient_checkpointing=True \
    actor_rollout_ref.actor.ppo_mini_batch_size=${train_prompt_mini_bsz} \
    actor_rollout_ref.actor.use_dynamic_bsz=True \
    actor_rollout_ref.actor.ppo_max_token_len_per_gpu=${ppo_max_token_len_per_gpu} \
    actor_rollout_ref.actor.clip_ratio_low=${clip_ratio_low} \
    actor_rollout_ref.actor.clip_ratio_high=${clip_ratio_high} \
    actor_rollout_ref.actor.use_kl_loss=${use_kl_loss} \
    actor_rollout_ref.actor.kl_loss_coef=${kl_loss_coef} \
    actor_rollout_ref.actor.use_torch_compile=True \
    actor_rollout_ref.actor.optim.lr=${actor_optim_lr} \
    custom_reward_function.path=${PROJECT_DIR}/reward/rllm_reward.py \
    custom_reward_function.name=rllm_reward_fn_math_transformed \
