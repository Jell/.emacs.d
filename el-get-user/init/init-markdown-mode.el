(defun load-markdown-mode ()
  (require 'markdown-mode)
  (markdown-mode))

(add-to-list 'auto-mode-alist
             '("\\.md\\'" . load-markdown-mode))
