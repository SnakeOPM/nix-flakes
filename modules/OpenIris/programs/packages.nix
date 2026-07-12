{ pkgs, ... }:
{
  environment.systemPackages = builtins.attrValues {
    inherit (pkgs)
      home-manager
      pay-respects
      kitty
      awww
      ;
  };
  programs = {
    droidcam.enable = true;
    nix-ld = {
      enable = true;
    };
    nix-ld.libraries = with pkgs; [
      # Core C/C++ system libraries (Fixes your pyzmq, torch, numpy issues)
      stdenv.cc.cc.lib
      glibc

      # Math and Optimization (Crucial for NumPy / SciPy / JAX performance)
      openblas
      gfortran.cc.lib
      tbb # Intel Threading Building Blocks

      # Common Compression & Data formats (Required by pandas, HDF5, various data loaders)
      zlib
      bzip2
      xz
      zstd
      libtar

      # Graphics & Image Processing (Crucial for Matplotlib, OpenCV, Pillow, and Wandb logging)
      libglvnd # Provides libGL
      mesa # OpenGL implementations
      libxkbcommon
      fontconfig
      freetype
      glib # Essential for OpenCV and UI bindings
      libuuid # (Fixes certain Jupyter connection pool issues)

      # Networking & Security (Required by curl, requests, and distributed training)
      openssl
      curl
      libssh

      # Graphical Interfaces (If you ever use %matplotlib qt or Tkinter interactive plots)
      libx11
      libxext
      libxrender
      libxrandr
      libxcursor
      libxi

      # System Hardware / CUDA bindings (If you are training on an NVIDIA GPU with PyTorch)
      linuxPackages.nvidia_x11 # Crucial for torch.cuda.is_available() to work with pip wheels
      libaio
    ];
  };

}
