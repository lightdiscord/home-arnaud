self: super:

{
  my-neovim = super.callPackage ../configs/neovim-files { };
}
