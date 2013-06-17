(require 'smartparens)

;; helpers
(defun sp-ruby-block-post-handler (id action context)
  (when (equal action 'insert)
    (save-excursion
      (newline)
      (indent-according-to-mode))
    (indent-according-to-mode)))

(defun sp-ruby-def-post-handler (id action context)
  (when (equal action 'insert)
    (save-excursion
      (insert " _")
      (newline)
      (indent-according-to-mode))
    (kill-forward-chars 2)
    (indent-according-to-mode)))

(defun sp-ruby-pre-handler (id action context)
  (when (equal action 'slurp-backward)
    (save-excursion
      (sp-forward-sexp)
      (delete-indentation -1))
    (save-excursion
      (newline)))

  (when (equal action 'barf-backward)
    (save-excursion
      (sp-backward-sexp)
      (delete-indentation))
    (save-excursion
      (newline)))

  (when (equal action 'slurp-forward)
    (save-excursion
      (sp-backward-sexp)
      (delete-indentation))
    (newline))

  (when (equal action 'barf-forward)
    (save-excursion
      (sp-forward-sexp)
      (next-line)
      (delete-indentation))
    (newline)))

(sp-with-modes '(ruby-mode)

  ;; Blocks
  (sp-local-pair "do" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-block-post-handler))

  (sp-local-pair "begin" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-block-post-handler))

  ;; Defs

  (sp-local-pair "def" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "class" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "module" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "if" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "unless" "end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))
  )

(provide 'smartparens-ruby)
