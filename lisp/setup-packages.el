(setq my-packages
      '(rainbow-delimiters
        coffee-mode
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
        jell-theme
        company-mode
        auto-complete
        enh-ruby-mode
        scss-mode
        yaml-mode
        markdown-mode
        rspec-mode
        jekyll-el
        ag
        bundler
        nyan-mode
        multiple-cursors
        smooth-scroll
        expand-region
        cl-lib
        magit
        git-timemachine
        web-mode
        puggle-utils
        dash
        s
        smartparens
        clj-refactor
        maps
        guide-key
        pivotal
        typed-clojure-mode
        elixir-mode
        ace-jump-mode
        twittering-mode
        emacs-w3m
        bbdb
        gist
        haskell-mode
        wgrep
        restclient
        feature-mode
        jinja2-mode
        rust-mode
        flymake-easy
        flymake-rust
        org-present
        tuareg-mode
        org-trello
        ;; auctex
        sass-mode))

(el-get 'sync my-packages)

(provide 'setup-packages)
