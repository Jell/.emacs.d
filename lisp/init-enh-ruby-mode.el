;;; init-enh-ruby-mode.el --- -*- lexical-binding: t; -*-
(add-to-list 'auto-mode-alist '("Capfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.arb\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; Fix word limits
(modify-syntax-entry ?@ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?$ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?_ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?! "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?? "w" enh-ruby-mode-syntax-table)

;; Some extra keys
(evil-define-key 'normal enh-ruby-mode-map
  "J" (lambda () (interactive) (sp-ruby-delete-indentation -1)))

(add-hook 'post-self-insert-hook #'ruby-awesome-block)
(defun ruby-awesome-block ()
  (when (string= major-mode "enh-ruby-mode")
    (when (and (looking-at-p "}") (looking-back "{ "))
      (save-excursion
        (insert " ")))
    (when (or (and (looking-at-p "}") (looking-back "{\n"))
              (and (looking-at-p ")") (looking-back "(\n"))
              (and (looking-at-p "\\]") (looking-back "\\[\n")))
      (save-excursion
        (insert "\n")
        (indent-according-to-mode))
      (indent-according-to-mode))))

(add-hook 'enh-ruby-mode-hook
          #'(lambda ()
              (lsp-mode +1)
              (flycheck-mode +1)
              (flycheck-disable-checker 'ruby-reek)
              (require 'rspec-mode)
              (rspec-mode +1)
              (inf-ruby-minor-mode +1)))

;; Drop into a REPL when a spec hits binding.irb / binding.pry
(add-hook 'compilation-filter-hook #'inf-ruby-auto-enter-and-focus)

;; inf-ruby only recognises pry and debugger prompts; also match irb's
;; "irb(<receiver>):001> ", where the receiver may itself contain parens.
(with-eval-after-load 'inf-ruby
  (setq inf-ruby-breakpoint-pattern
        (concat inf-ruby-breakpoint-pattern
                "\\|\\(^irb(.*):[0-9]+\\(:[0-9]+\\)?> \\)")))

(provide 'init-enh-ruby-mode)
