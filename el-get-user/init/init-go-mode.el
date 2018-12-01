;; install deps:
;; go get -u github.com/dougm/goflymake
;; go get -u github.com/nsf/gocode

(add-to-list 'load-path "~/go/src/github.com/nsf/gocode/emacs/")

(defun --go-mode-setup ()
  (require 'go-autocomplete)
  (require 'auto-complete-config)
  (ac-config-default))

(add-hook 'before-save-hook #'gofmt-before-save)
(add-hook 'go-mode-hook 'flycheck-mode)
(add-hook 'go-mode-hook #'--go-mode-setup)
(add-hook 'go-mode-hook 'go-eldoc-setup)

(provide 'init-go-mode)
