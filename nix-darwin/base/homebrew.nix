{ pkgs }:

{
  enable = true;
  onActivation.cleanup = "uninstall";
  brews = [
    "coreutils"
  ];
  casks = [
    "1password-cli"
    "1password"
    "alfred"
    "bartender"
    "discord"
    "drivethrurpg"
    "font-fira-code"
    "obsidian"
    "spotify"
    "visual-studio-code"
    "zotero"
  ];
}
