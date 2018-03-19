# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
  [ # Include the results of the hardware scan.
  ./hardware-configuration.nix
];
#boot.loader.grub.mirroredBoots
#boot.loader.grub.enable = true;
#boot.loader.grub.version = 2;
#boot.loader.grub.devices = ["/dev/sda"];
system.autoUpgrade.enable = true;
# Use the systemd-boot EFI boot loader. 
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true; 
networking.hostName = "hood"; # Define your hostname.
networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
# Select internationalisation properties.
i18n = {
  consoleFont = "Hack-Regular";
  consoleKeyMap = "us";
  defaultLocale = "en_US.UTF-8";
};

# Set your time zone.
time.timeZone = "America/New_York";

# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
# environment.systemPackages = with pkgs; [
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.gem = {
    isNormalUser = true;
    home = "/home/gem";
    extraGroups = ["wheel"];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only aftr NixOS release notes say you
  # should.
  #system.stateVersion = "17.09"; # Did you read the comment?
  #systemd.packages = [pkgs.networkmanager.out];
  users.defaultUserShell = pkgs.zsh;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.allowUnfree = true; 
  users.users.gem.packages = [
    pkgs.steam
  ];
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  #services.xserver.windowManager.xmonad.enable = true;
  #windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager = {
   i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    #xmonad-with-packages = {
      #enable = true;
      #package = pkgs.xmonad-with-packages;
    #};
    default = "i3";
  }; 
  services.xserver.resolutions = [{ x = 1366; y = 786; } {x = 1368; y = 768;}] ;
  environment.systemPackages = with pkgs; [
#    (haskellPackages.ghcWithPackages (self : [
     ##self.cabalInstall
     ##self.happy
     ##self.alex
     ##self.ghc-mod
  #]))
#    #(pkgs.polybar.overrideAttrs (oldAttrs: { i3GapsSupport = true; aslaSupport = true; githubSupport = true; mpdSupport = true;  
    #}))

    (python36.withPackages(ps: with ps; [ numpy scipy matplotlib pandas pygobject3 pyyaml ]))
    (pkgs.polybar.override {i3GapsSupport = true; alsaSupport = true; githubSupport = true; iwSupport = true; mpdSupport = true;}) 
    #pkgs.polybar
  ];
  services.mopidy.enable = true;
  services.mopidy.extensionPackages = [pkgs.mopidy-gmusic pkgs.mopidy-musicbox-webclient pkgs.mopidy-soundcloud pkgs.mopidy-spotify];
  #services.mpd.enable = true;
  #services.mpd.musicDirectory = "/home/gem/Entertainment/music/songs";
  #services.mpd.playlistDirectory = "/home/gem/Entertainment/music/playlists";
  programs.qt5ct.enable = true;
  #networking.networkmanager.enable = true;
}


