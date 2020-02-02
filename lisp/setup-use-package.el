(require 'package)
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(unless package-archive-contents
  (package-refresh-contents))

(unless (require 'use-package nil 'noerror)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (require 'quelpa nil 'noerror)
  (package-refresh-contents)
  (package-install 'quelpa))

(unless (require 'quelpa-use-package nil 'noerror)
  (package-refresh-contents)
  (package-install 'quelpa-use-package))

(require 'quelpa-use-package)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(provide 'setup-use-package)
