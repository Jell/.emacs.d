;; Turn off mouse interface early in startup to avoid momentary display
;; You really don't need these; trust me.
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Key bindings for mac
(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(global-set-key (kbd "M-=") 'indent-region)
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "M-/") 'hippie-expand)

;; Extra load paths
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/filetypes")

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
                      coffee-mode
                      color-theme-solarized
                      full-ack
                      slime
                      starter-kit
                      undo-tree )
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

(require 'starter-kit-defuns)
(require 'starter-kit-misc)

;; CoffeeScript
(autoload 'coffee-mode "coffee-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.decaf$" . js-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))

(defun coffee-mode-hook ()
  (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook 'coffee-mode-hook)

;; Clojure
(defun clojure-mode-hook ()
  (paredit-mode 1)
  (load "clj.el"))
(add-hook 'clojure-mode-hook 'clojure-mode-hook)

(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; el-get packages
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Install hooks, called only after the package is installed (so we
;; can install them asynchronously. Pretty cool stuff.

(defun ruby-mode-hook ()
  (require 'ruby-mode)
  (require 'inf-ruby)
  (require 'ruby-compilation)
  (add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
  (add-hook 'ruby-mode-hook '(lambda ()
                               (rvm-activate-corresponding-ruby)
                               (rinari-launch)
                               (setq enh-ruby-program "/Users/Jell/.rvm/rubies/ruby-1.9.2-p290/bin/ruby")
                               (setq ruby-deep-arglist t)
                               (setq ruby-deep-indent-paren nil)
                               (setq ruby-hanging-indent-level 2)
                               (setq c-tab-always-indent nil))))

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


;; Package list ----------------------------------------------------------------

(setq el-get-sources
      '((:name evil
               :type git
               :url "git://gitorious.org/evil/evil.git"
               :load "evil.el"
               :after (progn (evil-hook)))
        (:name rvm
               :type git
               :url "http://github.com/djwhitt/rvm.el.git"
               :load "rvm.el"
               :compile ("rvm.el")
               :after (progn (rvm-hook)))
        (:name inf-ruby  :type elpa)
        (:name ruby-compilation :type elpa)
        (:name rinari
               :description "Rinari Is Not A Rails IDE"
               :type github
               :pkgname "eschulte/rinari"
               :load-path ("." "util" "util/jump")
               :compile ("\\.el$" "util")
               :build ("rake doc:install_info")
               :info "doc"
               :features rinari
               :after (progn (rinari-hook)))
        (:name css-mode
               :type elpa
               :after (progn (css-mode-hook)))
        (:name rhtml
               :type git
               :url "https://github.com/eschulte/rhtml.git"
               :features rhtml-mode
               :after (progn (rhtml-mode-hook)))
        (:name yaml-mode
               :type git
               :url "http://github.com/yoshiki/yaml-mode.git"
               :features yaml-mode
               :after (progn (yaml-mode-hook)))
        (:name Enhanced-Ruby-Mode
               :type git
               :url "git://github.com/Jell/Enhanced-Ruby-Mode.git"
               :load "ruby-mode.el"
               :after (progn (ruby-mode-hook)))
        (:name pig-mode
               :type git
               :url "https://github.com/motus/pig-mode.git"
               :features pig-mode
               :after (progn (pig-mode-hook)))))

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
      (let (el-get-master-branch)
        (end-of-buffer)
        (eval-print-last-sexp)
        (setq el-get-verbose t)
        (sync-packages)))))

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
                    backward-char forward-char))
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

;; Speedbar
(when window-system
  (speedbar 1)
  (previous-multiframe-window))

(global-auto-revert-mode t)

(menu-bar-mode)
