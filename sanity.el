;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(setq inhibit-splash-screen t)
;; Fix encoding
(setq default-process-coding-system '(utf-8 . utf-8))
;; Larger fonts
(set-face-attribute 'default nil :height 150)
;; Bug fix
(setq stack-trace-on-error t)
(setq imenu-auto-rescan t)
(ido-mode t)
(setq ido-enable-flex-matching t)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'saveplace)
(setq-default save-place t)

(show-paren-mode 1)
(setq-default indent-tabs-mode nil)
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t
      save-place-file (concat user-emacs-directory "places"))

;; Fix scrolling
(setq auto-window-vscroll nil)
;; Diable ring bell
(setq ring-bell-function 'ignore)
;; Remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(provide 'sanity)