(require 'rubocop)

(defun rubocop-bundled-p ()
  "REPLACED! Check if RuboCop has been bundled."
  nil)

(add-hook 'ruby-mode-hook #'rubocop-mode)
