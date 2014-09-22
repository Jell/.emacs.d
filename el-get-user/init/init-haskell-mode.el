(haskell-indent-mode 1)
(interactive-haskell-mode 1)

(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(define-key haskell-mode-map (kbd "C-c M-.") 'haskell-mode-jump-to-def)
