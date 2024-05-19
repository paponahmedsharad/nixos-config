{ config, pkgs, inputs, ... }:

{
  # nixpkgs.config.permittedInsecurePackages = [ "nix-2.15.3" ];
  # nixpkgs.overlays = [
  #   (self: super: {
  #     vimPlugins = super.vimPlugins // {
  #       onedark-nvim = super.vimUtils.buildVimPlugin {
  #         name = "onedark";
  #         src = inputs.plugin-onedark;
  #       };
  #     };
  #     # stable = inputs.nixpkgs-stable.legacyPackages.${pkgs.system};
  #   })
  # ];
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    # viAlias = true;
    # vimAlias = true;
    # vimdiffAlias = true;
    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp
      xclip
    ];

    plugins = with pkgs.vimPlugins; [
      # { plugin = onedark-nvim;
      # config = "colorscheme onedark";
      # }
      { plugin = markdown-preview-nvim;
        # config = toLua "require(\"Comment\").setup()";
      }
    ];
  };
}
