## Quickstart

1. TODO: pull and run verl Docker image

2. Download the model **on the Ray cluster**:

```bash
bash model_download/download_model.sh
```

3. Prepare the data **on the Ray cluster**:

```bash
python3 data_preprocess/deepscaler.py
python3 data_preprocess/aime24.py
```

4. TODO: Submit the job to the Ray cluster **from any machine**:

```bash
cd verl # Repo root
export RAY_ADDRESS="http://${RAY_IP:-localhost}:8265" # The Ray cluster address to connect to
export WORKING_DIR="${PWD}" # The local directory to package to the Ray cluster
# Set the runtime environment like env vars and pip packages for the Ray cluster in yaml
export RUNTIME_ENV="./recipe/dapo/runtime_env.yaml" # This sets environment variables for the Ray cluster
bash recipe/dapo/run_dapo_qwen2.5_32b.sh # or other scripts
```
