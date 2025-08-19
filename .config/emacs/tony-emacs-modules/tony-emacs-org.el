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

(provide 'tony-emacs-org)
