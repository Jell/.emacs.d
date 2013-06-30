(when (not (fboundp 'read-only-mode))
  (defalias 'read-only-mode 'toggle-read-only))

(provide 'compatibility)
