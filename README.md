## My emacs config

To install, run:

      cd ~
      git clone git@github.com:Jell/.emacs.d.git

Next time you open emacs, all the dependencies will install
themselves! Magic!

## Dependencies:

````ruby
# Packages
sudo apt-get install curl git git-core subversion openjdk-7-jdk
zlib1g-dev libreadline-dev cvs ack-grep libssl-dev texinfo aspell dbus

# RVM
curl -L https://get.rvm.io | bash -s stable --ruby
rvm install ruby-1.9.3-p194

# Lein
cd /usr/local/bin
curl -O https://raw.github.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
lein
````

## Todo:
- Multi user support
