;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
;; Extra load paths
(add-to-list 'load-path "~/.emacs.d")
;; Fix encoding
(setq default-process-coding-system '(utf-8 . utf-8))
;; Larger fonts
(set-face-attribute 'default nil :height 150)
;; Bug fix
(setq stack-trace-on-error t)
(setq imenu-auto-rescan t)
;; Fix scrolling
(setq auto-window-vscroll nil)

(require 'setup-paths)
(require 'setup-scratch-message)
(require 'compatibility)
(require 'setup-keys)
(require 'setup-hippie-expand)
(require 'setup-elpa-packages)
(require 'setup-elget-packages)
(require 'setup-mode-line)
(require 'setup-helpers)
(require 'sublimify)
(require 'emacsify)
(require 'movelines)
(require 'setup-backup)

;; Diable ring bell
(setq ring-bell-function 'ignore)
;; Remove trailing whitespaces
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq c-tab-always-indent nil)

(put 'ido-exit-minibuffer 'disabled nil)
