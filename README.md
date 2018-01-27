# Machine Learning(-ish) overlay for nixpkgs

This is a collection of nix expressions that I've been using to explore a bunch of machine learning repos that don't necessarily fit in the main nixpkgs repo.

Don't expect a high quality set of nix expressions here (at least not for the time being), instead this is a super low friction repo for quickly commiting ML/data science related expressions.

There might also be the occasional computer graphics tool in here, e.g. for stitching images. Basically, anything goes.

## Usage

This is not yet an overlay, for the time being just run `nix-build -E 'with import <nixpkgs> {}; callPackage ./. {}'` in whichever directory you're interested in.

## Contributing

Note that commit access might be automatically handed out for submitting 1 or 2 succesfull PRs and also revoked for any reason, or no reason at all.

Submit serious work to directly to NixOS/nixpkgs, this repo is for experimentation (at least, for the time being).

## License

Identical to nixpkgs in order to make it easy to pull stuff across: expressions are MIT licensed (except where it is fetched from some other location, e.g. via `fetchurl`) but packages installed by the expressions are under their own licenses.
