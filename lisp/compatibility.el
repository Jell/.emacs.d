(when (not (fboundp 'read-only-mode))
  (defalias 'read-only-mode 'toggle-read-only))

(when window-system
  (menu-bar-mode))

(provide 'compatibility)
