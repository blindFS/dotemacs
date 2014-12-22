(show-paren-mode)
(setq show-paren-delay 0)


(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'aggressive-indent (diminish 'aggressive-indent-mode " Ⓘ"))
(after 'company (diminish 'company-mode " Ⓒ"))
(after 'rainbow-mode (diminish 'rainbow-mode " Ⓡ"))
(after 'auto-dim-other-buffers (diminish 'auto-dim-other-buffers-mode " Ⓓ"))
(after 'highlight-symbol (diminish 'highlight-symbol-mode " Ⓗ"))
(after 'indent-guide (diminish 'indent-guide-mode " →"))
(after 'flycheck (diminish 'flycheck-mode " Ⓕ"))
(after 'flyspell (diminish 'flyspell-mode " Ⓢ"))
(after 'autopair (diminish 'autopair-mode " Ⓐ"))
(after 'smartparens (diminish 'smartparens-mode " (Ⓢ)"))
(after 'paredit (diminish 'paredit-mode " (Ⓟ)"))
(after 'whitespace (diminish 'whitespace-mode " Ⓦ"))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'yasnippet (diminish 'yas-minor-mode " Ⓨ"))
(after 'guide-key (diminish 'guide-key-mode " Ⓖ"))
(after 'eldoc (diminish 'eldoc-mode " Ⓔ"))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'magit (diminish 'magit-auto-revert-mode))
(after 'color-identifiers-mode (diminish 'color-identifiers-mode))
(after 'abbrev(diminish 'abbrev-mode))


(require-package 'powerline)
(setq-default powerline-default-separator 'wave)
(require-package 'moe-theme)
(require 'moe-theme)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(moe-dark)
(moe-theme-set-color 'blue)
(powerline-moe-theme)

(after 'evil
  (defun my-evil-modeline-hook ()
    "changes the modeline color when the evil mode changes"
    (cond ((evil-insert-state-p) (moe-theme-set-color 'green))
          ((evil-visual-state-p) (moe-theme-set-color 'orange))
          ((evil-normal-state-p) (moe-theme-set-color 'blue))
          (t (moe-theme-set-color 'w/b))))
  (add-hook 'post-command-hook 'my-evil-modeline-hook))


(require-package 'color-identifiers-mode)
(global-color-identifiers-mode)


(require-package 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(require-package 'highlight-quoted)
(add-hook 'prog-mode-hook 'highlight-quoted-mode)

(require-package 'auto-dim-other-buffers)
(add-hook 'after-init-hook 'auto-dim-other-buffers-mode)

(require-package 'indent-guide)
(require 'indent-guide)
(setq indent-guide-recursive nil)
(add-to-list 'indent-guide-inhibit-modes 'package-menu-mode)
(indent-guide-global-mode)


(add-hook 'find-file-hook 'hl-line-mode)


(provide 'init-eyecandy)
