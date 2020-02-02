(setq my-packages
      '(jell-theme
        rainbow-delimiters
        paredit
        cider
        ;; spiral
        find-file-in-project
        smex
        undo-tree
        evil
        evil-surround
        evil-leader
        evil-exchange
        company-mode
        auto-complete
        enh-ruby-mode
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
        psc-ide
        elm-mode
        js2-mode
        skewer-mode
        ;; ess
        rubocop
        sass-mode
        impatient-mode
        idris-mode
        esup
        graphviz-dot-mode
        dockerfile-mode
        terraform-mode
        image+
        plantuml-mode
        tide ;; TypeScript
        racket-mode
        inf-ruby
        crystal-mode
        php-mode
        ;; go IDE related
        go-mode
        go-eldoc
        lsp-mode
        lsp-ui
        dap-mode
        kubernetes
        kubernetes-evil))


(el-get 'sync my-packages)

(provide 'setup-packages)
