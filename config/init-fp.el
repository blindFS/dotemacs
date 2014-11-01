(lazy-major-mode "\\.sml" sml-mode)

(lazy-major-mode "\\.hs$" haskell-mode)
(require-package 'haskell-mode)
(require-package 'flycheck-haskell)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'haskell-font-lock-symbols t)

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(require-package 'company-ghc)
(when (executable-find "ghc-mod")
  (add-to-list 'company-backends 'company-ghc))

(lazy-major-mode "\\.rkt" racket-mode)
(require-package 'scheme-complete)
(provide 'init-fp)
