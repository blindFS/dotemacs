(after "js2-mode-autoloads"
  (require-package 'skewer-mode)
  (skewer-setup))


(require-package 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'web-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)

(defun my-emmet-mode ()
  (require-package 'emmet-mode)
  (emmet-mode))

(add-hook 'css-mode-hook 'my-emmet-mode)
(add-hook 'sgml-mode-hook 'my-emmet-mode)
(add-hook 'web-mode-hook 'my-emmet-mode)


(lazy-major-mode "\\.html?$" web-mode)

(provide 'init-web)
