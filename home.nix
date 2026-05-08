{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.username = "tino";
  home.homeDirectory = "/home/tino";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  programs.noctalia-shell = {
    enable = true;
  };

  home.packages = with pkgs; [
    firefox
    foot
    wofi
    wl-clipboard
    grim
    slurp
    inputs.noctalia.packages.${system}.default
  ];


programs.foot = {
  enable = true;

  settings = {
    key-bindings = {
      clipboard-copy = "Mod4+c";
      clipboard-paste = "Mod4+v";
    };
  };
};

  xdg.configFile."mango/config.conf" = {
    force = true;
    text = ''
      monitorrule=name:Virtual-1,width:1920,height:1080,refresh:60,x:0,y:0,scale:1
      exec-once=wayvnc 0.0.0.0 5900
      exec-once=/etc/profiles/per-user/tino/bin/noctalia-shell
      exec-once=wl-paste --type text --watch cliphist store
      exec-once=foot

      bind=SUPER,Return,spawn,foot
      bind=SUPER,D,spawn,wofi --show drun
      bind=SUPER,Q,killclient,
      bind=SUPER,R,reload_config
    '';
  };

}
