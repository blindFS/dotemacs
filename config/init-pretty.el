(global-prettify-symbols-mode 1)

(defun minor-prettify-symbols-hook ()
  (setq-local prettify-symbols-alist (append '(
                                               (">=" . ?≥)
                                               ("<=" . ?≤)
                                               ("lambda" . ?λ)
                                               ) prettify-symbols-alist)))

(add-hook 'scheme-mode-hook 'minor-prettify-symbols-hook)
(add-hook 'emacs-lisp-mode-hook 'minor-prettify-symbols-hook)
(add-hook 'racket-mode-hook 'minor-prettify-symbols-hook)

(setq haskell-font-lock-symbols t)

(provide 'init-pretty)