{ overlays
, pkgs
}:

{
  fonts = {
    packages = with pkgs; [
      recursive
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "JetBrainsMono"
        ];
      })
    ];
  };

  networking.computerName = "${pkgs.hostname}";

  nix = import ./nix.nix { inherit (pkgs) username; };

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
    inherit overlays;
  };

  programs = {
    ssh = {
      knownHosts = {
      };
    };
  };

  homebrew = import ./homebrew.nix { inherit pkgs; };
 
  security.pam.enableSudoTouchIdAuth = true;

  system = import ./macos.nix { inherit pkgs; };

  users.users.${pkgs.username} = {
    name = pkgs.username;
    home = pkgs.homeDirectory;
  };
}
