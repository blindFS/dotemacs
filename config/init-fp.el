(use-package sml-mode
  :ensure t
  :mode "\\.sml$")

(use-package haskell-mode
  :ensure t
  :mode "\\.hs$"
  :init
  (progn
    (add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
    (add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode))
  :config
  (progn
    (setq haskell-font-lock-symbols t)
    (use-package flycheck-haskell :ensure t)
    (use-package company-ghc :ensure t)
    (autoload 'ghc-init "ghc" nil t)
    (autoload 'ghc-debug "ghc" nil t)
    (ghc-init)))


(use-package racket-mode
  :ensure t
  :mode "\\.rkt$")

(use-package scheme-complete :ensure t)

(load-file "/usr/share/emacs/site-lisp/ProofGeneral/generic/proof-site.el")
(use-package company-coq
  :ensure t
  :init
  (progn
    (setq company-coq-autocomplete-symbols t)
    (add-hook 'coq-mode-hook 'company-coq-initialize)))

(provide 'init-fp)
