## My emacs config

To install, run:

      cd ~
      git clone git@github.com:Jell/.emacs.d.git

Next time you open emacs, all the dependencies will install
themselves! Magic!

## Brew install

```sh
# Deps
brew install graphviz --with-pango
brew install automake ag mactex gpg pinentry-mac subversion wget cvs plantuml

# Emacs proper
brew install emacs --with-modules --with-cocoa --with-gnutls \
    --with-librsvg --with-mailutils --with-imagemagick@6
```

## Linux install

```sh
# Packages
sudo apt-get install curl git git-core subversion openjdk-7-jdk
zlib1g-dev libreadline-dev cvs silversearcher-ag libssl-dev texinfo aspell dbus

# Lein
cd /usr/local/bin
curl -O https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
lein
```

## Todo:
- Multi user support
