(define-minor-mode hidden-mode-line-mode
  "Minor mode to hide the mode-line in the current buffer."
  :init-value nil
  :global nil
  :variable hidden-mode-line-mode
  :group 'editing-basics
  (if hidden-mode-line-mode
      (setq hide-mode-line mode-line-format
            mode-line-format nil)
    (setq mode-line-format hide-mode-line
          hide-mode-line nil))
  (force-mode-line-update)
  (set-window-buffer nil (current-buffer))
  (when (and (called-interactively-p 'interactive)
             hidden-mode-line-mode)
    (run-with-idle-timer
     0 nil 'message
     (concat "Hidden Mode Line Mode enabled.  "
             "Use M-x hidden-mode-line-mode RET to make the mode-line appear."))))

(eval-after-load "org-present"
  '(progn
     (define-key org-present-mode-keymap (kbd "q") 'org-present-quit)
     (setq org-present-text-scale 1)
     (add-hook 'org-present-mode-hook
               (lambda ()
                 (evil-emacs-state nil)
                 (blink-cursor-mode 0)
                 (hidden-mode-line-mode 1)
                 (org-present-big)
                 (org-display-inline-images)
                 (org-present-hide-cursor)
                 (org-present-read-only)))
     (add-hook 'org-present-mode-quit-hook
               (lambda ()
                 (blink-cursor-mode 1)
                 (hidden-mode-line-mode 0)
                 (org-present-small)
                 (org-remove-inline-images)
                 (org-present-show-cursor)
                 (org-present-read-write)
                 (evil-normal-state nil)))))
