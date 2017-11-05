;; Leader keys
(evil-leader/set-key
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer)

;; Extra keybindings
(global-set-key (kbd "C-x C-s") 'save-buffer-always)
(global-set-key (kbd "C-x f") 'find-file-in-project)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-S-k") 'kill-whole-line)

;; Multi cursors
(global-set-key (kbd "M--") 'mc/mark-next-like-this)
(global-set-key (kbd "M-+") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-M-+") 'mc/mark-all-like-this)

;; Expand mark
(global-set-key (kbd "M-+") 'er/expand-region)

;; For sublime users
;; (global-set-key (kbd "C-c s") 'sublimify)
;; (global-set-key (kbd "C-c e") 'emacsify)
(global-set-key (kbd "<C-M-mouse-1>") 'control-meta-click)

;; Magit
(global-set-key (kbd "C-x g") 'magit-lazy-status)

;; Ag
(global-set-key (kbd "C-x C-p") 'ag-project)

;; Smex
(global-set-key (kbd "M-x") 'smex)

;; Breadcrumbs
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

;; Fix evil stuff
(define-key evil-insert-state-map (kbd "C-k") nil)

(provide 'setup-keys)
