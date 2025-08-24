(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(pcase system-type
  ((or 'gnu/linux 'windows-nt 'cygwin)
   (set-face-attribute 'default nil
  	               :family "Iosevka Nerd Font Mono"
  	               :weight 'regular))
  ('darwin (set-face-attribute 'default nil :family "IosevkaTerm Nerd Font Mono" :weight 'regular)))

(setq ring-bell-function #'ignore)
(setq inhibit-startup-message t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(hl-line-mode 1)

(recentf-mode 1)
(setq history-length 25)
(savehist-mode 1)
(save-place-mode 1)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode 1)

(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
;; Disable the damn thing by making it disposable. 
;; (setq custom-file (make-temp-file "emacs-custom-"))

(setq w32-pass-apps-to-system nil)
(setq w32-apps-modifier 'hyper)

;;(defconst my-leader (if (eq system-type 'darwin) "SPC" "SPC"))
(defun enable-hyper-super-modifiers-linux-x ()
  ;; on nowadays linux, <windows> key is usually configured to Super

  ;; menu key as hyper (Note: for H-s, you need to release <menu> key before pressing 's')
  (define-key key-translation-map [menu] 'event-apply-hyper-modifier) ;H-
  ;;(define-key key-translation-map [apps] 'event-apply-hyper-modifier)

  ;; by default, Emacs bind <menu> to execute-extended-command (same as M-x) now <menu> defined as 'hyper, we need to press <menu> twice to get <H-menu> (global-set-key (kbd "<H-menu>") 'execute-extended-command)
  )

(enable-hyper-super-modifiers-linux-x)

;; Vertico settings
;; Add prompt indicator to `completing-read-multiple'.
;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
(defun crm-indicator (args)
  (cons (format "[CRM%s] %s"
                (replace-regexp-in-string
                 "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                 crm-separator)
                (car args))
        (cdr args)))
(advice-add #'completing-read-multiple :filter-args #'crm-indicator)

(mapc
 (lambda (string)
   (add-to-list 'load-path (locate-user-emacs-file string)))
 '("tony-lisp" "tony-emacs-modules"))

(require 'tony-emacs-miscellaneous)
(require 'tony-emacs-org)
(require 'tony-emacs-project)
(require 'tony-emacs-meow)
(require 'tony-emacs-which-key)
(require 'tony-emacs-doom-themes)
(require 'tony-emacs-solaire-mode)
(require 'tony-emacs-doom-modeline)
(require 'tony-emacs-textsize)
(require 'tony-emacs-vertico)
(require 'tony-emacs-marginalia)
(require 'tony-emacs-orderless)
(require 'tony-emacs-consult)
(require 'tony-emacs-magit)
(require 'tony-emacs-denote)
(require 'tony-emacs-completion)
(require 'tony-emacs-linter)
(require 'tony-emacs-prettier)
(require 'tony-emacs-treesit)
;;(require 'tony-emacs-lsp-mode)
