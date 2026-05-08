{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    "video=Virtual-1:1920x1080@60"
#    "video=1920x1080@60"
  ];

  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 5900 ];

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console.keyMap = "de";

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${pkgs.mangowc}/bin/mango";
      user = "greeter";
    };
  };

environment.sessionVariables = {
  XKB_DEFAULT_LAYOUT = "de";
  XKB_DEFAULT_VARIANT = "mac";
};

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xen-guest = {
    enable = true;
  };

  users.users.tino = {
    isNormalUser = true;
    description = "tino";
    extraGroups = [ "networkmanager" "wheel" "video" "input" ];
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    cliphist
    mangowc
    wayvnc
    wayland
    wayland-utils
    wlr-randr
    foot
    wofi
    wl-clipboard
    grim
    slurp
  ];

  services.openssh.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = true;
    PermitRootLogin = "no";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  system.stateVersion = "25.11";
}
