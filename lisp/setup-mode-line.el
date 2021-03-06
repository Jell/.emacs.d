(setq-default
 mode-line-format
 (list
  ;; the buffer name; the file name as a tool tip
  '(:eval
    (propertize
     " %b"
     'face 'font-lock-keyword-face
     'help-echo (buffer-file-name)))

  ;; line and column
  (propertize
   ":%01l "
   'face 'font-lock-type-face
   'help-echo '(format-mode-line "Line: %01l, Column: %01c"))

  '(:eval
    (propertize
     (concat (cond (evil-mode (cond ((evil-normal-state-p) "N")
                                    ((evil-insert-state-p) "I")
                                    ((evil-visual-state-p) "V")
                                    ((evil-emacs-state-p) "E")
                                    ((evil-replace-state-p) "R")
                                    ((evil-operator-state-p) "O")
                                    ((evil-motion-state-p) "M")
                                    (t evil-mode)))
                   (global-sublime-keys-mode "SUBLIME")
                   (global-emacs-keys-mode "EMACS")
                   (t "")))))

  ;; the current major mode for the buffer.
  '(:eval
    (propertize
     (concat " "
             (format-mode-line mode-name)
             "")
     'face 'font-lock-string-face
     'help-echo (concat "Minor modes: ["
                        (format-mode-line minor-mode-alist)
                        " ]")))

  '(:eval
    (when nyan-mode
      (concat
       " "
       (propertize
        (format-mode-line (list (nyan-create)))
        'help-echo "nyan nyan nyan nyan nyan nyan nyan nyan nyan nyan nyan..."))))

  '(:eval
    (propertize
     (if vc-mode (concat vc-mode " ") "")
     'face 'font-lock-variable-name-face))

  ;; add the time, with the date and the emacs uptime in the tooltip
  '(:eval
    (propertize
     (format-time-string " %H:%M ")
     'help-echo
     (concat (format-time-string "%c; ")
             (emacs-uptime "Uptime:%hh"))))

  '(:eval
    (propertize
     (if overwrite-mode " Ovr " " Ins ")
     'face 'font-lock-preprocessor-face
     'help-echo (concat "Buffer is in "
                        (if overwrite-mode "overwrite" "insert")
                        " mode")))

  ;; is this buffer read-only?
  '(:eval
    (when buffer-read-only
      (propertize
       " RO "
       'face 'font-lock-type-face
       'help-echo "Buffer is read-only")))

  ;; was this buffer modified since the last save?
  '(:eval
    (when (buffer-modified-p)
      (propertize
       " Mod "
       'face 'font-lock-warning-face
       'help-echo "Buffer has been modified")))))

(provide 'setup-mode-line)
