;; install deps:
;; go get -u github.com/nsf/gocode

;; (add-to-list 'load-path "~/go/src/github.com/nsf/gocode/emacs/")

;; (defun --go-mode-setup ()
;;   (require 'go-autocomplete)
;;   (require 'auto-complete-config)
;;   (ac-config-default))

;; (add-hook 'before-save-hook #'gofmt-before-save)
;; (add-hook 'go-mode-hook 'flycheck-mode)
;; (add-hook 'go-mode-hook #'--go-mode-setup)
;; (add-hook 'go-mode-hook 'go-eldoc-setup)

(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))

(add-hook 'go-mode-hook 'lsp-deferred)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
(add-hook 'go-mode-hook #'yas-minor-mode-on)

(defun go-mode-require-dap-mode ()
  (require 'dap-go)
  (dap-ui-mode))
(add-hook 'go-mode-hook #'go-mode-require-dap-mode)

(provide 'init-go-mode)
