#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-scripts

set -eou pipefail

version=$1
date=$2

linux_bucket="https://download.pytorch.org/whl/nightly"
darwin_bucket="https://download.pytorch.org/whl/nightly"

url_and_key_list=(
  "x86_64-linux-37 $linux_bucket/torchtext-${version}.dev${date}-cp37-cp37m-linux_x86_64.whl torchtext-${version}.dev${date}-cp37-cp37m-linux_x86_64.whl"
  "x86_64-linux-38 $linux_bucket/torchtext-${version}.dev${date}-cp38-cp38-linux_x86_64.whl torchtext-${version}.dev${date}-cp38-cp38-linux_x86_64.whl"
  "x86_64-linux-39 $linux_bucket/torchtext-${version}.dev${date}-cp39-cp39-linux_x86_64.whl torchtext-${version}.dev${date}-cp39-cp39-linux_x86_64.whl"
  "x86_64-linux-310 $linux_bucket/torchtext-${version}.dev${date}-cp310-cp310-linux_x86_64.whl torchtext-${version}.dev${date}-cp310-cp310-linux_x86_64.whl"
  "x86_64-darwin-37 $darwin_bucket/torchtext-${version}.dev${date}-cp37-cp37m-macosx_10_9_x86_64.whl torchtext-${version}.dev${date}-cp37-cp37m-macosx_10_9_x86_64.whl"
  "x86_64-darwin-38 $darwin_bucket/torchtext-${version}.dev${date}-cp38-cp38-macosx_10_9_x86_64.whl torchtext-${version}.dev${date}-cp38-cp38-macosx_10_9_x86_64.whl"
  "x86_64-darwin-39 $darwin_bucket/torchtext-${version}.dev${date}-cp39-cp39-macosx_10_9_x86_64.whl torchtext-${version}.dev${date}-cp39-cp39-macosx_10_9_x86_64.whl"
  "x86_64-darwin-310 $darwin_bucket/torchtext-${version}.dev${date}-cp310-cp310-macosx_10_9_x86_64.whl torchtext-${version}.dev${date}-cp310-cp310-macosx_10_9_x86_64.whl"
)

hashfile="nightly-binary-hashes-$version.nix"
echo "  \"$version\" = {" >> $hashfile
echo "    \"$date\" = {" >> $hashfile

for url_and_key in "${url_and_key_list[@]}"; do
  key=$(echo "$url_and_key" | cut -d' ' -f1)
  url=$(echo "$url_and_key" | cut -d' ' -f2)
  name=$(echo "$url_and_key" | cut -d' ' -f3)

  echo "prefetching ${url}..."
  hash=$(nix hash to-sri --type sha256 `nix-prefetch-url "$url" --name "$name"`)

  echo "      $key = {" >> $hashfile
  echo "        name = \"$name\";" >> $hashfile
  echo "        url = \"$url\";" >> $hashfile
  echo "        hash = \"$hash\";" >> $hashfile
  echo "      };" >> $hashfile

  echo
done

echo "    };" >> $hashfile
echo "  };" >> $hashfile
echo "done."
