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
      (delete-indentation -1))
    (newline)))

(defun sp-ruby-in-string-or-word-p (id action context)
  (or (sp-in-string-p id action context)
      (and (looking-back id)
           (not (looking-back (sp--strict-regexp-quote id))))))

(defun sp-ruby-no-do-block-p (id action context)
  (or (sp-ruby-in-string-or-symbol-p id action context)
      (and (looking-back (sp--strict-regexp-quote id))
           (not (looking-back (concat "[^ ] " id))))))

(sp-with-modes '(ruby-mode)

  ;; Blocks
  (sp-local-pair "do" "end"
                 :unless '(sp-ruby-no-do-block-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-block-post-handler))

  (sp-local-pair "begin" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-block-post-handler))

  ;; Defs

  (sp-local-pair "def" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "class" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "module" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "if" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))

  (sp-local-pair "unless" "end"
                 :unless '(sp-ruby-in-string-or-word-p)
                 :actions '(insert)
                 :pre-handlers '(sp-ruby-pre-handler)
                 :post-handlers '(sp-ruby-def-post-handler))
  )

(provide 'smartparens-ruby)
