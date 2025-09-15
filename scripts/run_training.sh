#!/bin/bash
set -e

# === Environment variables ===
export HF_REPO_ID="deepseek-ai/DeepSeek-R1-Distill-Qwen-1.5B"
export MODEL_DIR="$HOME/models/qwen-1.5b"
# export CONFIG_PATH="$(dirname "$0")/../config.yaml"

echo "[INFO] Using HF repo ID: $HF_REPO_ID"
echo "[INFO] Using model directory: $MODEL_DIR"
# echo "[INFO] Using config file: $CONFIG_PATH"

# Download the model if not already present
python3 "$(dirname "$0")/download_model.py"

# # Run training
# python3 -m src.dshen_nemotron.training.controller --config "$CONFIG_PATH"
