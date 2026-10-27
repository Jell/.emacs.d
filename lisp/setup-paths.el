;;; setup-paths.el --- -*- lexical-binding: t; -*-
(add-to-list 'load-path "~/.emacs.d/filetypes")
(add-to-list 'load-path "~/.emacs.d/other")

;; Extra bin folders
(add-to-list 'exec-path "/opt/homebrew/bin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path "./bundle/bin")
(add-to-list 'exec-path "/Library/TeX/texbin/")
(add-to-list 'exec-path "~/go/bin")
(add-to-list 'exec-path "/bin")

;; Path to binary files
(setq-default ispell-program-name "/usr/local/bin/aspell")

(setq shell-file-name "/bin/bash")

(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell
         (substring
          (shell-command-to-string "$SHELL -i -c 'echo $PATH'")
          0 -1)))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(set-exec-path-from-shell-PATH)

;; (setenv "PYTHONPATH" "/usr/local/lib/python2.7/site-packages")
(setenv "DOTNET_ROOT" "/opt/homebrew/opt/dotnet/libexec")

;; The daemon is started by launchd without a locale, which makes pbcopy
;; (used by xclip-mode) read UTF-8 as Mac Roman: öäå -> √∂√§√•
(unless (getenv "LANG")
  (setenv "LANG" "en_US.UTF-8"))


(provide 'setup-paths)
