(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode
  :diminish (rainbow-mode . " Ⓡ")
  :init
  (progn
    (add-hook 'html-mode-hook 'rainbow-mode)
    (add-hook 'web-mode-hook 'rainbow-mode)
    (add-hook 'css-mode-hook 'rainbow-mode)))

(use-package emmet-mode
  :ensure t
  :commands emmet-mode
  :diminish (emmet-mode . "")
  :init
  (progn
    (add-hook 'css-mode-hook 'emmet-mode)
    (add-hook 'sgml-mode-hook 'emmet-mode)
    (add-hook 'web-mode-hook 'emmet-mode)))

(use-package web-mode
  :ensure t
  :mode "\\.html?$")

(provide 'init-web)
