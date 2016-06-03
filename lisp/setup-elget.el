(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; Extra package repos
(setq package-archives '())
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; TODO: create el-get-user/recipes and el-get-user/init
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(setq-default el-get-user-package-directory "~/.emacs.d/el-get-user/init")

(provide 'setup-elget)
