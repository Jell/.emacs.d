;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Setup scratch screen
(let ((file (expand-file-name (concat "~/.emacs.d/scratch-messages/" (user-login-name) ".el"))))
  (when (file-exists-p file)
    (setq initial-scratch-message
          (with-temp-buffer
            (insert-file-contents file)
            (buffer-string)))))

;; Key bindings for mac
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'super)

;; Extra keybindings
(global-set-key (kbd "C-x f") 'find-file-in-project)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-S-k") 'kill-whole-line)
;; Multi cursors
(global-set-key (kbd "C-c C-d") 'mc/edit-lines)
(global-set-key (kbd "M--") 'mc/mark-next-like-this)
(global-set-key (kbd "M-+") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-+") 'mc/mark-all-like-this)
;; Expand mark
(global-set-key (kbd "M-+") 'er/expand-region)
;; For sublime users
(global-set-key (kbd "C-c s") 'sublimify)
(global-set-key (kbd "C-c e") 'emacsify)
;; Magit
(global-set-key (kbd "C-x g") 'magit-status)
;; Ack
(global-set-key (kbd "C-x C-p") 'ack-and-a-half)

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

;; Switch panel
(global-set-key (kbd "C-c C-<right>") 'windmove-right)
(global-set-key (kbd "C-c C-<left>") 'windmove-left)
(global-set-key (kbd "C-c C-<up>") 'windmove-up)
(global-set-key (kbd "C-c C-<down>") 'windmove-down)

;; Extra keybindings for when working in tty
(global-set-key (kbd "M-[ c") (kbd "C-<right>"))
(global-set-key (kbd "M-[ d") (kbd "C-<left>"))
(global-set-key (kbd "M-[ a") (kbd "C-<up>"))
(global-set-key (kbd "M-[ b") (kbd "C-<down>"))
(global-set-key (kbd "C-c M-[ c") (kbd "C-c C-<right>"))
(global-set-key (kbd "C-c M-[ d") (kbd "C-c C-<left>"))
(global-set-key (kbd "C-c M-[ a") (kbd "C-c C-<up>"))
(global-set-key (kbd "C-c M-[ b") (kbd "C-c C-<down>"))
(global-set-key (kbd "ESC <down>") (kbd "M-<down>"))
(global-set-key (kbd "ESC <up>") (kbd "M-<up>"))

;; Add those escape sequences to iterm2.
(define-key input-decode-map "\e[1;4A" [M-up])
(define-key input-decode-map "\e[1;4B" [M-down])
(define-key input-decode-map "\e[1;4C" [M-right])
(define-key input-decode-map "\e[1;4D" [M-left])

(define-key input-decode-map "\e[1;5A" [C-up])
(define-key input-decode-map "\e[1;5B" [C-down])
(define-key input-decode-map "\e[1;5C" [C-right])
(define-key input-decode-map "\e[1;5D" [C-left])

(define-key input-decode-map "\e[1;8A" [C-M-up])
(define-key input-decode-map "\e[1;8B" [C-M-down])
(define-key input-decode-map "\e[1;8C" [C-M-right])
(define-key input-decode-map "\e[1;8D" [C-M-left])

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
(add-to-list 'load-path "~/.emacs.d/init")

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
      '((:name undo-tree
               :description "Treat undo history as a tree"
               :type git
               :url "http://www.dr-qubit.org/git/undo-tree.git"
               :prepare (progn
                          (autoload 'undo-tree-mode "undo-tree.el"
                            "Undo tree mode; see undo-tree.el for details" t)
                          (autoload 'global-undo-tree-mode "undo-tree.el"
                            "Global undo tree mode" t)))

        (:name evil
               :website "http://gitorious.org/evil/pages/Home"
               :type git
               :url "https://git.gitorious.org/evil/evil.git"
               :features evil
               :depends undo-tree)

        (:name evil-surround
               :website "http://github.com/timcharper/evil-surround"
               :type github
               :pkgname "timcharper/evil-surround"
               :features surround
               :post-init (global-surround-mode 1)
               :depends evil)

        (:name jell-theme
               :type git
               :url "git@github.com:Jell/jell-emacs-theme.git"
               :features jell-theme)

        (:name rvm
               :description "Emacs integration for rvm"
               :type github
               :features rvm
               :pkgname "senny/rvm.el"
               :compile "rvm.el"
               :post-init (rvm-use-default))

        (:name Enhanced-Ruby-Mode
               :type git
               :url "git://github.com/Jell/Enhanced-Ruby-Mode.git"
               :load "ruby-mode.el")

        (:name ruby-compilation :type elpa)

        (:name rdebug
               :description "Ruby debugger user interface, startup file."
               :type svn
               :url "http://ruby-debug.rubyforge.org/svn/trunk/emacs/")

        (:name scss-mode
               :description "Major mode for editing SCSS files(http://sass-lang.com)"
               :type github
               :pkgname "antonj/scss-mode"
               :features scss-mode)

        (:name yaml-mode
               :type github
               :pkgname "yoshiki/yaml-mode"
               :features yaml-mode)

        (:name auto-complete
               :website "http://auto-complete.org/"
               :description "The most intelligent auto-completion extension."
               :type github
               :pkgname "auto-complete/auto-complete"
               :depends (popup fuzzy))

        (:name markdown-mode
               :description "Major mode to edit Markdown files in Emacs"
               :type git
               :url "git://jblevins.org/git/markdown-mode.git")

        (:name rspec-mode
               :description "Enhance ruby-mode for RSpec"
               :type github
               :pkgname "pezra/rspec-mode"
               :features rspec-mode)

        (:name jekyll
               :type github
               :pkgname "diasjorge/jekyll.el"
               :features jekyll)

        (:name ack-and-a-half
               :type github
               :pkgname "jhelwig/ack-and-a-half"
               :features ack-and-a-half)

        (:name bundler
               :description "Interact with Bundler from Emacs"
               :type github
               :pkgname "tobiassvn/bundler.el")

        (:name nyan-mode
               :description "Nyan Cat for Emacs! Nyanyanyanyanyanyanyanyanyan!"
               :type git
               :url "git@github.com:Jell/nyan-mode.git"
               :features nyan-mode
               :after (nyan-mode))

        (:name multiple-cursors
               :description "Sublime-like multiple cursors"
               :type github
               :pkgname "magnars/multiple-cursors.el"
               :features multiple-cursors)

        (:name smooth-scroll
               :description "Minor mode for smooth scrolling."
               :type emacswiki
               :features smooth-scroll)

        (:name expand-region
               :type github
               :pkgname "magnars/expand-region.el"
               :description "Expand region increases the selected region by semantic units. Just keep pressing the key until it selects what you want."
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

        (:name helm
               :description "Emacs incremental and narrowing framework"
               :type github
               :pkgname "emacs-helm/helm"
               :features helm-config)

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

        (:name ace-jump-mode
               :website "https://github.com/winterTTr/ace-jump-mode/wiki"
               :description "A quick cursor location minor mode for emacs"
               :type github
               :pkgname "winterTTr/ace-jump-mode"
               :features ace-jump-mode)
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
