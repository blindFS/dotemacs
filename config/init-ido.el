(use-package ido
  :init
  (progn
    (ido-mode t)
    (ido-everywhere t))
  :config
  (progn
    (setq ido-enable-prefix nil)
    (setq ido-use-virtual-buffers t)
    (setq ido-enable-flex-matching t)
    (setq ido-create-new-buffer 'always)
    (setq ido-use-filename-at-point 'guess)
    (setq ido-save-directory-list-file (concat dotemacs-cache-directory "ido.last"))))

(use-package ido-ubiquitous
  :ensure t
  :init
  (ido-ubiquitous-mode t))

(use-package flx-ido
  :ensure t
  :init
  (flx-ido-mode t))

(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode))

(use-package smex
  :ensure t
  :defer t
  :init
  (progn
    (after 'evil
      (define-key evil-visual-state-map (kbd "SPC SPC") 'smex)
      (define-key evil-normal-state-map (kbd "SPC SPC") 'smex)
      (global-set-key (kbd "M-x") 'smex)
      (global-set-key (kbd "C-x C-m") 'smex)
      (global-set-key (kbd "C-c C-m") 'smex)))
  :config
  (setq smex-save-file (concat dotemacs-cache-directory "smex-items")))

(provide 'init-ido)
