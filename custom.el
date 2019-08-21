;; Custom variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-show-compilation nil)
 '(ac-ignore-case nil)
 '(ac-modes
   (quote
    (enh-ruby-mode emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode go-mode java-mode malabar-mode scala-mode scheme-mode ocaml-mode tuareg-mode coq-mode haskell-mode agda-mode agda2-mode perl-mode cperl-mode python-mode ruby-mode lua-mode tcl-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode less-css-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode web-mode ts-mode sclang-mode verilog-mode qml-mode)))
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auth-source-save-behavior nil)
 '(auto-revert-interval 1)
 '(auto-revert-verbose nil)
 '(blink-cursor-alist nil)
 '(blink-cursor-mode t)
 '(cider-cljs-lein-repl "")
 '(cider-prefer-local-resources nil)
 '(css-indent-level 2)
 '(css-indent-offset 2)
 '(cua-enable-cua-keys nil)
 '(custom-enabled-themes (quote (jell)))
 '(custom-safe-themes
   (quote
    ("d5c3970a91cc243499e73df5939e52d3762c351e937465978c1bf3ec402eada6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "b0950b032aa3c8faab4864ae288296dd66b92eca" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "baed08a10ff9393ce578c3ea3e8fd4f8c86e595463a882c55f3bd617df7e5a45" "374e79a81930979e673b8e0869e135fb2450b18c6474ca145f104e0c6f003267" "54d1bcf3fcf758af4812f98eb53b5d767f897442753e1aa468cfeb221f8734f9" default)))
 '(delete-selection-mode t)
 '(dired-listing-switches "-al")
 '(dired-use-ls-dired (quote unspecified))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(el-get-allow-insecure t)
 '(enh-ruby-bounce-deep-indent nil)
 '(enh-ruby-check-syntax (quote errors-and-warnings))
 '(enh-ruby-deep-arglist nil)
 '(enh-ruby-deep-indent-paren nil)
 '(enh-ruby-deep-indent-paren-style (quote space))
 '(enh-ruby-end-check-statement-modifiers nil)
 '(enh-ruby-end-insert-newline nil)
 '(enh-ruby-extra-keywords
   (quote
    ("require" "private" "alias" "include" "extend" "protected" "public" "raise")))
 '(enh-ruby-hanging-indent-level 2)
 '(enh-ruby-program "/usr/bin/ruby")
 '(erc-autojoin-channels-alist (quote (("freenode.net" "#got.clj" "#ruby" "#emacs"))))
 '(erc-autojoin-delay 30)
 '(erc-email-userid "jean-louis@jawaninja.com")
 '(erc-nick "jean-louis")
 '(erc-port 6667)
 '(erc-server "irc.freenode.net")
 '(evil-bigword "^ \\t\\r\\n_
")
 '(evil-default-state (quote normal))
 '(evil-emacs-state-modes
   (quote
    (archive-mode bbdb-mode bookmark-bmenu-mode bookmark-edit-annotation-mode browse-kill-ring-mode bzr-annotate-mode calc-mode cfw:calendar-mode completion-list-mode Custom-mode debugger-mode delicious-search-mode desktop-menu-blist-mode desktop-menu-mode doc-view-mode dvc-bookmarks-mode dvc-diff-mode dvc-info-buffer-mode dvc-log-buffer-mode dvc-revlist-mode dvc-revlog-mode dvc-status-mode dvc-tips-mode ediff-mode efs-mode Electric-buffer-menu-mode emms-browser-mode emms-mark-mode emms-metaplaylist-mode emms-playlist-mode etags-select-mode fj-mode gc-issues-mode gdb-breakpoints-mode gdb-disassembly-mode gdb-frames-mode gdb-locals-mode gdb-memory-mode gdb-registers-mode gdb-threads-mode gist-list-mode gnus-article-mode gnus-browse-mode gnus-group-mode gnus-server-mode gnus-summary-mode google-maps-static-mode ibuffer-mode jde-javadoc-checker-report-mode magit-commit-mode magit-diff-mode magit-key-mode magit-log-mode magit-mode magit-reflog-mode magit-show-branches-mode magit-stash-mode magit-status-mode magit-wazzup-mode mh-folder-mode monky-mode notmuch-hello-mode notmuch-search-mode notmuch-show-mode occur-mode org-agenda-mode package-menu-mode proced-mode rcirc-mode rebase-mode recentf-dialog-mode reftex-select-bib-mode reftex-toc-mode sldb-mode slime-inspector-mode slime-thread-control-mode slime-xref-mode sr-buttons-mode sr-mode sr-tree-mode sr-virtual-mode tar-mode tetris-mode tla-annotate-mode tla-archive-list-mode tla-bconfig-mode tla-bookmarks-mode tla-branch-list-mode tla-browse-mode tla-category-list-mode tla-changelog-mode tla-follow-symlinks-mode tla-inventory-file-mode tla-inventory-mode tla-lint-mode tla-logs-mode tla-revision-list-mode tla-revlog-mode tla-tree-lint-mode tla-version-list-mode twittering-mode urlview-mode vc-annotate-mode vc-dir-mode vc-git-log-view-mode vc-svn-log-view-mode vm-mode vm-summary-mode w3m-mode wab-compilation-mode xgit-annotate-mode xgit-changelog-mode xgit-diff-mode xgit-revlog-mode xhg-annotate-mode xhg-log-mode xhg-mode xhg-mq-mode xhg-mq-sub-mode xhg-status-extra-mode magit-branch-manager-mode pivotal-mode epa-key-list-mode git-rebase-mode idris-compiler-notes-mode cider-stacktrace-mode cider-test-report-mode cider-docview-mode magit-popup-mode magit-refs-mode magit-revision-mode magit-popup-sequence-mode magit-log-select-mode skewer-error-mode sql-interactive-mode)))
 '(evil-leader/leader ",")
 '(ffap-machine-p-known (quote reject))
 '(fiplr-ignored-globs
   (quote
    ((directories
      (".git" ".svn" ".hg" ".bzr" "assets_production" "assets_sandbox"))
     (files
      (".#*" "*~" "*.so" "*.jpg" "*.png" "*.gif" "*.pdf" "*.gz" "*.zip" "*.jar")))))
 '(fiplr-root-markers (quote (".git" ".svn" ".hg" ".bzr" ".rspec")))
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(git-commit-finish-query-functions nil)
 '(global-auto-complete-mode t)
 '(global-auto-revert-mode t)
 '(global-auto-revert-non-file-buffers t)
 '(global-hl-line-mode t)
 '(graphviz-dot-auto-preview-on-save t)
 '(graphviz-dot-preview-extension "png")
 '(gud-tooltip-echo-area nil)
 '(guide-key/guide-key-sequence (quote ("C-x" "C-c")))
 '(guide-key/popup-window-position (quote bottom))
 '(guide-key/recursive-key-sequence-flag t)
 '(haskell-font-lock-symbols nil)
 '(haskell-process-type (quote cabal-repl))
 '(haskell-program-name "cabal repl")
 '(hl-line-sticky-flag nil)
 '(ido-auto-merge-delay-time 10)
 '(idris-interpreter-flags nil)
 '(idris-interpreter-path "/usr/local/bin/idris")
 '(idris-metavariable-list-show-expanded nil)
 '(idris-metavariable-show-on-load nil)
 '(imagex-auto-adjust-mode nil)
 '(imagex-global-sticky-mode nil)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(inf-ruby-default-implementation "pry")
 '(intero-package-version "0.1.34")
 '(js-indent-level 2)
 '(kill-whole-line t)
 '(latex-run-command "xelatex")
 '(magit-default-tracking-name-function (quote magit-default-tracking-name-branch-only))
 '(magit-diff-options (quote ("--patience")))
 '(magit-diff-refine-hunk t)
 '(magit-merge-arguments (quote ("--no-ff")))
 '(magit-push-arguments (quote ("--set-upstream")))
 '(magit-set-upstream-on-push (quote askifnotset))
 '(magit-visit-ref-behavior
   (quote
    (focus-on-ref create-branch checkout-any checkout-branch)))
 '(mouse-yank-at-point t)
 '(nrepl-force-ssh-for-remote-hosts nil)
 '(nyan-animation-frame-interval 0.1)
 '(nyan-bar-length 20)
 '(nyan-mode t)
 '(nyan-wavy-trail nil)
 '(org-babel-load-languages
   (quote
    ((emacs-lisp . t)
     (haskell . t)
     (clojure . t)
     (python . t))))
 '(org-image-actual-width 100)
 '(org-src-fontify-natively t)
 '(org-startup-with-inline-images nil)
 '(org-startup-with-latex-preview nil)
 '(package-selected-packages
   (quote
    (clojure-mode sesman flycheck psc-ide pci-ide haskell-mode ido-completing-read+ queue impatient-mode jade travis org-trello clj-refactor)))
 '(pr-gv-command "open")
 '(psc-ide-rebuild-on-save nil)
 '(require-final-newline (quote ask))
 '(rspec-command-options "")
 '(rspec-compilation-buffer-name "*RSPEC*")
 '(rspec-spec-command "rspec_docker --color --fail-fast")
 '(rspec-use-bundler-when-possible nil)
 '(rspec-use-opts-file-when-available t)
 '(rspec-use-rake-flag nil)
 '(rspec-use-rake-when-possible nil)
 '(rspec-use-rvm nil)
 '(safe-local-variable-values
   (quote
    ((cider-cljs-lein-repl . "(do (dev) (go) (cljs-repl))")
     (cider-refresh-after-fn . "reloaded.repl/resume")
     (cider-refresh-before-fn . "reloaded.repl/suspend"))))
 '(scroll-bar-mode nil)
 '(scroll-conservatively 100000000)
 '(scroll-margin 3)
 '(scroll-preserve-screen-position nil)
 '(scroll-step 0)
 '(send-mail-function (quote smtpmail-send-it))
 '(sh-basic-offset 2)
 '(sh-indentation 2)
 '(shift-select-mode t)
 '(show-paren-mode t)
 '(smooth-scroll-mode t)
 '(smooth-scroll/vscroll-step-size 3)
 '(sp-autoescape-string-quote nil)
 '(sp-navigate-consider-symbols t)
 '(speedbar-default-position (quote left))
 '(speedbar-frame-parameters
   (quote
    ((minibuffer)
     (width . 30)
     (border-width . 0)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 0))))
 '(speedbar-frame-plist
   (quote
    (minibuffer nil width 30 border-width 0 internal-border-width 0 unsplittable t default-toolbar-visible-p t has-modeline-p t menubar-visible-p t default-gutter-visible-p nil)))
 '(speedbar-show-unknown-files t)
 '(speedbar-supported-extension-expressions
   (quote
    (".[ch]\\(\\+\\+\\|pp\\|c\\|h\\|xx\\)?" ".tex\\(i\\(nfo\\)?\\)?" ".el" ".emacs" ".l" ".lsp" ".p" ".java" ".js" ".f\\(90\\|77\\|or\\)?" ".ad[abs]" ".p[lm]" ".tcl" ".m" ".scm" ".pm" ".py" ".g" ".s?html" ".ma?k" "[Mm]akefile\\(\\.in\\)?" ".clj")))
 '(tags-compression-info-list (quote ("" ".Z" ".bz2" ".gz" ".xz" ".tgz" ".zip")))
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(tooltip-short-delay 0)
 '(tooltip-use-echo-area t)
 '(transient-mark-mode (quote (only . t)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(visible-cursor t)
 '(web-mode-code-indent-offset 2)
 '(web-mode-markup-indent-offset 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(diff-refine-added ((t (:inherit diff-refine-change :background "#118811"))))
 '(idris-identifier-face ((t nil)))
 '(idris-loaded-region-face ((t (:background "#001500"))) t)
 '(idris-prover-processed-face ((t (:background "#003000"))))
 '(idris-prover-processing-face ((t (:background "DarkGoldenrod4"))))
 '(idris-semantic-bound-face ((t (:foreground "MediumOrchid1"))))
 '(idris-semantic-data-face ((t (:foreground "coral1"))))
 '(idris-semantic-function-face ((t (:foreground "light green"))))
 '(idris-semantic-type-face ((t (:foreground "dodger blue" :weight extra-bold))))
 '(magit-diff-context-highlight ((t (:background "grey12" :foreground "grey70"))))
 '(magit-section-highlight ((t (:background "gray12")))))
