(use-package
 denote
 :ensure t
 :config
 (setq denote-directory (expand-file-name "~/Documents/org/denote"))
 (setq denote-known-keywords
       '("emacs"
         "org mode"
         "denote"
         "game dev"
         "godot"
         "C"
         "lisp"
         "typescript"
         "javascript"
         "angular"
         "ngrx"
         "hand tools"
         "power tools"
         "offroading"
         "preparedness")))

(provide 'tony-emacs-denote)
