(require 'ruby-mode)
(require 'ruby-compilation)
(require 'rspec-mode)
(require 'rcodetools)
(rvm-activate-corresponding-ruby)
(rinari-launch)
(electric-pair-mode)
(setq enh-ruby-program "/Users/Jell/.rvm/rubies/ruby-1.9.3-p194/bin/ruby")
(define-key rspec-mode-verifible-keymap (kbd "s") 'rspec-verify-single)

;; Fix word limits
(modify-syntax-entry ?_ "w" ruby-mode-syntax-table)
(modify-syntax-entry ?! "w" ruby-mode-syntax-table)
(modify-syntax-entry ?? "w" ruby-mode-syntax-table)
