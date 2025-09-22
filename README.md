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

4. Submit the job to the Ray cluster **from any machine**:

```bash
cd nemotron-research-reasoning-qwen-1.5b # repo root
export WANDB_API_KEY=<your_wandb_api_key>
bash dapo/run_dapo_ds_r1_distill_qwen_1.5b.sh
```
