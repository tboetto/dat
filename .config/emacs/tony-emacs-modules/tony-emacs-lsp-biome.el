(use-package lsp-biome
  :after apheleia
  :ensure (:host github :repo "cxa/lsp-biome")
  :config
  (setq lsp-biome-organize-imports-on-save nil)
  (setq lsp-biome-autofix-on-save nil)
  (setq lsp-biome-format-on-save nil)
  (defun lsp-biome--activate-p (filename &optional _)
"Check if biome language server can/should start with FILENAME."
(when-let* ((roots (lsp-biome--workspace-roots))
            (bin (lsp-biome--find-biome-bin roots))
            (_ (lsp-biome--has-config-p roots))
            (_ (lsp-biome--file-can-be-activated filename)))
  (setq-local lsp-biome--bin-path bin)t))
  )
(provide 'tony-emacs-lsp-biome)
