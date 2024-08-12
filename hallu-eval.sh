NGPUS=4
MODEL_PATHS=(
    llama2-7b-kd  /scratch1/hieutn/ckps-selfkd-hpo-new/e3-bs8-lr5e-06-G1-N4-NN1-kd1.0-mp4/3750/
    llama2-7b-baseline /scratch1/hieutn/ckps-sft-hpo/e3-bs4-lr5e-06-G1-N4-NN1-mp4/7500/
)

for ((i=0; i<${#MODEL_PATHS[@]}; i+=2)) do
    SAVE_PATH=${MODEL_PATHS[i]}
    MODEL_PATH=${MODEL_PATHS[i+1]}
    ARGS=""
    ARGS+=" --model vllm"
    ARGS+=" --model_args pretrained=${MODEL_PATH},tensor_parallel_size=${NGPUS},gpu_memory_utilization=0.9"
    ARGS+=" --tasks halueval_summarization,xsum_v2,cnndm_v2"
    ARGS+=" --batch_size auto"
    ARGS+=" --log_samples"
    ARGS+=" --output_path saves/${SAVE_PATH}"

    echo "lm_eval ${ARGS}"
done
