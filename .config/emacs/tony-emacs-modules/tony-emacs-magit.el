;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                MAGIT               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; remove last unmerged commit (set as unstaged change)
;; (magit-reset-soft "HEAD~1"))

;; (use-package compat
;;   :defer t
;;   :ensure (compat :type git :host github :repo "emacs-compat/compat"))

(use-package
 transient
 :defer t
 :ensure (transient :type git :host github :repo "magit/transient")
 :config

 (transient-define-prefix
  hrm-help-transient () "Help commands."
  ["Help Commands" ["Mode & Bindings"
    ("m" "Mode" describe-mode)
    ("M" "Minor Modes" consult-minor-mode-menu)
    ("b" "Major Bindings" which-key-show-full-major-mode)
    ("B" "Minor Bindings" which-key-show-full-minor-mode-keymap)
    ("d" "Descbinds" describe-bindings) ; or embark-bindings
    ("t" "Top Bindings  " which-key-show-top-level)]
   ["Describe"
    ("C" "Command" helpful-command)
    ("f" "Function" helpful-callable)
    ("v" "Variable " helpful-variable)
    ("k" "Key" helpful-key)
    ("s" "Symbol" helpful-symbol)
    ("l" "Library" apropos-library)]
   ["Info on"
    ("C-c" "Command" Info-goto-emacs-command-node)
    ("C-f" "Function" info-lookup-symbol)
    ("C-v" "Variable" info-lookup-symbol) ; fails if transient-detect-key-conflicts
    ("C-k" "Key" Info-goto-emacs-key-command-node)
    ("C-s" "Symbol" info-lookup-symbol)]
   ["Goto Source"
    ""
    ("F" "Function" find-function-other-frame)
    ("V" "Variable" find-variable-other-frame)
    ("K" "Key" find-function-on-key-other-frame)
    ""
    ("L" "Library" find-library-other-frame)]
   ["Apropos"
    ("ac" "Command" apropos-command)
    ("af" "Function" apropos-function)
    ("av" "Variable" apropos-variable)
    ("aV" "Value" apropos-value)
    ("aL" "Local Value" apropos-local-value)
    ("ad" "Documentation" apropos-documentation)]]
  [["Internals"
    ("I" "Input Method" describe-input-method)
    ("G" "Language Env" describe-language-environment)
    ("S" "Syntax" describe-syntax)
    ("T" "Categories" describe-categories)
    ("O" "Coding System" describe-coding-system)
    ("o" "Coding Briefly" describe-current-coding-system-briefly)
    ("T" "Display Table" describe-current-display-table)
    ("e" "Echo Messages" view-echo-area-messages)
    ("H" "Lossage" view-lossage)]
   ["Describe"
    ("." "At Point" helpful-at-point)
    ("c" "Key Short" describe-key-briefly)
    ("p" "Key Map" describe-keymap)
    ("A" "Face" describe-face)
    ("i" "Icon" describe-icon)
    ("w" "Where Is" where-is)
    ("=" "Position" what-cursor-position)
    ("g" "Shortdoc" shortdoc-display-group)]
   ["Info Manuals"
    ("C-i" "Info" info)
    ("C-4" "Other Window" info-other-window)
    ("C-e" "Emacs" info-emacs-manual)
    ;; ("C-l" "Elisp" info-elisp-manual)
    ("C-r" "Pick Manual" info-display-manual)]
   ["External" ("N" "Man" consult-man)
    ;; ("W" "Dictionary" lookup-word-at-point)
    ;; ("D" "Dash" dash-at-point)
    ]])
 (global-set-key (kbd "C-S-h") 'hrm-help-transient))

(use-package
 magit
 ;; fixes emacs 29 issue with old transient package (dependency)
 ;; :ensure (:tag "v3.3.0")
 ;; :after compat
 :after transient
 :defer t
 :config
 ;; ;; updates modeline with branch. higher cost than hook
 ;; (setq auto-revert-check-vc-info t
 ;;       auto-revert-interval 10)

 ;; show  all options in transient
 (setq transient-default-level 7)

 ;; full screen magit
 (setq magit-display-buffer-function
       #'magit-display-buffer-fullframe-status-v1)
 (setq magit-remote-add-set-remote.pushDefault nil)
 (setopt magit-format-file-function
         #'magit-format-file-all-the-icons)) ;; for v4.3.0+

(use-package
 magit-blame-color-by-age
 :ensure
 (magit-blame-color-by-age
  :type git
  :host github
  :repo "jdtsmith/magit-blame-color-by-age")
 :after magit
 :config (magit-blame-color-by-age-mode))

;; (defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
;;   (setq ad-return-value
;; 	(concat ad-return-value
;; 		(let ((plus-minus (vc-git--run-command-string
;; 				   file "diff" "--numstat" "--")))
;; 		  (and plus-minus
;; 		       (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
;; 		       (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))

(provide 'tony-emacs-magit)
