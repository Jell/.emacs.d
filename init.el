;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Key bindings for mac
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'super)

;; Extra keybindings
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x f") 'find-file-in-project)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
;; Multi cursors
(global-set-key (kbd "C-c C-d") 'mc/edit-lines)
(global-set-key (kbd "C--") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-+") 'mc/mark-all-like-this)
;; Expand mark
(global-set-key (kbd "M-+") 'er/expand-region)
;; For sublime users
(global-set-key (kbd "C-c s") 'sublimify)
;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

(defun control-meta-click (event)
  (interactive "e")
  (if (> (mc/num-cursors) 1)
      (multiple-cursors-mode 1)
    (multiple-cursors-mode 0))
  (mc/create-fake-cursor-at-point)
  (mouse-set-point event)
  (message (string (mc/num-cursors))))

(global-set-key (kbd "<C-M-mouse-1>") 'control-meta-click)

(global-set-key (kbd "C-c b SPC") 'bc-set)
(global-set-key (kbd "C-c b <up>") 'bc-local-previous)
(global-set-key (kbd "C-c b <down>") 'bc-local-next)
(global-set-key (kbd "C-c b <right>") 'bc-previous)
(global-set-key (kbd "C-c b <left>") 'bc-next)
(global-set-key (kbd "C-c b l") 'bc-list)
(global-set-key (kbd "C-c b c") 'bc-clear)

;; Spork & Nailgun
(global-set-key (kbd "C-x C-l") 'sang-start-all)

;; Fix encoding
(setq default-process-coding-system '(utf-8 . utf-8))

;; Larger fonts
(set-face-attribute 'default nil :height 150)

;; Fix scrolling
(setq auto-window-vscroll nil)

(setq hippie-expand-try-functions-list
      '(
        yas/hippie-try-expand
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        try-complete-lisp-symbol
        try-complete-lisp-symbol-partially
        try-expand-line
        try-expand-line-all-buffers
        try-expand-list
        try-expand-list-all-buffers
        try-expand-whole-kill))

;; Extra load paths
(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/filetypes")
(add-to-list 'load-path "~/.emacs.d/other")

;; Extra bin folders
(add-to-list 'exec-path "/usr/local/bin")

;; Path to binary files
(setq-default ispell-program-name "/usr/local/bin/aspell")

;; Fix rhtml colors
(defface erb-face
  `((t (:background "grey18")))
  "Default inherited face for ERB tag body"
  :group 'rhtml-faces)

(defface erb-delim-face
  `((t (:background "grey15")))
  "Default inherited face for ERB tag delimeters"
  :group 'rhtml-faces)

;; Fix tab indent
(defun indent-or-expand (arg)
  "Either indent according to mode, or expand the word preceding point."
  (interactive "*P")
  (if (and
       (or (bobp) (= ?w (char-syntax (char-before))))
       (or (eobp) (not (= ?w (char-syntax (char-after))))))
      (hippie-expand arg)
    (indent-according-to-mode)))

(defun tab-indent-or-expand ()
  (local-set-key [tab] 'indent-or-expand))

;; Bug fix
(setq stack-trace-on-error t)
(setq imenu-auto-rescan t)

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ELPA packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Package List ----------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(clojure-mode
                      rainbow-delimiters
                      rainbow-mode
                      coffee-mode
                      paredit
                      find-file-in-project
                      smex
                      ido-ubiquitous
                      gist
                      slime
                      starter-kit ;; TODO: remove this dependency.
                      haskell-mode
                      erlang
                      sass-mode
                      undo-tree )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(load custom-file)
;; Package defs ----------------------------------------------------------------

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)
(require 'undo-tree)

;; Erlang
(autoload 'erlang-mode "erlang" nil t)
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))

;; Sass
(autoload 'sass-mode "sass-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scss" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.sass" . sass-mode))

;; CoffeeScript
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.decaf$" . js-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-mode-hook ()
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook 'coffee-mode-hook)

;; Clojure
(add-hook 'clojure-mode-hook (lambda () (load "clj.el")))
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))

;; Enable rainbow delimiters
(global-rainbow-delimiters-mode)

;; Paredit for classic modes
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; el-get packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Install hooks, called only after the package is installed (so we
;; can install them asynchronously. Pretty cool stuff.

(defun ruby-mode-hook ()
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.arb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.builder\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook
            '(lambda ()
               (require 'ruby-mode)
               (require 'ruby-compilation)
               (require 'rspec-mode)
               (require 'rcodetools)
               (rvm-autodetect-ruby)
               (rinari-launch)
               (electric-pair-mode)
               (setq enh-ruby-program "/Users/Jell/.rvm/rubies/ruby-1.9.3-p194/bin/ruby")
               (define-key rspec-mode-verifible-keymap (kbd "s") 'rspec-verify-single)

               ;; Fix word limits
               (modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
               (modify-syntax-entry ?! "w" ruby-mode-syntax-table)
               (modify-syntax-entry ?? "w" ruby-mode-syntax-table))))

(defun rinari-hook ()
  (require 'rinari))

(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
  (add-hook 'css-mode-hook '(progn
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

(defun rvm-hook ()
  (rvm-use-default))

(defun pig-mode-hook ()
  (autoload 'pig-mode "pig-mode" nil t))


(defun fix-for-evil ()
  (when (and (> (mc/num-cursors) 0)
             (evil-normal-state-p evil-next-state))
    (mc/execute-command-for-all-fake-cursors 'evil-backward-char)))

(defun other-fix-for-evil ()
  (when (and (> (mc/num-cursors) 0)
             (not (evil-visual-state-p evil-next-state)))
    (mc/execute-command-for-all-fake-cursors 'evil-visual-char)))

(defun evil-hook ()
  (setq viper-mode t)
  (setq viper-custom-file-name "~/.emacs.d/viper")
  (setq viper-ex-style-editing nil)
  (setq evil-want-fine-undo t)
  ;; (add-hook 'evil-normal-state-exit-hook 'fix-for-evil)
  (require 'evil)
  (evil-mode 1))

(defun yasnippet-hook ()
  (require 'yasnippet)
  (setq yas/snippet-dirs '("~/.emacs.d/el-get/yasnippet/snippets"
                           "~/.emacs.d/el-get/yasnippet/extras/imported"
                           "~/.emacs.d/snippets"))
  (setq yas/trigger-key "TAB")
  (yas/global-mode 1))

(defun ack-and-a-half-hook ()
  (defalias 'ack 'ack-and-a-half)
  (defalias 'ack-same 'ack-and-a-half-same)
  (defalias 'ack-find-file 'ack-and-a-half-find-file)
  (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same))


;; Package list ----------------------------------------------------------------

(setq el-get-sources
      '((:name popup
               :website "https://github.com/m2ym/popup-el"
               :description "Visual Popup Interface Library for Emacs"
               :type git
               :url "https://github.com/auto-complete/popup-el.git"
               :features popup)

        (:name evil
               :type git
               :url "git://gitorious.org/evil/evil.git"
               :load "evil.el"
               :post-init (progn (evil-hook)))

        (:name evil-surround
               :url "git://github.com/timcharper/evil-surround.git"
               :type git
               :load "surround.el"
               :features surround
               :post-init (progn (global-surround-mode 1)))

        (:name jell-theme
               :type git
               :url "git@github.com:Jell/jell-emacs-theme.git"
               :features jell-theme)

        (:name go-mode
               :description "Major mode for the Go programming language"
               :type http
               :url "http://go.googlecode.com/hg/misc/emacs/go-mode.el?r=tip"
               :localname "go-mode.el"
               :features go-mode
               :post-init (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

        (:name rvm
               :type git
               :url "git://github.com/senny/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :post-init (progn (rvm-hook)))

        (:name Enhanced-Ruby-Mode
               :type git
               :url "git://github.com/Jell/Enhanced-Ruby-Mode.git"
               :load "ruby-mode.el"
               :post-init (progn (ruby-mode-hook)))

        (:name ruby-compilation :type elpa)

        (:name rdebug
               :description "Ruby debugger user interface, startup file."
               :type svn
               :url "http://ruby-debug.rubyforge.org/svn/trunk/emacs/")

        (:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type git
               :url "http://github.com/eschulte/rinari.git"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               :build ("rake doc:install_info")
               :info "doc"
               :features rinari
               :post-init (progn (rinari-hook)))

        (:name css-mode
               :type elpa
               :post-init (progn (css-mode-hook)))

        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :post-init (progn (rhtml-mode-hook)))

        (:name yaml-mode
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :post-init (progn (yaml-mode-hook)))

        (:name yasnippet
               :website "http://code.google.com/p/yasnippet/"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :features "yasnippet"
               :prepare (progn
                          (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
                            (setq yas/snippet-dirs
                                  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))
               :post-init (progn (yasnippet-hook))
               :compile nil)

        (:name auto-complete
               :description "The most intelligent auto-completion extension."
               :type git
               :url "https://github.com/auto-complete/auto-complete.git"
               :depends popup
               :post-init (progn
                            (require 'auto-complete)
                            (add-to-list 'ac-dictionary-directories
                                         (expand-file-name "dict"))
                            (require 'auto-complete-config)
                            (ac-config-default)))

        (:name ruby-end
               :description "Emacs minor mode for automatic insertion of end blocks for Ruby"
               :type http
               :url "https://github.com/rejeep/ruby-end/raw/master/ruby-end.el"
               :features ruby-end)

        (:name markdown-mode
               :description "Major mode to edit Markdown files in Emacs"
               :type git
               :url "git://jblevins.org/git/markdown-mode.git"
               :post-init (add-to-list 'auto-mode-alist
                                       '("\\.\\(md\\|mdown\\|markdown\\)\\'" . markdown-mode)))

        (:name rspec-mode
               :description "Enhance ruby-mode for RSpec"
               :type git
               :url "https://github.com/pezra/rspec-mode.git"
               :features rspec-mode)

        (:name cucumber-mode
               :description "Cucumber mode"
               :type git
               :url "https://github.com/michaelklishin/cucumber.el.git"
               :features feature-mode)

        (:name jekyll
               :type git
               :url "https://github.com/diasjorge/jekyll.el.git"
               :features jekyll)

        (:name ack-and-a-half
               :type git
               :url "https://github.com/jhelwig/ack-and-a-half.git"
               :features ack-and-a-half
               :after (progn (ack-and-a-half-hook)))

        (:name zencoding-mode
               :description "Unfold CSS-selector-like expressions to markup"
               :type git
               :url "https://github.com/rooney/zencoding.git"
               :features zencoding-mode
               :post-init (progn
                            (require 'zencoding-mode)
                            (add-hook 'sgml-mode-hook 'zencoding-mode)))

        (:name bundler
               :description "Interact with Bundler from Emacs"
               :website "https://github.com/tobiassvn/bundler.el"
               :type github
               :pkgname "tobiassvn/bundler.el")

        (:name ecb
               :description "Emacs Code Browser"
               :type cvs
               :module "ecb"
               :url ":pserver:anonymous@ecb.cvs.sourceforge.net:/cvsroot/ecb"
               :build `(("make" "CEDET=" ,(concat "EMACS=" (shell-quote-argument el-get-emacs)))))

        (:name nyan-mode
               :description "Nyan Cat for Emacs! Nyanyanyanyanyanyanyanyanyan!"
               :type git
               :url "git@github.com:Jell/nyan-mode.git"
               :features nyan-mode
               :after (progn (nyan-mode)))

        (:name multiple-cursors
               :description "Sublime-like multiple cursors"
               :type git
               :url "https://github.com/magnars/multiple-cursors.el.git"
               :features multiple-cursors
               :after (progn (require 'multiple-cursors nil t)
                             (multiple-cursors-mode 0)))

        (:name smooth-scroll
               :description "Minor mode for smooth scrolling."
               :type emacswiki
               :features smooth-scroll
               :after (progn (require 'smooth-scroll) (smooth-scroll-mode t)))

        (:name breadcrumb
               :website "http://breadcrumbemacs.sourceforge.net/"
               :description "Breadcrumb is an add-on module for Emacs that allows you to set a series of quick bookmarks in the file buffers, and jump back to them quickly."
               :type http
               :url "http://downloads.sourceforge.net/project/breadcrumbemacs/Breadcrumb%20for%20Emacs/1.1.3/breadcrumb-1.1.3.zip"
               :build ("unzip breadcrumb-1.1.3.zip")
               :after (progn (require 'breadcrumb)))

        (:name expand-region
               :type github
               :pkgname "magnars/expand-region.el"
               :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want."
               :website "https://github.com/magnars/expand-region.el#readme"
               :features expand-region
               :before (progn (defconst ruby-block-end-re "end")))

        (:name nrepl
               :description "An Emacs client for nREPL, the Clojure networked REPL server."
               :type github
               :pkgname "kingtim/nrepl.el"
               :features nrepl)

        (:name ac-nrepl
               :description "Autocomplete for nREPL"
               :type git
               :url "https://github.com/purcell/ac-nrepl.git"
               :features ac-nrepl
               :depends nrepl
               :depends auto-complete)

        (:name puppet-mode
               :description "A simple mode for editing puppet manifests"
               :type http
               :url "https://raw.github.com/puppetlabs/puppet/master/ext/emacs/puppet-mode.el"
               :prepare (progn
                          (autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests" t)
                          (add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))))

        (:name quack
               :description "Enhanced support for editing and running Scheme code"
               :type http
               :url "http://www.neilvandyke.org/quack/quack.el"
               :features (quack))

        (:name geiser
               :website "http://www.nongnu.org/geiser/"
               :description "Geiser is a collection of Emacs major and minor modes that conspire with one or more Scheme interpreters to keep the Lisp Machine Spirit alive. It draws inspiration (and a bit more) from environments such as Common Lisp's Slime, Factor's FUEL, Squeak or Emacs itself, and does its best to make Scheme hacking inside Emacs (even more) fun."
               :type git
               :url "git://git.sv.gnu.org/geiser.git"
               :load-path ("./elisp")
               :build `("./autogen.sh" "./configure"
                        ,(concat "make EMACS=" el-get-emacs)
                        ,(concat "make EMACS=" el-get-emacs "info-recursive"))
                                        ;,(concat "cd doc ; " el-get-install-info " --dir-file=./dir *.info"))
               :build/windows-nt `("sh ./autogen.sh" "sh ./configure" "make"
                                   ,(concat "cd doc & " el-get-install-info " --dir-file=./dir *.info"))
               :info "doc"
               :features geiser-load)

        (:name cl-lib
               :type elpa
               :description "Properly prefixed CL functions and macros"
               :url "http://elpa.gnu.org/packages/cl-lib.html")

        (:name magit
               :website "https://github.com/magit/magit#readme"
               :description "It's Magit! An Emacs mode for Git."
               :type github
               :pkgname "magit/magit"
               :info "."
               :after (progn (require 'magit))
               ;; let el-get care about autoloads so that it works with all OSes
               :build (if (version<= "24.3" emacs-version)
                          `(("make" ,(format "EMACS=%s" el-get-emacs) "all"))
                        `(("make" ,(format "EMACS=%s" el-get-emacs) "docs")))
               :build/berkeley-unix (("touch" "`find . -name Makefile`") ("gmake")))

        (:name emacs-jabber
               :description "A minimal jabber client"
               :type git
               :url "git://emacs-jabber.git.sourceforge.net/gitroot/emacs-jabber/emacs-jabber"
               :info "."
               :load-path (".")
               :features jabber-autoloads
               :build ("autoreconf -i" "./configure" "make" "mv jabber.info emacs-jabber.info" ))

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
               :after (progn (require 'puggle-utils)))

        (:name pig-mode
               :type git
               :url "https://github.com/motus/pig-mode.git"
               :features pig-mode
               :after (progn (pig-mode-hook)))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Stuff to trigger last
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; full screen magit-status
(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
  (delete-other-windows))

(defun magit-quit-session ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-quit-session)

;;
;; Custom mode-line
(load "setup-mode-line.el")

;; Sublimify
(load "sublimify.el")
;; Move Lines
(load "movelines.el")

;; Do not *ding* on scroll and other stuff.
(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char end-of-buffer))
    (ding)))
(setq ring-bell-function 'ignore)

;; Remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Always save even when buffer is not modified
(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))
(global-set-key (kbd "C-x C-s") 'save-buffer-always)

;; Fix tmp files
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message file)
      (delete-file file))))

(defun insert-date (prefix)
  "Insert the current date. With prefix-argument, use ISO format. With
   two prefix arguments, write out the day and month name."
  (interactive "P")
  (let ((format (cond
                 ((not prefix) "%d.%m.%Y")
                 ((equal prefix '(4)) "%Y-%m-%d")
                 ((equal prefix '(16)) "%A, %d. %B %Y")))
        (system-time-locale "de_DE"))
    (insert (format-time-string format))))
(global-set-key (kbd "C-c d") 'insert-date)

(setq c-tab-always-indent nil)

(when window-system
  (menu-bar-mode))
(put 'ido-exit-minibuffer 'disabled nil)

;; Disable idle highlight
(remove-hook 'prog-mode-hook 'esk-turn-on-idle-highlight-mode)

(load custom-file)
