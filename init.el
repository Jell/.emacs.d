;;; init --- Summary
;;; Commentary:
;;; Code:

(add-to-list 'load-path "~/.emacs.d/lisp")

(let ((file-name-handler-alist nil) ; speedup library loading
      (gc-cons-threshold most-positive-fixnum)) ; ditto

  (require 'sanity)
  (require 'compatibility)
  (require 'setup-paths)
  (require 'setup-scratch-message)
  (require 'setup-backup)
  (require 'setup-use-package)
  (require 'setup-packages)
  (require 'setup-helpers)
  (require 'setup-keys)
  (require 'setup-hippie-expand)
  (require 'setup-mode-line)
  (require 'setup-auto-revert)
  (require 'setup-mail))


(provide 'init)
;;; init.el ends here
(put 'downcase-region 'disabled nil)
