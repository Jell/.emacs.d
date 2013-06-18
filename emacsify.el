(defun emacsify ()
  (interactive)
  (evil-mode 0)
  (global-sublime-keys-mode 0)
  (cua-selection-mode 1)
  (pending-delete-mode 1)
  (global-emacs-keys-mode 1))

(defun un-emacsify ()
  (interactive)
  (global-emacs-keys-mode 0)
  (cua-selection-mode 0)
  (pending-delete-mode 0)
  (evil-mode 1)
  (dolist (b (buffer-list))
    (unless (minibufferp b)
      (evil-initialize-state 'normal b))))

(define-minor-mode emacs-keys-mode
  "A minor mode for emacs keys."
  ;; The initial value
  nil
  ;; The indicator for the mode line.
  " EM"
  ;; Key Bindings
  `((,(kbd "C-z") . un-emacsify)
    (,(kbd "C-c RET") . cua-set-rectangle-mark)
    (,(kbd "M-.") . complete-symbol)
    (,(kbd "M-:") . mc/mark-next-like-this)
    (,(kbd "M-;") . mc/mark-previous-like-this)
    (,(kbd "C-v") . er/expand-region)
    (,(kbd "C-f") . kill-whole-line)
    (,(kbd "M-*") . ace-jump-word-mode)))

(define-global-minor-mode global-emacs-keys-mode
  emacs-keys-mode
  (lambda () (emacs-keys-mode 1)))
