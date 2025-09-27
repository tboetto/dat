(use-package
 org
 :ensure nil
 :init
 (setopt org-confirm-babel-evaluate nil)
 (setq org-directory (expand-file-name "~/Documents/org/"))
 (setq org-imenu-depth 7)
 :config
 (setq org-startup-indented t)
 (add-to-list 'org-src-lang-modes '("typescript" . typescript-ts))
 )

(use-package
 org-agenda
 :ensure nil
 :config (setq org-agenda-files (list org-directory)))

(use-package
 org-modern
 :ensure t
 :hook (org-mode . org-modern-mode)
 :config
 (setq
  org-modern-keyword nil
  org-modern-block-name nil))

(use-package org-modern-indent
  :ensure (:host github :repo "jdtsmith/org-modern-indent")
  :hook
  (org-mode . org-modern-indent-mode))

(use-package org-appear :ensure t :hook (org-mode . org-appear-mode))
(setq org-appear-trigger 'always)

(use-package ob-racket
  :ensure (:host github :repo "hasu/emacs-ob-racket"))

(provide 'tony-emacs-org)
