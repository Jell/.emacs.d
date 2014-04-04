(setq my-packages
      '(rainbow-delimiters
        coffee-mode
        paredit
        cider
        ac-nrepl
        find-file-in-project
        smex
        ido-ubiquitous
        undo-tree
        evil
        evil-surround
        jell-theme
        enh-ruby-mode
        ruby-compilation
        scss-mode
        yaml-mode
        auto-complete
        markdown-mode
        rspec-mode
        jekyll-el
        ack-and-a-half
        bundler
        nyan-mode
        multiple-cursors
        smooth-scroll
        expand-region
        cl-lib
        magit
        web-mode
        puggle-utils
        dash
        s
        smartparens
        maps
        pivotal
        elixir-mode
        dash-at-point
        idris-mode
        ace-jump-mode
        twittering-mode
        emacs-w3m
        bbdb
        gist
        haskell-mode
        erlang
        wgrep
        sass-mode))

(el-get 'sync my-packages)

(provide 'setup-packages)
