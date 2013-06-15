(require 'smartparens)
(sp-use-paredit-bindings)

;; do not autoinsert ' pair if the point is preceeded by word.  This
;; will handle the situation when ' is used as a contraction symbol in
;; natural language.  Nil for second argument means to keep the
;; original definition of closing pair.
(sp-pair "'" nil :unless '(sp-point-after-word-p))


;; NOTE: Normally, `sp-local-pair' accepts list of modes (or a single
;; mode) as a first argument.  The macro `sp-with-modes' adds this
;; automatically.  If you want to call sp-local-pair outside this
;; macro, you MUST supply the major mode argument.

;; LaTeX modes
(sp-with-modes '(
                 tex-mode
                 plain-tex-mode
                 latex-mode
                 )
  ;; math modes, yay.  The :actions are provided automatically if
  ;; these pairs do not have global definition.
  (sp-local-pair "$" "$")
  (sp-local-pair "\\[" "\\]")
  (sp-local-pair "`" "'")
  (sp-local-tag "\\b" "\\begin{_}" "\\end{_}"))

;; Ruby mode
(defun my-sp-ruby-block-on-newline (id action context)
  "Put trailing pair on newline and return to point."
  (save-excursion
    (newline)
    (indent-according-to-mode))
  (indent-according-to-mode))

(defun my-sp-ruby-def-on-newline (id action context)
  "Put trailing pair on newline and return to point."
  (save-excursion
    (insert "_")
    (newline)
    (indent-according-to-mode))
  (kill-forward-chars 1)
  (indent-according-to-mode))

(defun my-sp-insert-ruby-end (id action context)
  (when (string-prefix-p "close" (symbol-name action))
    (if (equal action 'close-forward)
        (save-excursion
          (sp-backward-sexp)
          (delete-indentation))
      (save-excursion
        (sp-forward-sexp)
        (next-line)
        (delete-indentation)))
    (newline)))

(sp-with-modes '(
                 ruby-mode
                 )

  (sp-local-pair " do" "  end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(my-sp-insert-ruby-end)
                 :post-handlers '(my-sp-ruby-block-on-newline))

  (sp-local-pair "begin" "  end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(my-sp-insert-ruby-end)
                 :post-handlers '(my-sp-ruby-block-on-newline))

  (sp-local-pair "def " "  end"
                 :unless '(sp-in-string-p)
                 :actions '(insert)
                 :pre-handlers '(my-sp-insert-ruby-end)
                 :post-handlers '(my-sp-ruby-def-on-newline))
  )

;; html modes
(sp-with-modes '(
                 sgml-mode
                 html-mode
                 )
  (sp-local-pair "<" ">")
  (sp-local-tag  "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))

;; smartparens where we want
(add-hook 'ruby-mode-hook (lambda () (smartparens-mode +1)))

(provide 'my-smartparens-config)
