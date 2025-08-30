(defvar elpaca-installer-version 0.11)
(defvar elpaca-directory
  (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory
  (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory
  (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order
  '(elpaca
    :repo "https://github.com/progfolio/elpaca.git"
    :ref nil
    :depth 1
    :inherit ignore
    :files (:defaults "elpaca-test.el" (:exclude "extensions"))
    :build (:not elpaca--activate-package)))
(let* ((repo (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list
   'load-path
   (if (file-exists-p build)
       build
     repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (<= emacs-major-version 28)
      (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer
                   (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop
                    (apply #'call-process
                           `("git" nil ,buffer t "clone" ,@
                             (when-let* ((depth
                                          (plist-get order :depth)))
                               (list
                                (format "--depth=%d" depth)
                                "--no-single-branch"))
                             ,(plist-get order :repo) ,repo))))
                  ((zerop
                    (call-process "git"
                                  nil
                                  buffer
                                  t
                                  "checkout"
                                  (or (plist-get order :ref) "--"))))
                  (emacs
                   (concat invocation-directory invocation-name))
                  ((zerop
                    (call-process
                     emacs
                     nil
                     buffer
                     nil
                     "-Q"
                     "-L"
                     "."
                     "--batch"
                     "--eval"
                     "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
          (progn
            (message "%s" (buffer-string))
            (kill-buffer buffer))
          (error
           "%s"
           (with-current-buffer buffer
             (buffer-string))))
      ((error)
       (warn "%s" err)
       (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (let ((load-source-file-function nil))
      (load "./elpaca-autoloads"))))
(add-hook 'after-init-hook #'elpaca-process-queues)
(elpaca `(,@elpaca-order))

(elpaca
 elpaca-use-package
 ;; Enable Elpaca support for use-package's :ensure keyword.
 (elpaca-use-package-mode))

(add-hook 'window-setup-hook 'toggle-frame-maximized t)

(pcase system-type
  ((or 'gnu/linux 'windows-nt 'cygwin)
   (set-face-attribute 'default nil
                       :family "Iosevka Nerd Font Mono"
                       :weight 'regular))
  ('darwin
   (set-face-attribute 'default nil
                       :family "IosevkaTerm Nerd Font Mono"
                       :weight 'regular)))

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
  (cons
   (format "[CRM%s] %s"
           (replace-regexp-in-string
            "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" "" crm-separator)
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
;;(require 'tony-emacs-treemacs)
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
(require 'tony-emacs-lsp-mode)
;;(require 'tony-emacs-lsp-treemacs)
(require 'tony-emacs-ngx)
(require 'tony-emacs-lsp-biome)
