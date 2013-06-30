(defun ruby-set-enh-ruby-program ()
  (with-temp-buffer
    (when (shell-command "which rvm" (current-buffer))
      (let* ((rvm-path (replace-regexp-in-string "\n$" "" (buffer-string)))
             (rubies (file-expand-wildcards (concat rvm-path "/../../rubies/ruby-1.9*")))
             (ruby-root (expand-file-name (first (last rubies)))))
        (setq enh-ruby-program (concat ruby-root "/bin/ruby"))))))

(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.arb\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.builder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))

;; Set proper path to ruby
(ruby-set-enh-ruby-program)

;; Fix word limits
(modify-syntax-entry ?@ "w" ruby-mode-syntax-table)
(modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
(modify-syntax-entry ?! "w" ruby-mode-syntax-table)
(modify-syntax-entry ?? "w" ruby-mode-syntax-table)

;; Some extra keys
(evil-define-key 'normal ruby-mode-map
  "J" (lambda () (interactive) (sp-ruby-delete-indentation -1)))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (require 'ruby-mode)
             (require 'ruby-compilation)
             (require 'rspec-mode)
             (require 'rcodetools)
             (require 'ruby-tools)
             (ruby-tools-mode +1)
             (rvm-autodetect-ruby)))

(provide 'rb)
