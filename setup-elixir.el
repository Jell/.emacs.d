(defun elixir-mode-compile-on-save ()
  "Elixir mode compile files on save."
  (and (file-exists-p (buffer-file-name))
       (file-exists-p (elixir-mode-compiled-file-name))
       (elixir-cos-mode t)))
(add-hook 'elixir-mode-hook 'elixir-mode-compile-on-save)

(defun elixir-mode-eval-on-region-or-current-line (beg end)
  (interactive "r")
  (if (and beg end mark-active)
      (elixir-mode-eval-on-region beg end)
    (elixir-mode-eval-on-current-line)))

(defun elixir-mode-custom-keys ()
  (local-set-key (kbd "C-M-x") 'elixir-mode-eval-on-region-or-current-line)
  (local-set-key (kbd "C-c C-c") 'elixir-mode-compile-file))
(add-hook 'elixir-mode-hook 'elixir-mode-custom-keys)

(defun elixir-mode--message (string)
  (save-window-excursion
    (pop-to-buffer "*Elixir-Messages*")
    (erase-buffer)
    (insert "\# Output:\n\n")
    (insert string)
    (insert "\n")))

(defun elixir-mode--eval-string (string)
  (let ((output (elixir-mode--execute-elixir-with-code-eval-string string)))
    (elixir-mode--message output)))

(defun elixir-mode--string-to-quoted (string)
  (let* ((output (elixir-mode--execute-elixir-with-code-string-to-quoted string)))
    (elixir-mode--message output)))

(provide 'setup-elixir)
