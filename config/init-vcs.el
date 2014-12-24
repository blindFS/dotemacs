(after 'vc-git
  (use-package magit
    :ensure t
    :commands (magit-status
               magit-log
               magit-commit)
    :diminish (magit-auto-revert-mode . "")
    :config
    (progn
    (setq magit-diff-options '("--histogram"))
    (setq magit-stage-all-confirm nil)
    (defadvice magit-status (around my-magit-fullscreen activate)
      (window-configuration-to-register :magit-fullscreen)
      ad-do-it
      (delete-other-windows))

    (defun my-magit-quit-session ()
      (interactive)
      (kill-buffer)
      (jump-to-register :magit-fullscreen))))

  (after 'evil
    (after 'git-commit-mode
      (add-hook 'git-commit-mode-hook 'evil-emacs-state))

    (after 'magit-blame
      (defadvice magit-blame-file-on (after advice-for-magit-blame-file-on activate)
        (evil-emacs-state))
      (defadvice magit-blame-file-off (after advice-for-magit-blame-file-off activate)
        (evil-exit-emacs-state))))

  (use-package git-gutter-fringe+
    :ensure t
    :diminish (git-gutter+-mode . "")
    :init
    (global-git-gutter+-mode)))

(use-package diff-hl
  :ensure t
  :init
  (progn
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
    (unless (display-graphic-p)
      (diff-hl-margin-mode))))

(provide 'init-vcs)
