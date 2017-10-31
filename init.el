;; (package-initialize) ; Skip before elget

(add-to-list 'load-path "~/.emacs.d/lisp")
;; (server-start)

(let ((file-name-handler-alist nil)) ; speedup library loading

  (require 'sanity)
  (require 'compatibility)
  (require 'setup-paths)
  (require 'setup-scratch-message)
  (require 'setup-backup)
  (require 'setup-elget)
  (require 'setup-packages)
  (require 'setup-helpers)
  (require 'setup-keys)
  (require 'setup-hippie-expand)
  (require 'setup-mode-line)
  (require 'setup-auto-revert)
  ;; (require 'sublimify)
  ;; (require 'emacsify)
  ;; (require 'movelines)
  (require 'setup-mail))
