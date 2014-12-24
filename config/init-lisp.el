(use-package elisp-slime-nav
  :ensure t
  :commands elisp-slime-nav-mode
  :diminish ""
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode)
    (add-hook 'ielm-mode-hook 'elisp-slime-nav-mode)))

(use-package paredit
  :ensure t
  :commands paredit-mode
  :diminish " (Ⓟ)"
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
    (add-hook 'lisp-interaction-mode-hook 'paredit-mode)
    (add-hook 'ielm-mode-hook 'elisp-slime-nav-mode))
  :config
  (after 'evil
    (evil-define-key 'normal global-map
      (kbd "C->") 'paredit-forward-slurp-sexp
      (kbd "C-<") 'paredit-backward-slurp-sexp
      (kbd "C-.") 'paredit-forward-barf-sexp
      (kbd "C-,") 'paredit-backward-barf-sexp)))

(use-package evil-paredit
  :ensure t
  :commands evil-paredit-mode
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'evil-paredit-mode)
    (add-hook 'lisp-interaction-mode-hook 'evil-paredit-mode)
    (add-hook 'ielm-mode-hook 'evil-paredit-mode)))

(use-package aggressive-indent
  :ensure t
  :commands aggressive-indent-mode
  :diminish " Ⓘ"
  :init
  (add-hook 'emacs-lisp-mode 'aggressive-indent-mode))

(provide 'init-lisp)
