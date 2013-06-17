(require 'smartparens)

;; helpers
(defun sp-ruby-delete-indentation (&optional arg)
  (delete-indentation arg)
  (when (looking-at " [.([,]")
    (delete-char 1))
  (save-excursion
    (backward-char)
    (when (looking-at "\\. ")
      (forward-char)
      (delete-char 1))))

(defun sp-ruby-pre-handler (id action context)
  (when (equal action 'slurp-backward)
    (save-excursion
      (sp-forward-sexp)
      (sp-ruby-delete-indentation -1))
    (save-excursion
      (newline))
    (when (not (looking-back " "))
      (insert " ")))

  (when (equal action 'barf-backward)
    (save-excursion
      (sp-backward-sexp)
      (sp-ruby-delete-indentation))
    (save-excursion
      (newline))
    (when (not (looking-back " "))
      (insert " ")))

  (when (equal action 'slurp-forward)
    (save-excursion
      (sp-backward-sexp)
      (sp-ruby-delete-indentation))
    (newline))

  (when (equal action 'barf-forward)
    (save-excursion
      (sp-forward-sexp)
      (sp-ruby-delete-indentation -1))
    (newline)))

(sp-with-modes '(ruby-mode)

  ;; Blocks
  (sp-local-pair "do" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "{" "}"
                 :actions '(insert wrap)
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "begin" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  ;; Defs

  (sp-local-pair "def" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "class" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "module" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "if" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))

  (sp-local-pair "unless" "end"
                 :actions '()
                 :pre-handlers '(sp-ruby-pre-handler))
  )

(provide 'smartparens-ruby)
