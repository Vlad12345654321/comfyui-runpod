#!/usr/bin/env bash
set -e

COMFY_SRC="/opt/ComfyUI"
COMFY_DST="/workspace/ComfyUI"

# Если в volume нет ComfyUI — копируем шаблон из образа
if [ ! -d "$COMFY_DST" ]; then
  mkdir -p /workspace
  cp -a "$COMFY_SRC" "$COMFY_DST"
fi

# Гарантируем папки (всё хранится в volume)
mkdir -p "$COMFY_DST/models" "$COMFY_DST/input" "$COMFY_DST/output"

cd "$COMFY_DST"
python3 main.py --listen 0.0.0.0 --port 8188
