(defun sublimify ()
  (interactive)
  (evil-mode 0)
  (global-emacs-keys-mode 0)
  (global-sublime-keys-mode 1))

(defun un-sublimify ()
  (interactive)
  (global-sublime-keys-mode 0)
  (evil-mode 1)
  (dolist (b (buffer-list))
    (unless (minibufferp b)
      (evil-initialize-state 'normal b))))

(define-minor-mode sublime-keys-mode
  "A minor mode for sublime keys."
  ;; The initial value
  nil
  ;; The indicator for the mode line.
  " SUBL"
  ;; Key Bindings
  '(("\M-t" . find-file-in-project)
    ("\M-s" . save-buffer-always)
    ("\M-v" . yank)
    ("\M-c" . kill-ring-save)
    ("\M-x" . kill-region)
    ("\M-z" . undo)
    ("\M-Z" . redo)
    ("\M-d" . mc/mark-next-like-this)
    ("\M-a" . mark-whole-buffer)
    ([C-M-up] . move-lines-up)
    ([C-M-down] . move-lines-down)
    ("\C-z" . un-sublimify)
    ("\M-X" . smex)))

(define-global-minor-mode global-sublime-keys-mode
  sublime-keys-mode
  (lambda () (sublime-keys-mode 1)))
