(use-package undo-tree
  :ensure t
  :diminish ""
  :init
  (progn
    (setq undo-tree-auto-save-history t)
    (setq undo-tree-history-directory-alist
          `(("." . ,(concat dotemacs-cache-directory "undo"))))
    (setq undo-tree-visualizer-timestamps t)
    (setq undo-tree-visualizer-diff t)
    (global-undo-tree-mode t)))


(when (executable-find "ag")
  (use-package ag
    :ensure t
    :commands ag)
  (setq ag-highlight-search t))


(use-package ace-jump-mode
  :ensure t
  :defer t
  :init
  (after 'evil
    (define-key evil-operator-state-map (kbd "z") 'evil-ace-jump-char-mode)
    (define-key evil-normal-state-map (kbd "s") 'evil-ace-jump-char-mode)
    (define-key evil-motion-state-map (kbd "S-SPC") 'evil-ace-jump-line-mode)))

(use-package expand-region
  :ensure t
  :defer t
  :init
  (after 'evil
    (global-set-key (kbd "C-=") 'er/expand-region)))


(use-package windsize
  :ensure t
  :init
  (progn
    (setq windsize-cols 16)
    (setq windsize-rows 8)
    (windsize-default-keybindings)))

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package popwin
  :ensure t
  :init
  (popwin-mode 1)
  :config
  (setq display-buffer-function 'popwin:display-buffer))

(provide 'init-misc)
