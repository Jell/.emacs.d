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
(require 'flycheck)

(let ((govet (flycheck-checker-get 'go-vet 'command)))
  (when (equal (cadr govet) "tool")
    (setf (cdr govet) (cddr govet))))

(add-hook 'go-mode-hook 'lsp-deferred)

(provide 'init-go-mode)
