(require 'cider)
(add-hook 'cider-mode-hook #'paredit-mode)
(add-hook 'cider-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'cider-mode-hook #'cider-turn-on-eldoc-mode)

;; (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook #'paredit-mode)
(add-hook 'cider-repl-mode-hook #'rainbow-delimiters-mode)

;; (add-hook 'clojure-mode-hook 'cider-mode)

(modify-syntax-entry ?/ "w" clojure-mode-syntax-table)

;; Indentation for compojure
(define-clojure-indent
  (register-sub 1)
  (start 'defun)
  (stop 'defun)
  (ns 'defun)
  (run 'defun)
  (when-dev 0)
  (modify-if 1)
  (fresh 'defun)
  (defprotocol 'defun)
  (defrecord 'defun)
  (deftype 'defun)
  (defroutes 'defun)
  (describe 'defun)
  (around 'defun)
  (for-all 'defun)
  (for-all* 'defun)
  (clone-for 'defun)
  (reset! 'defun)
  (join 'defun)
  (swap! 'defun)
  (update-in 'defun)
  (describe 'defun)
  (context 'defun)
  (it 'defun)
  (at 'defun)
  (listen 'defun)
  (from 'defun)
  (up 'defun)
  (down 'defun)
  (match 'defun)
  (ann 'defun)
  (ann-protocol 'defun)
  (All 'defun)
  (GET 2)
  (POST 2)
  (PUT 2)
  (DELETE 2)
  (HEAD 2)
  (ANY 2))

(defun cljs-tests-run-ns-tests ()
  (interactive)
  (cider-interactive-eval
   (concat "(cljs.test/run-tests '" (cider-current-ns) ")")))

(defun cljs-tests-run-all-tests ()
  (interactive)
  (cider-interactive-eval
   (concat "(cljs.test/run-all-tests)")))

(defun cljs-tests-run-single-test ()
  (interactive)
  (cider-interactive-eval (concat "(cljs.test.repl/run-single-test #'"
                                  (cider-current-ns)
                                  "/"
                                  (symbol-name (symbol-at-point)) ")")))

(define-key clojurescript-mode-map [remap cider-test-run-ns-tests] 'cljs-tests-run-ns-tests)
(define-key clojurescript-mode-map (kbd "C-c , s") 'cljs-tests-run-single-test)
(define-key clojurescript-mode-map (kbd "C-c , v") 'cljs-tests-run-ns-tests)
(define-key clojurescript-mode-map (kbd "C-c , a") 'cljs-tests-run-all-tests)

(provide 'init-cider)
