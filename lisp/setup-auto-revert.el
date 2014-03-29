(global-auto-revert-mode 1)
(defun set-image-mode-after-revert-if-image-minor-mode ()
  (interactive)
  (if (member 'image-minor-mode minor-mode-list)
      (image-mode)))
(add-hook 'after-revert-hook 'set-image-mode-after-revert-if-image-minor-mode)

(provide 'setup-auto-revert)
