# Machine Learning(-ish) nix packages

This is a collection of nix expressions that I've been using to explore a bunch of machine learning repos that don't necessarily fit in the main nixpkgs repo.

There is no overlay because I expect packages to be broken most of the time and only fix the ones that I'm actively using.

There might also be the occasional computer graphics tool in here, e.g. for stitching images. Basically, anything goes.

## Sandbox nix expressions

Occassionally I leave a `sandbox.nix` file. These are just examples for quickly and directly experimenting with a package in-place if you've cloned this repo.

Simply run `nix-shell sandbox.nix` in a package directory in order to get going.

You may notice that `sandbox.nix` usage help prints the following sorts of messages:

    retinanet-train pascal $PATH_TO_PASCAL_DATASET

My personal strategy for managing my paths is to create a .envrc file in the root of this repo which looks like this:

    PATH_TO_PASCAL_DATASET=/path/to/my/pascal/dataset

Then you can simply run

    source ../../.envrc
    retinanet-train pascal $PATH_TO_PASCAL_DATASET

without needing to remember where in the world you put that pesky dataset (or any other parameters).

It is also possible to use [direnv](https://direnv.net/) for this purpose or otherwise modify the `sandbox.nix` file directly.

## Additional hints

See https://josephsdavid.github.io/nix.html and https://josephsdavid.github.io/nix2.html for some ideas around training models with nix in a reproducible fashion.

## License

Identical to nixpkgs in order to make it easy to pull stuff across: expressions are MIT licensed (except where it is fetched from some other location, e.g. via `fetchurl`) but packages installed by the expressions are under their own licenses.

