(setq el-get-sources
      '(undo-tree
        evil
        evil-surround

        (:name jell-theme
               :type git
               :url "git@github.com:Jell/jell-emacs-theme.git"
               :features jell-theme)

        rvm

        (:name Enhanced-Ruby-Mode
               :type git
               :url "git://github.com/Jell/Enhanced-Ruby-Mode.git"
               :load "ruby-mode.el")

        ruby-compilation
        rdebug
        scss-mode
        yaml-mode
        auto-complete
        markdown-mode
        rspec-mode
        jekyll-el

        (:name ack-and-a-half
               :type github
               :pkgname "jhelwig/ack-and-a-half"
               :features ack-and-a-half)

        bundler

        (:name nyan-mode
               :description "Nyan Cat for Emacs! Nyanyanyanyanyanyanyanyanyan!"
               :type git
               :url "git@github.com:Jell/nyan-mode.git"
               :features nyan-mode
               :after (nyan-mode))

        multiple-cursors
        smooth-scroll

        (:name expand-region
               :type github
               :pkgname "magnars/expand-region.el"
               :website "https://github.com/magnars/expand-region.el#readme"
               :features expand-region
               :before (defconst ruby-block-end-re "end"))

        (:name cl-lib
               :type github
               :pkgname "emacsmirror/cl-lib")

        (:name git-modes
               :description "Major mode for editing git commit messages"
               :type github
               :pkgname "magit/git-modes"
               :features (git-commit-mode
                          git-rebase-mode
                          gitconfig-mode
                          gitignore-mode))

        (:name magit
               :website "https://github.com/magit/magit#readme"
               :description "It's Magit! An Emacs mode for Git."
               :type github
               :pkgname "magit/magit"
               :depends git-modes
               :info "."
               :after (require 'magit)
               ;; let el-get care about autoloads so that it works with all OSes
               :build (if (version<= "24.3" emacs-version)
                          `(("make" ,(format "EMACS=%s" el-get-emacs) "all"))
                        `(("make" ,(format "EMACS=%s" el-get-emacs) "docs")))
               :build/berkeley-unix (("touch" "`find . -name Makefile`") ("gmake")))

        (:name spork-and-nailgun
               :description "Support for spork and nailgun"
               :type github
               :pkgname "PugglePay/spork-and-nailgun.el"
               :features spork-and-nailgun
               :after (progn (require 'find-file-in-project)
                             (require 'spork-and-nailgun)))

        (:name puggle-utils
               :description "Usefull functions used at PugglePay"
               :type github
               :pkgname "PugglePay/puggle-emacs-utils"
               :features puggle-utils
               :after (require 'puggle-utils))

        helm

        (:name dash
               :description "A modern list library for Emacs"
               :type github
               :pkgname "magnars/dash.el"
               :features dash)

        (:name smartparens
               :description "Modern minor mode for Emacs that deals with parens pairs and tries to be smart about it."
               :type github
               :pkgname "Jell/smartparens"
               :features smartparens
               :after (require 'my-smartparens-config))

        (:name elixir-mode
               :description "Modern minor mode for Emacs that deals with parens pairs and tries to be smart about it."
               :type github
               :pkgname "elixir-lang/emacs-elixir"
               :features elixir-mode)

        ace-jump-mode
        ))

;; Trigger synchronization of el-get packages
(defun sync-packages ()
  "Synchronize packages"
  (interactive)
  (el-get 'sync '(el-get package))
  (setq my-packages (mapcar 'el-get-source-name el-get-sources))
  (el-get 'sync my-packages))

(if (require 'el-get nil t)
    (sync-packages)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp)
     (setq el-get-verbose t)
     (sync-packages))))

(provide 'setup-elget-packages)