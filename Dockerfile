FROM nvidia/cuda:12.1.1-cudnn-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PYTHONUNBUFFERED=1

# Base system
RUN apt-get update && apt-get install -y \
    git python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Torch 2.4.1 + CUDA 12.1 (ключевой момент)
RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install \
    torch==2.4.1+cu121 \
    torchvision==0.19.1+cu121 \
    torchaudio==2.4.1+cu121 \
    --index-url https://download.pytorch.org/whl/cu121

# ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /opt/ComfyUI
RUN python3 -m pip install -r /opt/ComfyUI/requirements.txt

# Custom nodes
RUN mkdir -p /opt/ComfyUI/custom_nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git \
    /opt/ComfyUI/custom_nodes/ComfyUI-Manager
RUN git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git \
    /opt/ComfyUI/custom_nodes/ComfyUI_IPAdapter_plus

# Start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8188
CMD ["/start.sh"]
