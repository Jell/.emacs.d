(defun ruby-set-enh-ruby-program ()
  (let ((rvm-path (shell-command-to-string "which rvm"))
        (rbenv-path (shell-command-to-string "which rbenv")))
    (when (> (length rvm-path) 0)
      (let* ((rvm-path (replace-regexp-in-string "\n$" "" rvm-path))
             (rubies (file-expand-wildcards
                      (concat rvm-path "/../../rubies/ruby-1.9*")))
             (ruby-root (expand-file-name (first (last rubies)))))
        (setq enh-ruby-program (concat ruby-root "/bin/ruby"))))
    (when (> (length rbenv-path) 0)
      (let* ((rubies (file-expand-wildcards "~/.rbenv/versions/1.9*"))
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

(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:"
                       (getenv "PATH")))

(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons (concat (getenv "HOME") "/.rbenv/bin")
                            exec-path)))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (require 'ruby-mode)
             (require 'ruby-compilation)
             (require 'rspec-mode)
             (require 'rcodetools)
             (rspec-mode +1)
             (rvm-autodetect-ruby)))
