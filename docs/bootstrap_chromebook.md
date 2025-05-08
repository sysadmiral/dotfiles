# bootstrap a chromebook

## enable linux developer environment
On the chromebook setup the Linux developer environment setting an appropriate disk size

## share google drive dirs with Linux
Share the following Google Drive folders with Linux
  - chromebook-downloads
  - chromebook-scratch

## update OS packages & install pipx

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install pipx
```

## install ansible

```bash
pipx install ansible-core
```

## run `chezmoi` (twice)
The first run which fetch my dotfiles and install `op`

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply sysadmiral
```

> initial run will fail because op is not logged in

```bash
eval $(op signin)
```

Run `chezmoi` again

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply sysadmiral
```

## install a nerdfont

```bash
curl --output-dir ~/downloads/ -O --silent -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip
mkdir ~/.fonts
pushd ~/.fonts
unzip /mnt/chromeos/MyFiles/Downloads/RobotoMono.zip
fc-cache -f -v
popd
```

Go to chrome-untrusted://terminal/html/nassh_preferences_editor.html and
  - set Text Font Family to "Nerd Font"
  - copy the CSS below to "inline CSS":

```css
@font-face {
font-family: "Nerd Font";
src: url(https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/${subpath to a nerdfont on github});
font-weight: normal;
font-style: normal;
}
```

## install starship

> requires dropping into a root shell

```bash
sudo -i
curl -sS https://starship.rs/install.sh | sh
```

## configure locale

```bash
sudo dpkg-reconfigure locales
```
