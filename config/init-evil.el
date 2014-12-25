(defcustom dotemacs-evil-state-modes
  '(fundamental-mode
    text-mode
    prog-mode
    sws-mode
    dired-mode
    comint-mode
    log-edit-mode
    compilation-mode)
  "List of modes that should start up in Evil state."
  :type '(repeat (symbol))
  :group 'dotemacs)


(use-package evil
  :ensure t
  :init
  (progn
    ;; customized kbd
    (evil-define-key 'normal global-map (kbd "gh") 'beginning-of-line)
    (evil-define-key 'normal global-map (kbd "gl") 'end-of-line)
    ;; for doc-view-mode
    (defun my-evil-doc-view-hook ()
      (turn-off-evil-mode)
      (define-key doc-view-mode-map (kbd "j") 'doc-view-scroll-up-or-next-page)
      (define-key doc-view-mode-map (kbd "k") 'doc-view-scroll-down-or-previous-page)
      (define-key doc-view-mode-map (kbd "h") 'image-backward-hscroll)
      (define-key doc-view-mode-map (kbd "l") 'image-forward-hscroll))
    (add-hook 'doc-view-mode-hook 'my-evil-doc-view-hook)

    (defun my-enable-evil-mode ()
      (if (apply 'derived-mode-p dotemacs-evil-state-modes)
          (turn-on-evil-mode)
        (set-cursor-color "#2ecc71")))
    (add-hook 'after-change-major-mode-hook 'my-enable-evil-mode)
    (add-hook 'help-mode-hook (lambda () (turn-on-evil-mode)))

    (defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
      (recenter))

    (defadvice evil-ex-search-previous (after advice-for-evil-ex-search-previous activate)
      (recenter)))
  :config
  (progn
    (setq evil-search-module 'evil-search)
    (setq evil-magic 'very-magic)
    (setq evil-emacs-state-cursor '("#e74c3c" box))
    (setq evil-normal-state-cursor '("#2ecc71" box))
    (setq evil-visual-state-cursor '("#f39c12" box))
    (setq evil-insert-state-cursor '("#4aa3df" bar))
    (setq evil-replace-state-cursor '("#9b59b6" bar))
    (setq evil-operator-state-cursor '("#16a085" hollow))))

(use-package evil-leader
  :ensure t
  :init
  (global-evil-leader-mode t))

(setq evilnc-hotkey-comment-operator "gc")
(use-package evil-nerd-commenter :ensure t)

(use-package evil-surround
  :ensure t
  :init
  (global-evil-surround-mode t))

(use-package evil-exchange
  :ensure t
  :init
  (evil-exchange-install))

(use-package evil-jumper
  :ensure t
  :config
  (progn
    (setq evil-jumper-auto-center t)
    (setq evil-jumper-file (concat dotemacs-cache-directory "evil-jumps"))
    (setq evil-jumper-auto-save-interval 3600)))

(use-package evil-matchit
  :ensure t
  :init
  (global-evil-matchit-mode t))

(use-package evil-visualstar
  :ensure t
  :init
  (global-evil-visualstar-mode t))
(use-package evil-indent-textobject :ensure t)
(use-package evil-numbers :ensure t)
(use-package evil-args
  :ensure t
  :defer t
  :init
  (progn
    (define-key evil-inner-text-objects-map "," 'evil-inner-arg)
    (define-key evil-outer-text-objects-map "," 'evil-outer-arg)))

(provide 'init-evil)
