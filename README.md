> **Note:** Follow/copy my guide/config at your own risk. I am not an expert.

# NixOS with Flake and Home Manager
- [Standalone Home-Manager Installation](#standalone-home-manager-installation)
- [Enable Flake](#enable-flake)
- [Usage](#usage)

</br>

## Installation/Enable
### Standalone Home-Manager Installation
Check nix-channel:
```sh
sudo nix-channel --list
```

If you are on an unstable channel (OUTPUT: `nixos https://nixos.org/channels/nixos-unstable`), use the following:
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
```
Once done, use the following command to install the home manager:
```sh
nix-shell '<home-manager>' -A install
```

⚠️  If  get any error, reboot your system and run the installation command `nix-shell '<home-manager>' -A install` again.
>Official installation instructions can be found in the [HomeManager community docs](https://nix-community.github.io/home-manager/) or the [NixOS Wiki](https://nixos.wiki/wiki/Home_Manager).

</br>

## Enable Flake
Edit `/etc/nixos/configuration.nix` and add the following line:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```
Then run:
```sh
sudo nixos-rebuild switch
```
</br>
</br>

## Usage
>Make a git repo for your config. Copy `/etc/nixos` and `~/.config/home-manager`
 Make any change you want by editing `nixos/configuration.nix/` and `home/home.nix`.
 Create a `flake.nix` (check out my flake.nix for a simple one)


📦 **So far your newly created repo should look like this:**
```
├── flake.nix
├── 📂 home-manager
│   └── home.nix
├── 📂 nixos
    ├── configuration.nix
    └── hardware-configuration.nix
```

</br>

To rebuild system config with flake, run:
```sh
sudo nixos-rebuild switch --flake .
```
To rebuild home-manager with flake, run
```sh
home-manager switch --flake .
```


## TODO
- [ ] Rewrite redme
- [ ] Cleanup
