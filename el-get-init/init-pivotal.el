(require 'pivotal)

(defun slurp (path)
  (with-temp-buffer
    (insert-file-contents path)
    (buffer-string)))

(define-key git-commit-mode-map (kbd "C-x i") 'pivotal-make-ref)
