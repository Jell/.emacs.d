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
(add-to-list 'ac-modes 'enh-ruby-mode)

;; Fix word limits
(modify-syntax-entry ?@ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?$ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?_ "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?! "w" enh-ruby-mode-syntax-table)
(modify-syntax-entry ?? "w" enh-ruby-mode-syntax-table)

;; Some extra keys
(evil-define-key 'normal enh-ruby-mode-map
  "J" (lambda () (interactive) (sp-ruby-delete-indentation -1)))

(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:"
                       (getenv "PATH")))

(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons (concat (getenv "HOME") "/.rbenv/bin")
                            exec-path)))

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
              (require 'rspec-mode)
              (require 'rcodetools)
              (flycheck-mode +1)
              (flycheck-disable-checker 'ruby-reek)
              (rspec-mode +1)))

(provide 'init-enh-ruby-mode)
