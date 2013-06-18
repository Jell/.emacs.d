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

;; html modes
(sp-with-modes '(
                 sgml-mode
                 html-mode
                 )
  (sp-local-pair "<" ">")
  (sp-local-tag  "<" "<_>" "</_>" :transform 'sp-match-sgml-tags))

;; smartparens where we want
(require 'smartparens-ruby)
(add-hook 'ruby-mode-hook (lambda () (smartparens-mode +1)))

(provide 'my-smartparens-config)
