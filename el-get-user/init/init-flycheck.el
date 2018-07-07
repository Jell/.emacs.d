;;; package --- Summary
;;; Commentary:
;;; Code:
(require 'flycheck)

(flycheck-define-checker sh-shellcheck
  "A shell script syntax and style checker using Shellcheck.

See URL `https://github.com/koalaman/shellcheck/'."
  :command ("shellcheck" "-f" "checkstyle"
            "-s" (eval (symbol-name sh-shell))
            source)
  :modes sh-mode
  :error-parser flycheck-parse-checkstyle)

(add-to-list 'flycheck-checkers 'sh-shellcheck 'append)

(global-flycheck-mode)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
