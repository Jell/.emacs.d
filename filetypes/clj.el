
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Allow input to be sent to somewhere other than inferior-lisp
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This is a total hack: we're hardcoding the name of the shell buffer
(defun shell-send-input (input)
  "Send INPUT into the *shell* buffer and leave it visible."
  (send-input-to-buffer "*shell*" input))

(defun send-input-to-buffer (buffer input)
  "Send INPUT to the given BUFFER"
  (save-selected-window
    (switch-to-buffer-other-window buffer)
    (goto-char (point-max))
    (insert input)
    (comint-send-input)))

(defun defun-at-point ()
  "Return the text of the defun at point."
  (apply #'buffer-substring-no-properties
         (region-for-defun-at-point)))

(defun region-for-defun-at-point ()
  "Return the start and end position of defun at point."
  (save-excursion
    (save-match-data
      (end-of-defun)
      (let ((end (point)))
        (beginning-of-defun)
        (list (point) end)))))

(defun expression-preceding-point ()
  "Return the expression preceding point as a string."
  (buffer-substring-no-properties
   (save-excursion (backward-sexp) (point))
   (point)))

(defun shell-eval-last-expression ()
  "Send the expression preceding point to the *shell* buffer."
  (interactive)
  (shell-send-input (expression-preceding-point)))

(defun shell-eval-defun ()
  "Send the current toplevel expression to the *shell* buffer."
  (interactive)
  (shell-send-input (defun-at-point)))

(add-hook 'clojure-mode-hook
          '(progn
             (define-key clojure-mode-map (kbd "C-c e") 'shell-eval-last-expression)
             (define-key clojure-mode-map (kbd "C-c x") 'shell-eval-defun)))

(defun start-clj-cljs-repls (path)
  "Starts a Clojure and a ClojureScript REPL"
  (interactive (list (read-directory-name "Path to root directory: ")))
  ;; Start server REPL
  (shell)
  (switch-to-prev-buffer)
  (sleep-for 1)
  (shell-send-input (format "cd %s" path))
  (sleep-for 1)
  (shell-send-input "script/repl")
  ;; Start cljs REPL
  (inferior-lisp (format "%s/script/repl" path))
  (switch-to-prev-buffer))

(defun launch-cljs-one-server ()
  "Start a ClojureScript One interactive REPL"
  (interactive)
  (shell-send-input "(use 'one.sample.dev-server)(run-server)")
  (send-input-to-buffer "*inferior-lisp*" "(use 'one.sample.dev-server)(cljs-repl)"))
