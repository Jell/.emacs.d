(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(add-to-list 'load-path "~/.emacs.d/filetypes")
(add-to-list 'load-path "~/.emacs.d/other")
(add-to-list 'load-path "~/.emacs.d/init")

;; Extra bin folders
(add-to-list 'exec-path "/usr/local/bin")

;; Path to binary files
(setq-default ispell-program-name "/usr/local/bin/aspell")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(if window-system (set-exec-path-from-shell-PATH))

(provide 'setup-paths)
