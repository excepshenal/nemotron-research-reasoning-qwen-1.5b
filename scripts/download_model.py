#!/usr/bin/env python3
"""
Download the DeepSeek-R1-Distill-Qwen-1.5B model from Hugging Face
to the path specified by the environment variable MODEL_DIR.

Defaults to ~/models/deepseek-qwen-1.5b if MODEL_DIR is not set.
"""

import os
import sys
from pathlib import Path
from huggingface_hub import snapshot_download


def download_model(repo_id: str, output_dir: Path):
    if os.path.exists(output_dir):
        print(f"[INFO] Model {repo_id} already exists at {output_dir}, skipping download.")
        return

    output_dir.mkdir(parents=True)
    print(f"[INFO] Downloading {repo_id} to {output_dir} ...")

    snapshot_download(
        repo_id=repo_id,
        local_dir=str(output_dir),
        local_dir_use_symlinks=False,  # safer when mounting into Docker
    )

    print(f"[INFO] Model {repo_id} available at {output_dir}")


def main():
    hf_repo_id = os.getenv("HF_REPO_ID")
    if not hf_repo_id:
        print("[ERROR] Missing required environment variable: HF_REPO_ID", file=sys.stderr)
        sys.exit(1)

    model_dir = os.getenv("MODEL_DIR")
    if not model_dir:
        print("[ERROR] Missing required environment variable: MODEL_DIR", file=sys.stderr)
        sys.exit(1)
    model_dir = Path(model_dir)

    download_model(hf_repo_id, model_dir)


if __name__ == "__main__":
    main()
