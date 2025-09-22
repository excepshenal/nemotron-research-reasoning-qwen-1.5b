## Quickstart

1. On your training node, pull and run the `veRL` Docker image, mounting the repos:

```bash
docker pull verlai/verl:app-verl0.5-transformers4.55.4-vllm0.10.0-mcore0.13.0-te2.2
docker run -it --rm \
  -v /data:/data \
  -v /models:/models \
  verlai/verl:app-verl0.5-transformers4.55.4-vllm0.10.0-mcore0.13.0-te2.2 \
  bash
```

2. **Inside the Docker container**, continue with the instructions below. Clone the `veRL` repo and this repo, and change into this repo:

```bash
git clone https://github.com/volcengine/verl.git
git clone https://github.com/excepshenal/nemotron-research-reasoning-qwen-1.5b.git
cd nemotron-research-reasoning-qwen-1.5b
```

3. Download the model:

```bash
python3 model_download/download_model.py
```

4. Prepare the data:

```bash
python3 data_preprocess/deepscaler.py
python3 data_preprocess/aime24.py
```

5. Submit the job to the Ray cluster:

```bash
ray start --head
```

or

```bash
ray start --address='<head_node_ip>:6379'
```

You can monitor the status of the cluster with `ray status`.

6. Submit the job to the Ray cluster:

```bash
export RAY_ADDRESS="http://${RAY_IP:-localhost}:8265"
export WANDB_API_KEY=<your_wandb_api_key>
bash dapo/run_dapo_ds_r1_distill_qwen_1.5b.sh
```
