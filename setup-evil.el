(defun fix-for-evil ()
  (when (and (> (mc/num-cursors) 0)
             (evil-normal-state-p evil-next-state))
    (mc/execute-command-for-all-fake-cursors 'evil-backward-char)))

(defun other-fix-for-evil ()
  (when (and (> (mc/num-cursors) 0)
             (not (evil-visual-state-p evil-next-state)))
    (mc/execute-command-for-all-fake-cursors 'evil-visual-char)))

(setq viper-mode t)
(setq viper-custom-file-name "~/.emacs.d/viper")
(setq viper-ex-style-editing nil)
(setq evil-want-fine-undo t)
(setq evil-default-cursor t)
;; (add-hook 'evil-normal-state-exit-hook 'fix-for-evil)
(require 'evil)
(evil-mode 1)


(provide 'setup-evil)
