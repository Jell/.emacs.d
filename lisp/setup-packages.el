(setq my-packages
      '(jell-theme
        rainbow-delimiters
        paredit
        cider
        find-file-in-project
        smex
        ido-ubiquitous
        undo-tree
        evil
        evil-surround
        evil-leader
        evil-exchange
        company-mode
        auto-complete
        enh-ruby-mode
        scss-mode
        yaml-mode
        markdown-mode
        rspec-mode
        jekyll-el
        ag
        nyan-mode
        multiple-cursors
        smooth-scroll
        cl-lib
        magit
        web-mode
        dash
        s
        smartparens
        clj-refactor
        maps
        guide-key
        alchemist
        emacs-w3m
        bbdb
        intero
        wgrep
        restclient
        jinja2-mode
        rust-mode
        flymake-easy
        flymake-rust
        org-present
        tuareg-mode
        purescript-mode
        elm-mode
        js2-mode
        skewer-mode
        jade
        ess
        rubocop
        sass-mode))

(el-get 'sync my-packages)

(provide 'setup-packages)
