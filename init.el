;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Extra load paths
(add-to-list 'load-path "~/.emacs.d")
(require 'setup-paths)
(require 'setup-scratch-message)
(require 'setup-keys)

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
                      nrepl
                      ac-nrepl
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
                      sass-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Package defs ----------------------------------------------------------------

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

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
(require 'init-clojure-mode)

;; Enable rainbow delimiters
(global-rainbow-delimiters-mode)

;; Paredit for classic modes
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; el-get packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
(require 'setup-mode-line)

;; goto-anything
(eval-after-load "helm-regexp"
  '(helm-attrset 'follow 1 helm-source-moccur))

(defun goto-anything ()
  "multi-occur in all buffers backed by files."
  (interactive)
  (helm-multi-occur
   (delq nil
         (mapcar (lambda (b)
                   (when (buffer-file-name b) (buffer-name b)))
                 (buffer-list)))))

;; Sublimify
(require 'sublimify)
;; Emacsify
(require 'emacsify)
;; Move Lines
(require 'movelines)
;; Compatibility
(require 'compatibility)

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

;; No native fullscreen, thank you very much.
(setq ns-use-native-fullscreen nil)

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
