(use-package helm
  :ensure t
  :defer t
  :init
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd "g b") 'helm-mini)
      (define-key evil-normal-state-map (kbd "SPC t") 'helm-etags-select)
      (define-key evil-normal-state-map (kbd "SPC y") 'helm-show-kill-ring)
      (define-key evil-normal-state-map (kbd "SPC m") 'helm-bookmarks)
      (define-key evil-normal-state-map (kbd "SPC r") 'helm-register)))
  :config
  (progn
    (setq helm-quick-update t)
    (setq helm-bookmark-show-location t)
    (setq helm-buffers-fuzzy-matching t)))

(use-package helm-swoop
  :ensure t
  :defer t
  :init
  (progn
    (after 'evil
      (define-key evil-normal-state-map (kbd "SPC l") 'helm-swoop)
      (define-key evil-normal-state-map (kbd "SPC L") 'helm-multi-swoop))))

(provide 'init-helm)
