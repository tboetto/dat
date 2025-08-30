(use-package lsp-biome
  :ensure (:host github :repo "cxa/lsp-biome")
  :config
  (setq lsp-biome-organize-imports-on-save nil)
  (setq lsp-biome-autofix-on-save nil)
  (setq lsp-biome-format-on-save nil)
  )
(provide 'tony-emacs-lsp-biome)
