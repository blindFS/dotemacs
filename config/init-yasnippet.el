(require-package 'yasnippet)

(require 'yasnippet)

(setq yas-fallback-behavior 'return-nil)
(setq yas-also-auto-indent-first-line t)
(setq yas-prompt-functions '(yas/ido-prompt yas/completing-prompt))

(add-hook 'prog-mode-hook 'yas-minor-mode)
(add-hook 'html-mode-hook 'yas-minor-mode)
(add-hook 'org-mode-hook 'yas-minor-mode)

(add-to-list 'yas-snippet-dirs (concat user-emacs-directory "snippets"))

(after 'evil
  (evil-define-key 'insert global-map (kbd "C-k") 'yas/insert-snippet))

(yas-reload-all)

(provide 'init-yasnippet)
