;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Key bindings for mac
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(global-set-key (kbd "M-=") 'indent-region)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-f") 'find-file-in-project)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-visual-line-mode)

;; Larger fonts
(set-face-attribute 'default nil :height 150)

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
(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(clojure-mode
                      rainbow-delimiters
                      rainbow-mode
                      coffee-mode
                      color-theme-solarized
                      full-ack
                      slime
                      starter-kit
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
(autoload 'erlang-mode "erlang-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))

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
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda () (load "rb.el"))))

(defun rinari-hook ()
  (require 'rinari))

(defun rhtml-mode-hook ()
  (autoload 'rhtml-mode "rhtml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
  (add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
  (add-hook 'rhtml-mode '(lambda ()
                           (define-key rhtml-mode-map (kbd "M-s") 'save-buffer))))

(defun yaml-mode-hook ()
  (autoload 'yaml-mode "yaml-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(defun css-mode-hook ()
  (autoload 'css-mode "css-mode" nil t)
  (add-hook 'css-mode-hook '(lambda ()
                              (setq css-indent-level 2)
                              (setq css-indent-offset 2))))

(defun rvm-hook ()
  (rvm-use-default))

(defun pig-mode-hook ()
  (autoload 'pig-mode "pig-mode" nil t))

(defun evil-hook ()
  (setq viper-mode t)
  (setq viper-custom-file-name "~/.emacs.d/viper")
  (setq viper-ex-style-editing nil)
  (setq evil-want-fine-undo t)
  (require 'evil)
  (evil-mode 1))

(defun yasnippet-hook ()
  (require 'yasnippet)
  (setq yas/snippet-dirs '("~/.emacs.d/el-get/yasnippet/snippets"
                           "~/.emacs.d/el-get/yasnippet/extras/imported"
                           "~/.emacs.d/snippets"))
  (setq yas/trigger-key "TAB")
  (yas/global-mode 1))


;; Package list ----------------------------------------------------------------

(setq el-get-sources
      '((:name popup
               :website "https://github.com/m2ym/popup-el"
               :description "Visual Popup Interface Library for Emacs"
               :type git
               :url "https://github.com/m2ym/popup-el.git"
               :features popup)
        (:name evil
               :type git
               :url "git://gitorious.org/evil/evil.git"
               :load "evil.el"
               :post-init (lambda () (evil-hook)))
        (:name evil-surround
               :url "git://github.com/timcharper/evil-surround.git"
               :type git
               :load "surround.el"
               :features surround
               :post-init (lambda () (global-surround-mode 1)))
        (:name rvm
               :type git
               :url "git://github.com/senny/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :post-init (lambda () (rvm-hook)))
        (:name Enhanced-Ruby-Mode
               :type git
               :url "git://github.com/Jell/Enhanced-Ruby-Mode.git"
               :load "ruby-mode.el"
               :post-init (lambda () (ruby-mode-hook)))
        (:name ruby-compilation :type elpa)
        (:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type git
               :url "http://github.com/eschulte/rinari.git"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               :build ("rake doc:install_info")
               :info "doc"
               :features rinari
               :post-init (lambda () (rinari-hook)))
        (:name css-mode
               :type elpa
               :post-init (lambda () (css-mode-hook)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :post-init (lambda () (rhtml-mode-hook)))
        (:name yaml-mode
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :post-init (lambda () (yaml-mode-hook)))
        (:name yasnippet
               :website "http://code.google.com/p/yasnippet/"
               :description "YASnippet is a template system for Emacs."
               :type git
               :url "https://github.com/capitaomorte/yasnippet.git"
               :features "yasnippet"
               :prepare (lambda ()
                          ;; Set up the default snippets directory
                          ;;
                          ;; Principle: don't override any user settings
                          ;; for yas/snippet-dirs, whether those were made
                          ;; with setq or customize.  If the user doesn't
                          ;; want the default snippets, she shouldn't get
                          ;; them!
                          (unless (or (boundp 'yas/snippet-dirs) (get 'yas/snippet-dirs 'customized-value))
                            (setq yas/snippet-dirs
                                  (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets")))))
               :post-init (lambda ()
                            ;; Trick customize into believing the standard
                            ;; value includes the default snippets.
                            ;; yasnippet would probably do this itself,
                            ;; except that it doesn't include an
                            ;; installation procedure that sets up the
                            ;; snippets directory, and thus doesn't know
                            ;; where those snippets will be installed.  See
                            ;; http://code.google.com/p/yasnippet/issues/detail?id=179
                            (put 'yas/snippet-dirs 'standard-value
                                 ;; as cus-edit.el specifies, "a cons-cell
                                 ;; whose car evaluates to the standard
                                 ;; value"
                                 (list (list 'quote
                                             (list (concat el-get-dir (file-name-as-directory "yasnippet") "snippets"))))))
               ;; byte-compile load vc-svn and that fails
               ;; see https://github.com/dimitri/el-get/issues/200
               :compile nil)
        (:name auto-complete
               :description "The most intelligent auto-completion extension."
               :type git
               :url "git://github.com/m2ym/auto-complete.git"
               :depends popup
               :post-init (lambda ()
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
        (:name ecb
               :description "Emacs Code Browser"
               :type cvs
               :module "ecb"
               :url ":pserver:anonymous@ecb.cvs.sourceforge.net:/cvsroot/ecb"
               :build `(("make" "CEDET=" ,(concat "EMACS=" (shell-quote-argument el-get-emacs)))))
        (:name pig-mode
               :type git
               :url "https://github.com/motus/pig-mode.git"
               :features pig-mode
               :after (lambda () (pig-mode-hook)))))

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

;; Do not *ding* on scroll and other stuff.
(defun my-bell-function ()
  (unless (memq this-command
                '(isearch-abort abort-recursive-edit exit-minibuffer
                                keyboard-quit mwheel-scroll down up next-line previous-line
                                backward-char forward-char end-of-buffer))
    (ding)))
(setq ring-bell-function 'my-bell-function)

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

(setq c-tab-always-indent nil)

(when window-system
  (menu-bar-mode))
(put 'ido-exit-minibuffer 'disabled nil)
