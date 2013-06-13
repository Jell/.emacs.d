(defun emacsify ()
  (interactive)
  (evil-mode 0)
  (cua-mode 1)
  (global-sublime-keys-mode 0)
  (global-emacs-keys-mode 1))

(defun un-emacsify ()
  (interactive)
  (global-emacs-keys-mode 0)
  (cua-mode 0)
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
    (,(kbd "C-c RET") . cua-set-rectangle-mark)))

(define-global-minor-mode global-emacs-keys-mode
  emacs-keys-mode
  (lambda () (emacs-keys-mode 1)))
