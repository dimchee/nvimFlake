# dont forget to run in ~/Nix/Sys
# nix flake lock --update-input neovim
{
    description = "My neovim configuration";
    inputs = {
        neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";
        neuron.url = "github:srid/neuron";
    };
    outputs = { self, nixpkgs, neovim-overlay, neuron }: 
    let
        thisRepoPath = "/home/dimchee/Nix/Vim";
        runtimePath = "${thisRepoPath},~/.config/nvim,~/.local/share/nvim/site,$VIMRUNTIME,${thisRepoPath}/after";
        pkgs = import nixpkgs {
            overlays = [
                neovim-overlay.overlay
                (self: super: {
                    ccls = super.ccls.overrideAttrs (old: {
                        preConfigure = ''
                            cmakeFlagsArray+=(-DCMAKE_CXX_FLAGS="-fvisibility=hidden -fno-rtti -std=c++17")
                        '';
                    });
                })
            ];
            system = "x86_64-linux";
        };
    in {
        # overlay doesn't work for some reason
        defaultPackage.x86_64-linux = self.packages.x86_64-linux.nvim;
        packages.x86_64-linux.nvim = pkgs.symlinkJoin {
            name = "my-nvim";
            paths = with pkgs; [
                neovim   
                clang-tools # for treesitter grammar installation

                haskellPackages.haskell-language-server
                nodePackages.pyright
                # go get -u github.com/arduino/arduino-language-server
                # nodePackages.typescript-language-server
                # nodePackages.typescript
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
            wrapProgram $out/bin/nvim \
                --set VIM_HOME ${thisRepoPath} \
		            --set VIMINIT 'set runtimepath=${runtimePath} | ru init.lua'
		        ln -s $out/bin/nvim $out/bin/vim
            '';
        };
        devShell.x86_64-linux = pkgs.mkShell { buildInputs = [ self.packages.x86_64-linux.nvim ]; };
    };
}
