;; Key bindings for mac
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq mac-option-modifier 'none)
(setq mac-command-modifier 'meta)
(setq mac-function-modifier 'super)

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
;; Smex
(global-set-key (kbd "M-x") 'smex)
;; Dash
(global-set-key (kbd "C-c C-d") 'dash-at-point)
(global-set-key (kbd "C-c C-c C-d") 'dash-at-point-with-docset)

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

(provide 'setup-keys)
