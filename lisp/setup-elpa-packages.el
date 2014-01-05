(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("tromey" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(rainbow-delimiters
                      rainbow-mode
                      coffee-mode
                      paredit
                      cider
                      ac-nrepl
                      find-file-in-project
                      smex
                      ido-ubiquitous
                      gist
                      slime
                      haskell-mode
                      erlang
                      sass-mode)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Package defs ---------------------------------------------------------------

(require 'cl)
(require 'saveplace)
(require 'ffap)
(require 'uniquify)
(require 'ansi-color)
(require 'recentf)

;; Ido Ubi
(require 'ido-ubiquitous)
(ido-ubiquitous-mode +1)

;; Clojure
(require 'init-cider)

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

;; Enable rainbow delimiters
(global-rainbow-delimiters-mode)

;; Paredit for classic modes
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))

(provide 'setup-elpa-packages)
