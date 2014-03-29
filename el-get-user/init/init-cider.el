(require 'cider)
(require 'popup)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)


(modify-syntax-entry ?/ "w" clojure-mode-syntax-table)

;; Indentation for compojure
(define-clojure-indent
  (run 'defun)
  (fresh 'defun)
  (defprotocol 'defun)
  (defrecord 'defun)
  (deftype 'defun)
  (defroutes 'defun)
  (describe 'defun)
  (it 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2)
  (context 2))

(add-hook 'cider-mode-hook 'enable-paredit-mode)

(provide 'init-cider)
