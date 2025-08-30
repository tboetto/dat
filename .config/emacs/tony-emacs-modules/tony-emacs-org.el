(use-package org
  :ensure nil
  :init
  (setq org-directory (expand-file-name "~/Documents/org/"))
  (setq org-imenu-depth 7)
  :config
  (setq org-startup-indented t)
  )

(use-package org-agenda
  :ensure nil
  :config
  (setq org-agenda-files (list org-directory)))

(use-package org-modern
  :ensure t
  :hook
  (org-mode . org-modern-mode)
  )

(use-package org-appear
  :ensure t
  :hook
  (org-mode . org-appear-mode))

(provide 'tony-emacs-org)
