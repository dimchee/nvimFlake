{
    description = "My neovim configuration";
    inputs = {
        neovim.url = "github:nix-community/neovim-nightly-overlay";
        neuron.url = "github:srid/neuron";
    };
    outputs = { self, nixpkgs, neovim, neuron }: 
    let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        thisRepoPath = "/home/dimchee/Vim";
        addTSNvim = lang: ''
            cp  ${pkgs.tree-sitter.builtGrammars."tree-sitter-${lang}"}/parser ${thisRepoPath}/.cache/${lang}.so
        '';
        getNvimTreeSitter = list : pkgs.writeShellScriptBin "getNvimTreeSitter"
            (builtins.foldl' (x: y: x + y) "" (map addTSNvim list));
    in {
        # nixpkgs.overlays = [
        #    neovim.overlay
        #self: super: {
        #    ccls = super.ccls.overrideAttrs (old: {
        #        preConfigure = ''
        #            cmakeFlagsArray+=(-DCMAKE_CXX_FLAGS="-fvisibility=hidden -fno-rtti -std=c++17")
        #        '';
        #    });
        #}
        #];
        # overlay doesn't work for some reason
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.nvim;
        packages.x86_64-linux.nvim = pkgs.symlinkJoin {
            name = "my-nvim";
            paths = with pkgs; [
                pkgs.neovim   
                (getNvimTreeSitter [
                    "c" "nix" "rust" "go" "lua" "python" "zig" "latex" "julia" "bash" # "markdown"
                    "haskell" "agda" "ocaml" "toml" "javascript" "html" "json" #"glsl"
                ])

                haskellPackages.haskell-language-server
                nodePackages.pyright
                #nodePackages.purescript-language-server
                #elmPackages.elm-language-server
                rust-analyzer
                ccls
                gopls
                texlab
                rnix-lsp
                sumneko-lua-language-server
                zls
                neuron.packages.x86_64-linux.neuron
                neovim-remote
            ];

            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
                wrapProgram $out/bin/nvim --set XDG_CONFIG_HOME $out/etc
                ln -s $out/bin/nvim $out/bin/vim
                mkdir -p $out/etc/nvim
                # ln -s ${toString ./lua}  $out/etc/nvim/lua
                # ln -s ${toString ./plugin}  $out/etc/nvim/plugin
                # ln -s ${toString ./init.lua}  $out/etc/nvim/init.lua
                # Not working couse of flakes (first copy to store, then builds)
                # This is quick and dirty fix
                ln -s ${thisRepoPath}/.cache   $out/etc/nvim/plugin
                ln -s ${thisRepoPath}/.cache   $out/etc/nvim/parser
                ln -s ${thisRepoPath}/lua      $out/etc/nvim/lua
                ln -s ${thisRepoPath}/init.lua $out/etc/nvim/init.lua
                '';
        };
        devShell.x86_64-linux = pkgs.mkShell { buildInputs = [ self.packages.x86_64-linux.nvim ]; };
    };
}

# Search nixpkgs for symlinkJoin examples, and then make this work

# Basic flake created with <nix flake init>
# {
#   description = "A very basic flake";
# 
#   outputs = { self, nixpkgs }: {
# 
#     packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
# 
#     defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
# 
#   };
# }
