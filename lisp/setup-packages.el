(use-package evil
  :init
  (setq evil-want-fine-undo t)
  (setq evil-default-cursor t)
  (require 'evil)
  (evil-mode 1))
(use-package jell-theme
  :quelpa (jell-theme :fetcher github :repo "Jell/jell-emacs-theme")
  :init
  (require 'jell-theme)
  (enable-theme 'jell))
(use-package rainbow-delimiters :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(use-package paredit
  :init
  (add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
  (add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
  (add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
  (add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
  (add-hook 'clojure-mode-hook          (lambda () (paredit-mode +1))))
(use-package undo-tree
  :init
  (global-undo-tree-mode))
(use-package smex)
(use-package find-file-in-project)
(use-package evil-surround)
(use-package evil-leader :init (global-evil-leader-mode))
(use-package evil-exchange)
(use-package xclip
  :init
  (xclip-mode 1))
;; (use-package company-mode)
(use-package auto-complete
  :init
  (require 'auto-complete)
  (add-to-list 'ac-dictionary-directories (expand-file-name "dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  (add-hook 'go-mode-hook (lambda () (auto-complete-mode -1))))
(use-package projectile)
(use-package yaml-mode)
(use-package markdown-mode)
(use-package ag
  :init
  (require 'ag)
  (define-key ag-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode)
  (setq ag-highlight-search t)
  (setq ag-reuse-buffers 't))
(use-package nyan-mode)
(use-package smooth-scroll :init (require 'smooth-scroll) (smooth-scroll-mode t))
(use-package magit)
(use-package ido-completing-read+
  :init
  (ido-mode 1)
  (ido-everywhere 1)
  (require 'ido-completing-read+)
  (ido-ubiquitous-mode 1))
;; Ruby related ------
(use-package enh-ruby-mode :config (require 'init-enh-ruby-mode))
(use-package rspec-mode)
(use-package smartparens :init (require 'init-smartparens))
(use-package coffee-mode)
(use-package direnv :config (direnv-mode))
(use-package rubocop
  :init
  (add-hook 'ruby-mode-hook #'rubocop-mode))
;; -------------------
;; Clojure related ----
(use-package cider)
(use-package flycheck-clj-kondo)
(use-package clj-refactor
  :init
  (require 'init-clojure))
;; --------------------
(use-package flycheck)
;; (use-package spiral)
;; (use-package jekyll-el)
;; (use-package multiple-cursors)
;; (use-package cl-lib)
(use-package web-mode
  :init
  (require 'web-mode)
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js\\'")))
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-attr-indent-offset 4))
(use-package guide-key :init (require 'guide-key) (guide-key-mode 1))
(use-package alchemist)
;; (use-package w3m)
(use-package bbdb)
(use-package wgrep-ag
  :init
  (autoload 'wgrep-ag-setup "wgrep-ag")
  (add-hook 'ag-mode-hook 'wgrep-ag-setup))
(use-package restclient
  :init
  (add-to-list 'auto-mode-alist '("\\.http\\'" . restclient-mode)))
(use-package jinja2-mode)
(use-package rust-mode)
(use-package flymake-easy)
;; (use-package flymake-rust :init (require 'flymake-rust) (add-hook 'rust-mode-hook 'flymake-rust-load))
(use-package org-present :init (require 'init-org-present))
;; (use-package tuareg-mode)
(use-package purescript-mode)
(use-package psc-ide
  :init
  (add-hook 'purescript-mode-hook
            (lambda ()
              (psc-ide-mode)
              (company-mode)
              (flycheck-mode)
              (turn-on-purescript-indentation))))
(use-package elm-mode)
(use-package js2-mode)
(use-package skewer-mode)
(use-package sass-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.scss" . sass-mode))
  (add-to-list 'auto-mode-alist '("\\.sass" . sass-mode)))
(use-package impatient-mode)
(use-package idris-mode :init (add-to-list 'completion-ignored-extensions ".ibc"))
(use-package esup)
(use-package graphviz-dot-mode)
(use-package dockerfile-mode)
(use-package terraform-mode)
(use-package image+)
(use-package plantuml-mode
  :init
  (if (string= system-type "darwin")
      (setq plantuml-executable-path "/opt/homebrew/bin/plantuml")
      (setq plantuml-executable-path "/usr/bin/plantuml"))
  (setq plantuml-default-exec-mode 'executable))
(use-package tide :init (require 'init-tide)) ;; TypeScript
;; (use-package racket-mode)
(use-package inf-ruby)
(use-package crystal-mode)
(use-package php-mode)
(use-package string-inflection)
(use-package swift-mode)
(use-package kotlin-mode)
;; go IDE related -------
(use-package go-mode :init (require 'init-go-mode))
(use-package go-eldoc)
(use-package yasnippet)
(use-package lsp-mode
  :init
  (setq lsp-prefer-capf 't)
  (with-eval-after-load 'lsp-mode
    (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\vendor\\'"))
  (add-hook 'lsp-mode-hook 'yas-minor-mode-on))
(use-package lsp-ui
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))
(use-package lsp-haskell
  :init
  (add-hook 'haskell-mode-hook #'lsp)
  (add-hook 'haskell-literate-mode-hook #'lsp))
;;(use-package dap-mode)
(use-package flymake-shellcheck
  :commands flymake-shellcheck-load
  :init
  (add-hook 'sh-mode-hook 'flymake-mode)
  (add-hook 'sh-mode-hook 'flymake-shellcheck-load))
;; ----------------------
;; Kubernetes -----------
(use-package kubernetes
  :init
  (setq kubernetes-poll-frequency 3600)
  (setq kubernetes-redraw-frequency 3600))
(use-package kubernetes-evil)
;; ----------------------
;; Crypto crap
(use-package solidity-mode)
;; Python ---------------
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp))))  ; or lsp-deferred
(use-package python-pytest)
(use-package ess)
(use-package lua-mode)
(use-package protobuf-mode)
(use-package auto-package-update
  :config
  (setq auto-package-update-prompt-before-update t)
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))
;; (auto-package-update-now)

(provide 'setup-packages)
