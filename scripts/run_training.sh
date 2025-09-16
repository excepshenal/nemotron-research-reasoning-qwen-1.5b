#!/bin/bash
set -e

# === Environment variables ===
export MODEL_HF_REPO_ID="deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
export MODEL_DIR="$HOME/models/qwen-1.5b"

export DATASET_HF_REPO_ID="agentica-org/DeepScaleR-Preview-Dataset"
export DATASET_DIR="$HOME/datasets/DeepScaleR-Preview-Dataset"

# export CONFIG_PATH="$(dirname "$0")/../config.yaml"

echo "[INFO] Using model HF repo ID: $MODEL_HF_REPO_ID"
echo "[INFO] Using model directory: $MODEL_DIR"
# echo "[INFO] Using config file: $CONFIG_PATH"

# Download the model if not already present
python3 "$(dirname "$0")/download_model.py"

# Download the dataset if not already present
python3 "$(dirname "$0")/download_dataset.py"

# # Run training
# python3 -m src.dshen_nemotron.training.controller --config "$CONFIG_PATH"
