#!/usr/bin/env python3
"""
Download the DeepScaleR-Preview-Dataset from Hugging Face
and save it to the path specified by the environment variable DATASET_DIR.
"""

import os
import sys
from pathlib import Path
from datasets import load_dataset


def download_dataset(repo_id: str, output_dir: Path | None):
    if os.path.exists(output_dir):
        print(f"[INFO] Dataset {repo_id} already exists at {output_dir}, skipping download.")
        return
    
    print(f"[INFO] Downloading dataset {repo_id} to {output_dir} ...")

    output_dir.mkdir(parents=True)

    try:
        load_dataset(
            repo_id=repo_id, 
            cache_dir=str(output_dir)
        )
    except Exception as e:
        print(f"[ERROR] Failed to download dataset: {e}", file=sys.stderr)
        sys.exit(1)
    
    print(f"[INFO] Dataset {repo_id} is available at {output_dir}")


def main():
    hf_repo_id = os.getenv("DATASET_HF_REPO_ID")
    if not hf_repo_id:
        print("[ERROR] Missing required environment variable: DATASET_HF_REPO_ID", file=sys.stderr)
        sys.exit(1)

    dataset_dir = os.getenv("DATASET_DIR")
    if not dataset_dir:
        print("[ERROR] Missing required environment variable: DATASET_DIR", file=sys.stderr)
        sys.exit(1)
    dataset_dir = Path(dataset_dir)

    download_dataset(hf_repo_id, dataset_dir)


if __name__ == "__main__":
    main()
