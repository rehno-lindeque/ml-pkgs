self:
super:

import ./sandbox-overlays.nix self super
// {
  mlPackages = {
    # Utilities
    labelImg = self.python2Packages.callPackage ./pkgs/labelimg {};
  };
}

