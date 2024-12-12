{ pkgs }:

let
  colorTheme = "Atom One Dark";
  font = "FiraCode Nerd Font Mono, monospace";
  terminalFont = "FiraCode Nerd Font Mono";
  iconTheme = "material-icon-theme";

  ext = publisher: name: version: sha256: pkgs.vscode-utils.buildVscodeMarketplaceExtension {
    mktplcRef = { inherit name publisher sha256 version; };
  };
in
{
  enable = true;

  enableExtensionUpdateCheck = true;

  extensions = (with pkgs.vscode-extensions; [
    bbenoist.nix
    bradlc.vscode-tailwindcss
    editorconfig.editorconfig
    esbenp.prettier-vscode
    github.vscode-github-actions
    github.github-vscode-theme
    prisma.prisma
    tamasfe.even-better-toml
    unifiedjs.vscode-mdx
  ]) ++ [
    # Extensions not in Nixpkgs
    (ext "astro-build" "astro-vscode" "2.8.5" "sha256-mP+MKHDirgemcexSCof/Be7YN2FTXwOnGQHnmtKLgtM=")
    (ext "b4dM4n" "nixpkgs-fmt" "0.0.1" "sha256-vz2kU36B1xkLci2QwLpl/SBEhfSWltIDJ1r7SorHcr8=")
    (ext "jeff-hykin" "better-nix-syntax" "1.0.7" "sha256-vqfhUIjFBf9JvmxB4QFrZH4KMhxamuYjs5n9VyW/BiI=")
    (ext "mkhl" "direnv" "0.17.0" "sha256-9sFcfTMeLBGw2ET1snqQ6Uk//D/vcD9AVsZfnUNrWNg=")
    (ext "ms-vscode" "vscode-typescript-next" "5.4.20231127" "sha256-UVuYggzeWyQTmQxXdM4sT78FUOtYGKD4SzREntotU5g=")
    (ext "akamud" "vscode-theme-onedark" "2.3.0" "1km3hznw8k0jk9sp3r81c89fxa311lc6gw20fqikd899pvhayqgh")
  ];

  globalSnippets = { };

  keybindings = [ ];

  mutableExtensionsDir = false;

  userSettings = {
    "[nix]" = {
      "editor.defaultFormatter" = "B4dM4n.nixpkgs-fmt";
      "editor.formatOnSave" = true;
    };
    "[rust]" = {
      "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      "editor.formatOnSave" = true;
    };
    "[toml]" = {
      "editor.defaultFormatter" = "tamasfe.even-better-toml";
      "editor.formatOnSave" = true;
    };
    "editor.wordWrap" = "wordWrapColumn";
    "editor.wordWrapColumn" = 120;
    "search.exclude" = {
      "**/.direnv" = true;
      "**/.git" = true;
      "**/node_modules" = true;
      "*.lock" = true;
      "dist" = true;
      "tmp" = true;
    };
    "rust-analyzer.server.path" = "rust-analyzer";
    "editor.defaultFormatter" = "esbenp.prettier-vscode";
    "editor.fontFamily" = font;
    "editor.fontSize" = 14;
    "editor.fontLigatures" = true;
    "terminal.integrated.fontFamily" = terminalFont;
    "workbench.colorTheme" = colorTheme;
    "workbench.iconTheme" = iconTheme;
  };
}
