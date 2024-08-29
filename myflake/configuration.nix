# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    enable = true;
    displayManager.startx.enable = true;
    videoDrivers = [ "intel" "modesetting" ];
    libinput.enable = true;
    displayManager = {
      defaultSession = "none+i3";
    }; 
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuckboi = {
    isNormalUser = true;
    createHome = true;
    home = "/home/cuckboi";
    shell =  "/run/current-system/sw/bin/fish";
    description = "e";
    extraGroups = [ "networkmanager" "wheel" "adm" "sudo" "audio" "video" "storage" ];
    packages = with pkgs; [
      firefox
      pciutils
      binutils
      coreutils 
      gcc 
      cmake 
      git
      wget
      feh
      curl
      nano 
      sudo 
      herbstluftwm
      i3
      dmenu
      radare2
      vscodium
      neovim
      rxvt-unicode
      networkmanager
      wirelesstools
      gnumake
      vlc
      openvpn
    ];
  };

  # Allow unfree packages
  nixpkgs.config = { 
    allowUnfree = true;
    allowUnsupportedSystems = true;
  };

  # FLAKES

  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes 
  '';


  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      fira-mono
      source-code-pro
      jetbrains-mono
    ];
  };


  # POROGRAMS
  programs.fish.enable = true;


  # OBS 
#  programs.obs-studio = {
#    enable = true;
#    plugins = with pkgs.obs-studio-plugins; [
#      obs-backgroundremoval
#    ];
#  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   acpi 
   htop
   feh
   dmenu
   rofi
   obs-studio    

   unzip 
   xclip
   jdk
   xorg.libX11
   xorg.libX11.dev
   xorg.libxcb
   xorg.libXft
   xorg.libXinerama
   xorg.xinit
   xorg.xinput
   xfce.thunar
   harfbuzz
   slstatus   
   haskellPackages.X11
   gnumake
   bluez   

   firefox
   coreutils
   binutils
   pciutils
   vscodium
   git
   curl
   networkmanager
   wirelesstools
   nmap
   radare2
   feh
   neofetch
   metasploit   
   burpsuite
   armitage   
   alsa-utils   
   cwm
   herbstluftwm
   i3
   fish
   tcsh
   rxvt-unicode
   tdesktop
   discord
   winetricks
   gcc
   linux-firmware
   cmake  
   pkg-config
   telegram-desktop
   obs-studio-plugins.obs-backgroundremoval
   
 ];

  #Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  hardware.bluetooth.powerOnBoot = true;

  # SECURITY 
  security.sudo.wheelNeedsPassword = false;


  # SOund
  sound.enable = true;
  services.pipewire.enable = true;
  services.pipewire.audio.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
