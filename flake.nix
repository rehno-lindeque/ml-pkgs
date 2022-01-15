{
  description = "My collection of machine learning packages for nix";
 
  outputs = { self, ... }: {

    # Default overlay with overrides included for current python 3.x package sets
    overlay = final:
      final.composeManyExtensions
        [ self.overlays.python37
          self.overlays.python38
          self.overlays.python39
          self.overlays.python310
        ]
        final;

    overlays = import ./overlays.nix;

  };
}
