{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./python.nix
  ];

  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = with pkgs; [

    # version control archive
    gitAndTools.gitFull mercurial 
    unzip zip unrar p7zip syncthing
    
    # debugging
    htop iotop powertop 
    ltrace strace linuxPackages.perf 
    pciutils lshw smartmontools usbutils
    lm_sensors inxi sysstat

    # networking
    networkmanagerapplet
    networkmanager
    inetutils wireshark wget ethtool nmap blueman
    openvpn networkmanager_openvpn
       
    # linux shell
    file which bc dosfstools exfat moreutils patchelf
    zsh oh-my-zsh ntfs3g kitty playerctl
    ranger newsboat tmux killall

    # development
    coreutils binutils gcc clang perl autoconf gnumake cmake automake
    #vim
    hugo

    # embedded devel
    gcc-arm-embedded-9 openocd stlink 

    # fpga devel
    verilog verilator yosys symbiyosys nextpnr abc-verifier boolector yices z3
    #quartus-prime-lite

    # gui
    libnotify dunst
    aspell
    aspellDicts.en
    aspellDicts.tr
    gparted
    xss-lock xautolock i3lock
    pasystray clipit firefox
    lxterminal rofi vlc mpv spotify geany zotero zathura
    gnupg xclip picom autocutsel xdg_utils xsel
    vscode wine tdesktop gnuplot feh scrot youtube-dl
    pavucontrol unclutter

    # xfce4
    xfce.xfce4settings xfce.thunar xfce.gvfs xfce.xfconf 
    xfce.xfce4-power-manager xfce.thunar-volman xfce.thunar-archive-plugin

    # themes
    lxappearance lxappearance-gtk3
    theme-vertex numix-gtk-theme
    nordic nordic-polar
    tango-icon-theme numix-icon-theme numix-icon-theme-circle
    zafiro-icons
  ];

  # Use the systemd-boot EFI boot loader.
  boot.cleanTmpDir = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  networking = {
    hostName = "jazz";
    wireless.enable = false;
    useDHCP = false;
    networkmanager.enable = true;
    # firewall.enable = true;
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
  };

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.useXkbConfig = true;
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      layout = "us,tr";
      xkbOptions = "grp:shifts_toggle,ctrl:nocaps";

      displayManager.sessionCommands = ''
        clipit &
        thunar --daemon &
        xfce4-power-manager &
        # Launch xfce settings daemon.
        ${pkgs.xfce.xfce4settings}/bin/xfsettingsd &
        # Screen Locking (time-based & on suspend)
        {pkgs.xautolock}/bin/xautolock -detectsleep -time 5 \
          -locker "${pkgs.i3lock}/bin/i3lock -c 003300" \
          -notify 10 -notifier "${pkgs.libnotify}/bin/notify-send -u critical -t 10000 -- 'Screen will be locked in 10 seconds'" &
        ${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock}/bin/i3lock -c 003300 &
        # Set GTK_PATH so that GTK+ can find the theme engines.
        export GTK_PATH="${config.system.path}/lib/gtk-2.0:${config.system.path}/lib/gtk-3.0"
        # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
        export GTK_DATA_PREFIX=${config.system.path}
        # SVG loader for pixbuf
        export GDK_PIXBUF_MODULE_FILE=$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)
      '';

      #desktopManager.xfce = {
      #  enable = true;
      #  thunarPlugins = with pkgs.xfce; [
      #    thunar-archive-plugin
      #    thunar-volman
      #  ];
      #  noDesktop = true;
      #  enableXfwm = false;
      #};
 
      displayManager.defaultSession = "none+i3";

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
        ];
      };
      
      #windowManager.awesome.enable = true;

      libinput.enable = true;
      libinput.naturalScrolling = true;
      libinput.disableWhileTyping = true;
    };

    openssh.enable = true;
    printing.enable = true;
    thermald.enable = true;
    upower.enable = true;
    locate.enable = true;
    avahi.enable = true;
    #avahi.publish = {
    #  enable = true;
    #  addresses = true;
    #  workstation = true;
    #};
  };

  # Enable unfree support
  nixpkgs.config.allowUnfree = true;

  users.users.fcayci = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "audio" "wheel" ];
  };

  #systemd.user.services."dunst" = {
  #  enable = true;
  #};
  #  description = "notification daemon";
  #  wantedBy = [ "default.target" ];
  #  serviceConfig.Restart = "always";
  #  serviceConfig.RestartSec = 2;
  #  serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst"; 
  #};

  systemd.user.services."picom" = {
    enable = true;
    description = "compositing";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.picom}/bin/picom";
  };

  systemd.user.services."unclutter" = {
    enable = true;
    description = "hide cursor after X seconds idle";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.unclutter}/bin/unclutter";
  };

  systemd.user.services."syncthing" = {
    enable = true;
    description = "Sync accross machines";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.syncthing}/bin/syncthing";
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    enableDefaultFonts = true;
    fonts = with pkgs; [ 
      ubuntu_font_family
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      dejavu_fonts
      powerline-fonts
      terminus_font
      terminus_font_ttf
      liberation_ttf
      tamsyn
      iosevka
      freetype
      corefonts
      font-awesome
      source-code-pro
    ];

    fontconfig = {
      penultimate.enable = false;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Noto Sans Mono" ];
      };
    };
  };

  programs = {
    nm-applet.enable = true;
    dconf.enable = true;
    zsh.enable = true;
    zsh.ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "amuse";
      custom = "~/.config/zsh/";
    };
  };

  system.stateVersion = "20.03";
}
