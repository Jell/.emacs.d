(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/el-get-init")
(add-to-list 'load-path "~/.emacs.d/filetypes")
(add-to-list 'load-path "~/.emacs.d/other")

;; Extra bin folders
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "./bundle/bin")

;; Path to binary files
(setq-default ispell-program-name "/usr/local/bin/aspell")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
         (substring
          (shell-command-to-string "$SHELL -i -c 'echo $PATH'")
          0 -1)))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

(setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")

(provide 'setup-paths)
