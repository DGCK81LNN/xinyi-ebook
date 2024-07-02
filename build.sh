#!/usr/bin/env bash
if [ "$1" = '--help' -o "$1" != "${1/\?}" ]; then echo "\
Usage: $(basename "$0") [ext]
  ext defaults to 'epub'" >&2; exit; fi
ext=$1
if [ ! "$ext" ]; then ext=epub; fi

pandoc chapters/* -s --metadata-file=meta.yml --lua-filter filters.lua \
  --split-level=2 --toc --toc-depth=2 --wrap=preserve \
  -c "css/$ext.css" -c css/common.css \
  -o 昕仪系列.$ext
