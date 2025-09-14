;;;; Pulsar
;; Read the pulsar manual: <https://protesilaos.com/emacs/pulsar>.
(use-package
  pulsar
  :ensure t
  :config
  (setq
   pulsar-pulse t
   pulsar-delay 0.055
   pulsar-iterations 5
   pulsar-face 'pulsar-green
   pulsar-region-face 'pulsar-cyan
   pulsar-highlight-face 'pulsar-magenta)
  ;; Pulse after `pulsar-pulse-region-functions'.
  (setq pulsar-pulse-region-functions
	pulsar-pulse-region-common-functions)
  :hook
  ;; There are convenience functions/commands which pulse the line using
  ;; a specific colour: `pulsar-pulse-line-red' is one of them.
  ((next-error
    .
    (pulsar-pulse-line-red pulsar-recenter-top pulsar-reveal-entry))
   (minibuffer-setup . pulsar-pulse-line-red)
   ;; Pulse right after the use of `pulsar-pulse-functions' and
   ;; `pulsar-pulse-region-functions'.  The default value of the
   ;; former user option is comprehensive.
   (after-init . pulsar-global-mode))
  :bind
  ;; pulsar does not define any key bindings.  This is just my personal
  ;; preference.  Remember to read the manual on the matter.  Evaluate:
  ;;
  ;; (info "(elisp) Key Binding Conventions")
  (("C-x l" . pulsar-pulse-line) ; override `count-lines-page'
   ("C-x L" . pulsar-highlight-dwim))) ; or use `pulsar-highlight-line'

(provide 'tony-emacs-pulsar)
