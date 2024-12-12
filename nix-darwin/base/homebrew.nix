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
    "adobe-acrobat-reader"
    "alfred"
    "bartender"
    "discord"
    "drivethrurpg"
    "font-fira-code"
    "notion"
    "obsidian"
    "spotify"
    "visual-studio-code"
    "zotero"
  ];
}
