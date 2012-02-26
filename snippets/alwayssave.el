;; Always save even when buffer is not modified
(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))

(global-set-key (kbd "C-x C-s") 'save-buffer-always)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
