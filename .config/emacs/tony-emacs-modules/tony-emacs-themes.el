(setopt custom-theme-directory "~/.config/emacs/themes/")

(setq custom-safe-themes t)

(defun my-clear-theme ()
  "Clear current theme"
  (interactive)
  (mapc #'disable-theme custom-enabled-themes))

(defun my-load-theme (&optional theme)
  "Load THEME after clearing the previous one.
If called interactively, prompt for a theme name. If THEME is provided
as an argument, load that theme directly."
  (interactive)
  (my-clear-theme)
  (if theme
      (load-theme theme t)
    (call-interactively 'load-theme)))

;; (setq my-catppuccin-flavors (my-alist-keys catppuccin-flavor-alist))

;; (defun my-catppuccin-theme (flavor)
;;   "Clear previous theme and load selected catppuccin FLAVOR."
;;   (interactive
;;    (list (intern (completing-read "Choose a flavor: "
;;                                   my-catppuccin-flavors))))
;;   (my-clear-theme)
;;   (catppuccin-load-flavor flavor))

(defun my-load-theme-in-all-frames (frame)
  "Load the current theme in the newly created FRAME.
When loaded after a new frame has been created with emacsclient, it
ensures that the theme is properly applied. In particular this solves a
problem with the menu bar not using the proper theme if the server was
loaded with a different theme."
  (with-selected-frame frame
    (enable-theme (car custom-enabled-themes))
    (when (string-prefix-p "ef-" (symbol-name (car custom-enabled-themes)))
      (ef-themes-load-theme (car custom-enabled-themes)))
    (when (string-prefix-p "modus-" (symbol-name (car custom-enabled-themes)))
      (modus-themes-load-theme (car custom-enabled-themes)))))

(add-hook 'after-make-frame-functions #'my-load-theme-in-all-frames)

(use-package modus-themes
  :ensure t
  :init
  (setopt modus-themes-mixed-fonts nil
          modus-themes-variable-pitch-ui nil
          modus-themes-bold-constructs t
          modus-themes-italic-constructs t
          modus-themes-to-toggle '(modus-operandi modus-vivendi)

          modus-themes-common-palette-overrides
          '((fringe unspecified)
            (bg-paren-match bg-magenta-intense)
            (fg-heading-1 blue-warmer)
            (fg-heading-2 yellow-cooler)
            (fg-heading-3 cyan-cooler)
            (bg-prose-block-delimiter bg-mode-line-inactive))

          modus-themes-headings '((0 . (1.5))
                                  (1 . (1.4))
                                  (2 . (1.3))
                                  (3 . (1.2))
                                  (4 . (1.1))
                                  (5 . (1.1))
                                  (6 . (1.0))
                                  (7 . (1.0)))))

(use-package ef-themes
  :ensure t
  :init
  (setopt ef-themes-to-toggle '(ef-light ef-dark))
  :custom
  (ef-themes-mixed-fonts nil)
  (ef-themes-variable-pitch-ui nil)
  (ef-themes-headings '((0 . (1.5))
                        (1 . (1.4))
                        (2 . (1.3))
                        (3 . (1.2))
                        (4 . (1.1))
                        (5 . (1.1))
                        (6 . (1.0))
                        (7 . (1.0)))))

(use-package standard-themes
  :ensure t
  :init
  (setopt standard-themes-mixed-fonts nil
          standard-themes-variable-pitch-ui nil
          standard-themes-bold-constructs nil
          standard-themes-italic-constructs nil
          standard-themes-common-palette-overrides '((fringe unspecified))
          standard-themes-headings '((0 . (1.5))
                                     (1 . (1.4))
                                     (2 . (1.3))
                                     (3 . (1.2))
                                     (4 . (1.1))
                                     (5 . (1.1))
                                     (6 . (1.0))
                                     (7 . (1.0)))))

(use-package doric-themes
  :ensure t
  :custom
  (doric-themes-toggle '(doric-light doric-obsidian)))

(use-package doom-themes
  :ensure t
  :init
  (defun my-rose-pine ()
    "Clear previous theme and load rosé pine."
    (interactive)
    (my-load-theme 'doom-rose-pine))

  (defun my-rose-pine-dawn ()
    "Clear previous theme and load rosé pine dawn."
    (interactive)
    (my-load-theme 'doom-rose-pine-dawn))

  (defun my-doom-one ()
    "Clear previous theme and load doom-one."
    (interactive)
    (my-load-theme 'doom-one))

  (defun my-gruvbox ()
    "Clear previous theme and load gruvbox."
    (interactive)
    (my-load-theme 'doom-gruvbox))

  (defun my-gruvbox-light ()
    "Clear previous theme and load gruvbox."
    (interactive)
    (my-load-theme 'doom-gruvbox-light))

  (defun my-toggle-rose-pine ()
    "Toggle between light and dark Rosé Pine themes."
    (interactive)
    (if (eq (nth 0 custom-enabled-themes) 'doom-rose-pine)
        (my-rose-pine-dawn)
      (my-rose-pine)))

  (defun my-toggle-gruvbox ()
    "Toggle between light and dark Gruvbox themes."
    (interactive)
    (if (eq (nth 0 custom-enabled-themes) 'doom-gruvbox)
        (my-gruvbox-light)
      (my-gruvbox)))

  (defun my-toggle-tomorrow ()
    "Toggle between light and dark Tomorrow themes."
    (interactive)
    (if (eq (nth 0 custom-enabled-themes) 'doom-tomorrow-night)
        (my-load-theme 'doom-tomorrow-day)
      (my-load-theme 'doom-tomorrow-night)))
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (doom-themes-org-config))

(use-package naysayer-theme
  :ensure t
  :init
  (defun my-naysayer-theme ()
    "Clear previous theme and load naysayer."
    (interactive)
    (my-load-theme 'naysayer)))

(use-package acme-theme
  :ensure t
  :init
  (setq acme-theme-black-fg t)

  (defun my-acme-theme ()
    "Clear previous theme and load acme."
    (interactive)
    (my-load-theme 'acme)))

(use-package kaolin-themes
  :ensure t
  :init
  (defun my-kaolin-dark ()
    "Clear previous theme and load kaolin dark."
    (interactive)
    (my-load-theme 'kaolin-dark))

  (defun my-kaolin-light ()
    "Clear previous theme and load kaolin light."
    (interactive)
    (my-load-theme 'kaolin-light))

  (defun my-kaolin-mono-dark ()
    "Clear previous theme and load kaolin mono dark."
    (interactive)
    (my-load-theme 'kaolin-mono-dark))

  (defun my-kaolin-mono-light ()
    "Clear previous theme and load kaolin mono light."
    (interactive)
    (my-load-theme 'kaolin-mono-light)))

(defun my-toggle-solarized ()
  "Toggle between light and dark solarized themes."
  (interactive)
  (if (eq (nth 0 custom-enabled-themes) 'doom-solarized-dark)
      (my-solarized-light)
    (my-solarized-dark)))

(defun my-solarized-light ()
  "Clear previous theme and load solarized light"
  (interactive)
  (my-load-theme 'doom-solarized-light))

(defun my-solarized-dark ()
  "Clear previous theme and load solarized dark"
  (interactive)
  (my-load-theme 'doom-solarized-dark))

(use-package remember-last-theme
  :ensure t
  :after (acme-theme kaolin-themes naysayer-theme doom-themes doric-themes ef-themes standard-themes modus-themes)
  :config (remember-last-theme-with-file-enable "remember-last-theme"))

(provide 'tony-emacs-themes)
