(use-package lsp-biome
  :ensure (:host github :repo "cxa/lsp-biome")
  :config
  (setq lsp-biome-organize-imports-on-save t)
  (setq lsp-biome-autofix-on-save t)
  (setq lsp-biome-format-on-save t)
  ;;(setq lsp-biome-active-file-types (list (rx "." (or "tsx" "jsx"
  ;;                "ts" "js"
  ;;                "mts" "mjs"
  ;;                "cts" "cjs"
  ;;                "json" "jsonc")
  ;;        eos)))
    )
(provide 'tony-emacs-lsp-biome)
