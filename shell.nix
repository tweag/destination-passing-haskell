with { pkgs = import ./nix {}; };

pkgs.mkShell
  { buildInputs = with pkgs; [
      bashInteractive
      python310Packages.pygments
      which
      gnumake
      # coq
      # coqPackages.coqide
      # haskellPackages.lhs2tex
      biber
      # ott
      pdftk
      entr
      (texlive.combine {
        inherit (texlive)
          # basic toolbox
          scheme-small
          cleveref
          latexmk
          biblatex biblatex-software
          bibtex
          stmaryrd
          unicode-math lm lm-math
          logreq xstring
          xargs todonotes
          mathpartir
          newunicodechar
          minted
          xpatch
          ulem
          enumitem
          placeins
          # regexpatch
          # for lhs2tex
          # lazylist polytable

          # for ott
          # supertabular

          # acmart and dependencies
          # acmart totpages trimspaces
          # libertine environ hyperxmp
          # ifmtarg comment ncctools
          # inconsolata newtx txfonts
          # xpatch xurl
          
          bussproofs
          tikz-cd
          ;
      })

      ];
    LANG="C.UTF-8";
    NIX_PATH = "nixpkgs=${pkgs.path}";
    FONTCONFIG_FILE = pkgs.makeFontsConf { fontDirectories =
    # Fonts for Xetex
    [ pkgs.libertine
      pkgs.inconsolata
    ]; };
  }
