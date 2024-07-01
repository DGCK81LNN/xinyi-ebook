#!/usr/bin/env bash
pandoc c*.textile --metadata-file=meta.yml -c style.css \
  --split-level=2 --toc --toc-depth=2 \
  --wrap=preserve \
  -o 昕仪系列.epub
