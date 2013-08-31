(require 'auto-complete)
(add-to-list 'ac-dictionary-directories
             (expand-file-name "dict"))
(require 'auto-complete-config)
(ac-config-default)
