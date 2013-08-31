(when (not (fboundp 'read-only-mode))
  (defalias 'read-only-mode 'toggle-read-only))

;; No native fullscreen, thank you very much.
(setq ns-use-native-fullscreen nil)

(when window-system
  (menu-bar-mode))

(provide 'compatibility)
