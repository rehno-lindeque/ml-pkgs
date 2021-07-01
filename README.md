# Machine Learning(-ish) overlay for nixpkgs

This is a collection of nix expressions that I've been using to explore a bunch of machine learning repos that don't necessarily fit in the main nixpkgs repo.

Don't expect a high quality set of nix expressions here (at least not for the time being), instead this is a super low friction repo for quickly commiting ML/data science related expressions.

There might also be the occasional computer graphics tool in here, e.g. for stitching images. Basically, anything goes.

## Setup with CUDA

If you would like to use cuda (usually necessary for practical purposes), first download cudnn from https://developer.nvidia.com/rdp/cudnn-download.

Then add it to the nix store as follows:

    nix-store --add-fixed sha256 cudnn-9.1-linux-x64-v7.1.tgz
    nix-prefetch-url file://$PWD/cudnn-9.1-linux-x64-v7.1.tgz

## Usage

This is not yet an overlay, for the time being just run `nix-build -E 'with import <nixpkgs> {}; callPackage ./. {}'` in whichever directory you're interested in.

Some packages come with a `sandbox.nix` file. The `nix-shell` tool is normally used to describe development environments for a package, but in this repo we (ab-)use it to create sandbox environments with usage info, and other helpful modifications. Simply run `nix-shell sandbox.nix` in a package directory with this file to get going.

## Contributing

Note that commit access might be automatically handed out for submitting 1 or 2 succesfull PRs and also revoked for any reason, or no reason at all.

Submit serious work to directly to NixOS/nixpkgs, this repo is for experimentation (at least, for the time being).

## License

Identical to nixpkgs in order to make it easy to pull stuff across: expressions are MIT licensed (except where it is fetched from some other location, e.g. via `fetchurl`) but packages installed by the expressions are under their own licenses.

## Additional hints

### Working with your own datasets

You may notice that `sandbox.nix` usage help prints the following sorts of messages:

    retinanet-train pascal $PATH_TO_PASCAL_DATASET

My personal strategy for managing my paths is to create a .envrc file in the root of this repo which looks like this:

    PATH_TO_PASCAL_DATASET=/path/to/my/pascal/dataset

Then you can simply run

    source ../../.envrc
    retinanet-train pascal $PATH_TO_PASCAL_DATASET

without needing to remember where in the world you put that pesky dataset (or any other parameters).

It is also possible to use [direnv](https://direnv.net/) for this purpose.

## See also

It may be worth checking out

* [AWS EC2 GPU cluster with NixOps (Tesla V100 node x4)](https://www.youtube.com/watch?v=pfaRECFJnak)
* [ec2-gpu-cluster-with-NixOps](https://github.com/hyphon81/ec2-gpu-cluster-with-NixOps) with accompanying [video](https://www.youtube.com/watch?v=miwTwKCBqoM)
* This [presentation](https://github.com/Tokyo-NixOS/presentations/tree/master/2017/06/machine-learning)

