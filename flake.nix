# ~/.config/nix/flake.nix

{
  description = "Toby's Machines Config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
    let
      configuration = { pkgs, ... }: {

        nixpkgs.config.allowUnfree = true;
        nixpkgs.config.allowUnfreePredicate = _: true;

        services.nix-daemon.enable = true;
        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility. please read the changelog
        # before changing: `darwin-rebuild changelog`.
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        # If you're on an Intel system, replace with "x86_64-darwin"
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Declare the user that will be running `nix-darwin`.
        users.users.toby = {
          name = "toby";
          home = "/Users/toby";
        };

        nix.settings.trusted-users = [ "toby" ];

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true;

        environment.systemPackages = with pkgs; [
          (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
          curl
          direnv
          fd
          findutils
          ripgrep
          texliveFull
          tesseract

          # formatters
          prettierd
          html-tidy
          nixfmt-classic
          black
          rustfmt
          scalafmt
          # emacsPackages.sqlformat
          ormolu

          # language tools
          cookiecutter

          # lisp
          coreutils
          gcc
          sbcl
          # emacsPackages.slime
        ];

        environment.pathsToLink = [ "/share/zsh" ];

        homebrew = {
          enable = true;
          onActivation.cleanup = "uninstall";
          # taps = [ "railwaycat/emacsmacport" ];
          brews = [
            "coreutils"
            # "php"
            # {
            #   name = "emacs-mac";
            #   args = [ "with-natural-title-bar" "with-starter" ];
            # }
          ];
          casks = [
            "1password-cli"
            "discord"
            "font-3270-nerd-font"
            "font-agave-nerd-font"
            "font-anonymice-nerd-font"
            "font-arimo-nerd-font"
            "font-aurulent-sans-mono-nerd-font"
            "font-bigblue-terminal-nerd-font"
            "font-bitstream-vera-sans-mono-nerd-font"
            "font-blex-mono-nerd-font"
            "font-caskaydia-cove-nerd-font"
            "font-code-new-roman-nerd-font"
            "font-cousine-nerd-font"
            "font-daddy-time-mono-nerd-font"
            "font-dejavu-sans-mono-nerd-font"
            "font-droid-sans-mono-nerd-font"
            "font-fantasque-sans-mono-nerd-font"
            "font-fira-code-nerd-font"
            "font-fira-mono-nerd-font"
            "font-go-mono-nerd-font"
            "font-hack-nerd-font"
            "font-hasklug-nerd-font"
            "font-heavy-data-nerd-font"
            "font-hurmit-nerd-font"
            "font-im-writing-nerd-font"
            "font-inconsolata-go-nerd-font"
            "font-inconsolata-lgc-nerd-font"
            "font-inconsolata-nerd-font"
            "font-iosevka-nerd-font"
            "font-jetbrains-mono-nerd-font"
            "font-lekton-nerd-font"
            "font-liberation-nerd-font"
            "font-meslo-lg-nerd-font"
            "font-monofur-nerd-font"
            "font-monoid-nerd-font"
            "font-mononoki-nerd-font"
            "font-mplus-nerd-font"
            "font-noto-nerd-font"
            "font-open-dyslexic-nerd-font"
            "font-overpass-nerd-font"
            "font-proggy-clean-tt-nerd-font"
            "font-roboto-mono-nerd-font"
            "font-sauce-code-pro-nerd-font"
            "font-shure-tech-mono-nerd-font"
            "font-space-mono-nerd-font"
            "font-terminess-ttf-nerd-font"
            "font-tinos-nerd-font"
            "font-ubuntu-mono-nerd-font"
            "font-ubuntu-nerd-font"
            "font-victor-mono-nerd-font"
          ];
        };

        security.pam.enableSudoTouchIdAuth = true;

        system.defaults = {
          # minimal dock
          dock = {
            autohide = true;
            orientation = "left";
            show-process-indicators = true;
            show-recents = false;
            static-only = true;
            magnification = false;
            tilesize = 32;
          };
          # a finder that tells me what I want to know and lets me work
          finder = {
            AppleShowAllExtensions = true;
            ShowPathbar = true;
            FXEnableExtensionChangeWarning = false;
          };
          NSGlobalDomain = {
            # Disable press-and-hold for keys in favor of key repeat
            ApplePressAndHoldEnabled = false;

            # Enable subpixel font rendering on non-Apple LCDs
            # Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
            AppleFontSmoothing = 1;

            # Set a blazingly fast keyboard repeat rate
            InitialKeyRepeat = 10;
            KeyRepeat = 1;

            # Disable all these since they are annoying when writing code
            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
          };
        };

      };
      homeconfig = { pkgs, ... }: {
        # this is internal compatibility configuration
        # for home-manager, don't change this!
        home.stateVersion = "23.05";

        # Let home-manager install and manage itself.
        programs.home-manager.enable = true;

        programs.direnv = {
          enable = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };

        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          shellAliases = {
            switch = "darwin-rebuild switch --flake ~/.config/nix";
            z = "j";
          };

          oh-my-zsh = {
            enable = true;
            plugins = [ "git" "autojump" "direnv" ];
            theme = "robbyrussell";
          };

          initExtra = ''
            export PATH="/Users/toby/.local/bin:$PATH"
            eval "$(direnv hook zsh)"
          '';
        };

        programs.git = {
          enable = true;
          userName = "Toby Shearman";
          userEmail = "toby.shearman@gmail.com";
          ignores = [ ".DS_Store" "result/" "result" ];
          aliases = {
            co = "checkout";
            br = "branch";
            d = "diff";
            st = "status";
            ci = "commit";
          };
          delta.enable = true;
          lfs.enable = true;
          extraConfig.init.defaultBranch = "main";
          extraConfig.push.autoSetupRemote = true;
        };

        home.packages = with pkgs; [ autojump ];
      };
    in {
      darwinConfigurations."macbook" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.toby = homeconfig;
          }
        ];
      };
    };
}
