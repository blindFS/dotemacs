(use-package flycheck
  :ensure t
  :diminish " Ⓕ"
  :init
  (global-flycheck-mode t)
  :config
  (progn
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers))
    (setq flycheck-checkers (delq 'html-tidy flycheck-checkers))
    (setq flycheck-standard-error-navigation nil)
    (defmacro spacemacs|custom-flycheck-lighter (error)
      "Return a formatted string for the given ERROR (error, warning, info)."
      `(let* ((error-counts (flycheck-count-errors
                             flycheck-current-errors))
              (errorp (flycheck-has-current-errors-p ',error))
              (err (or (cdr (assq ',error error-counts)) "?"))
              (running (eq 'running flycheck-last-status-change))
              (indi-symbol (cond ((eq ',error 'error) "✘ ")
                                 ((eq ',error 'warning) "⚠ ")
                                 (t "ℹ "))))
         (if (or errorp running) (concat indi-symbol (format "%s " err)))))))

(provide 'init-flycheck)
