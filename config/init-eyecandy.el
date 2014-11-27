(show-paren-mode)
(setq show-paren-delay 0)


(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(defun my-fold-overlay (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let ((col (save-excursion
                 (move-end-of-line 0)
                 (current-column)))
          (count (count-lines (overlay-start ov) (overlay-end ov))))
      (overlay-put ov 'display
                   (format " %s [ %d lines ] ----"
                           (make-string (- (window-width) col 32) (string-to-char "-"))
                           count)))))
(setq hs-set-up-overlay 'my-fold-overlay)


(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'autopair (diminish 'autopair-mode))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'yasnippet (diminish 'yas-minor-mode))
(after 'guide-key (diminish 'guide-key-mode))
(after 'eldoc (diminish 'eldoc-mode))
(after 'smartparens (diminish 'smartparens-mode))
(after 'company (diminish 'company-mode))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'magit (diminish 'magit-auto-revert-mode))


(require-package 'smart-mode-line)
(setq sml/show-client t)
(setq sml/show-eol t)
(setq sml/show-frame-identification t)
(sml/setup)

(require-package 'powerline)
(powerline-default-theme)

(require-package 'color-identifiers-mode)
(global-color-identifiers-mode)
(diminish 'color-identifiers-mode)


(require-package 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(require-package 'highlight-quoted)
(add-hook 'prog-mode-hook 'highlight-quoted-mode)


(require-package 'indent-guide)
(require 'indent-guide)
(setq indent-guide-recursive nil)
(add-to-list 'indent-guide-inhibit-modes 'package-menu-mode)
(indent-guide-global-mode)


(add-hook 'find-file-hook 'hl-line-mode)


(provide 'init-eyecandy)
