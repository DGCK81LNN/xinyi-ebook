#!/usr/bin/env bash
readarray -td '' srcfiles < <(find . -type f -name '*.textile' -print0) &&
for srcfile in "${srcfiles[@]}"; do
  args=(--wrap=preserve)
  (set -x; pandoc "$srcfile" "${args[@]}" -o "${srcfile%.*}.html") || exit $?
done &&

sed '/<!--CONTENT-->/{r index.html'$'\n''d}' _index.html > index_.html &&
mv index_.html index.html
