(use-package company
  :ensure t
  :diminish " Ⓒ"
  :bind ("C-f" . company-files)
  :init
  (progn
    (global-company-mode t)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous))
  :config
  (progn
    (setq company-idle-delay 0.2)
    (setq company-minimum-prefix-length 1)
    (setq company-show-numbers t)
    (setq company-tooltip-limit 20)
    (setq company-global-modes
          '(not eshell-mode comint-mode))

    (when (executable-find "ghc-mod")
      (add-to-list 'company-backends 'company-ghc))

    (defadvice company-complete-common (around advice-for-company-complete-common activate)
      (when (null (yas-expand))
        ad-do-it))))

(provide 'init-company)
