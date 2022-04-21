#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-prefetch-scripts

set -eou pipefail

version=$1
date=$2

# Setting TMPDIR side-steps "No space left on device" in nix-prefetch-url which can run out of RAM.
export TMPDIR="$(mktemp -d)"

linux_bucket="https://download.pytorch.org/whl/nightly/cu113"

url_and_key_list=(
  "x86_64-linux-37 $linux_bucket/torch-${version}.dev${date}%2Bcu113-cp37-cp37m-linux_x86_64.whl torch-${version}.dev${date}-cp37-cp37m-linux_x86_64.whl"
  "x86_64-linux-38 $linux_bucket/torch-${version}.dev${date}%2Bcu113-cp38-cp38-linux_x86_64.whl torch-${version}.dev${date}-cp38-cp38-linux_x86_64.whl"
  "x86_64-linux-39 $linux_bucket/torch-${version}.dev${date}%2Bcu113-cp39-cp39-linux_x86_64.whl torch-${version}.dev${date}-cp39-cp39-linux_x86_64.whl"
  "x86_64-linux-310 $linux_bucket/torch-${version}.dev${date}%2Bcu113-cp310-cp310-linux_x86_64.whl torch-${version}.dev${date}-cp310-cp310-linux_x86_64.whl"
)

hashfile="nightly-binary-hashes-$version.nix"
echo "  \"$version\" = {" >> $hashfile
echo "    \"$date\" = {" >> $hashfile

for url_and_key in "${url_and_key_list[@]}"; do
  key=$(echo "$url_and_key" | cut -d' ' -f1)
  url=$(echo "$url_and_key" | cut -d' ' -f2)
  name=$(echo "$url_and_key" | cut -d' ' -f3)

  echo "prefetching ${url} to ${name}..."
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
