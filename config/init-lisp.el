(require-package 'elisp-slime-nav)
(require-package 'paredit)
(require-package 'evil-paredit)
(after "elisp-slime-nav-autoloads"
  (defadvice elisp-slime-nav-find-elisp-thing-at-point (after advice-for-elisp-slime-nav-find-elisp-thing-at-point activate)
    (recenter)))

(defun my-lisp-hook ()
  (progn
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode)
    (paredit-mode)
    (evil-paredit-mode)
    (evil-define-key 'normal global-map
      (kbd "C->") 'paredit-forward-slurp-sexp
      (kbd "C-<") 'paredit-backward-slurp-sexp
      (kbd "C-.") 'paredit-forward-barf-sexp
      (kbd "C-,") 'paredit-backward-barf-sexp)))

(add-hook 'emacs-lisp-mode-hook 'my-lisp-hook)
(add-hook 'lisp-interaction-mode-hook 'my-lisp-hook)
(add-hook 'ielm-mode-hook 'my-lisp-hook)

(provide 'init-lisp)
