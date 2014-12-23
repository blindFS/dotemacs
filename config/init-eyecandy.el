(show-paren-mode)
(setq show-paren-delay 0)


(line-number-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(require-package 'diminish)
(diminish 'visual-line-mode)
(after 'aggressive-indent (diminish 'aggressive-indent-mode " Ⓘ"))
(after 'company (diminish 'company-mode " Ⓒ"))
(after 'rainbow-mode (diminish 'rainbow-mode " Ⓡ"))
(after 'auto-dim-other-buffers (diminish 'auto-dim-other-buffers-mode " Ⓓ"))
(after 'highlight-symbol (diminish 'highlight-symbol-mode " Ⓗ"))
(after 'indent-guide (diminish 'indent-guide-mode " →"))
(after 'flycheck (diminish 'flycheck-mode " Ⓕ"))
(after 'flyspell (diminish 'flyspell-mode " Ⓢ"))
(after 'autopair (diminish 'autopair-mode " Ⓐ"))
(after 'smartparens (diminish 'smartparens-mode " (Ⓢ)"))
(after 'paredit (diminish 'paredit-mode " (Ⓟ)"))
(after 'whitespace (diminish 'whitespace-mode " Ⓦ"))
(after 'undo-tree (diminish 'undo-tree-mode))
(after 'auto-complete (diminish 'auto-complete-mode))
(after 'yasnippet (diminish 'yas-minor-mode " Ⓨ"))
(after 'guide-key (diminish 'guide-key-mode " Ⓖ"))
(after 'eldoc (diminish 'eldoc-mode " Ⓔ"))
(after 'elisp-slime-nav (diminish 'elisp-slime-nav-mode))
(after 'git-gutter+ (diminish 'git-gutter+-mode))
(after 'magit (diminish 'magit-auto-revert-mode))
(after 'color-identifiers-mode (diminish 'color-identifiers-mode))
(after 'abbrev(diminish 'abbrev-mode))

(setq which-func-format
      `((:propertize which-func-current local-map ,which-func-keymap
                     face which-func mouse-face mode-line-highlight help-echo
                     "mouse-1: go to beginning\nmouse-2: toggle rest visibility\nmouse-3: go to end")))

(require-package 'powerline)
(setq-default powerline-default-separator 'wave)

(defun powerline-my-theme ()
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let*
                       ((active (powerline-selected-window-active))
                        (mode-line (if active 'mode-line 'mode-line-inactive))
                        (face1 (if active 'powerline-active1 'powerline-inactive1))
                        (face2 (if active 'powerline-active2 'powerline-inactive2))
                        (flycheckp (and (boundp 'flycheck-mode)
                                        (symbol-value flycheck-mode)
                                        (or flycheck-current-errors
                                            (eq 'running flycheck-last-status-change))))
                        (separator-left
                         (intern
                          (format "powerline-%s-%s" powerline-default-separator
                                  (car powerline-default-separator-dir))))
                        (separator-right
                         (intern
                          (format "powerline-%s-%s" powerline-default-separator
                                  (cdr powerline-default-separator-dir))))
                        (lhs
                         (append
                          ;; buffer info
                          (list
                           (powerline-buffer-id 'mode-line-buffer-id 'l)
                           (funcall separator-right 'mode-line-buffer-id face1)
                           (powerline-raw "%*" face1 'l)
                           (powerline-buffer-size face1 'l)
                           (powerline-raw mode-line-mule-info face1 'l))
                          ;; which-func
                          (when
                              (and
                               (boundp 'which-func-mode)
                               which-func-mode)
                            (list
                             (funcall separator-left face1 'which-func)
                             (powerline-raw which-func-format 'which-func'l)
                             (powerline-raw " " 'which-func)
                             (funcall separator-left 'which-func face1)))
                          ;; major mode
                          (list
                           (when
                               (boundp 'erc-modified-channels-object)
                             (powerline-raw erc-modified-channels-object face1 'l))
                           (powerline-major-mode face1 'l)
                           (powerline-raw " " face1))
                          ;; flycheck
                          (if flycheckp
                              (list
                               (powerline-raw (spacemacs|custom-flycheck-lighter error) face1)
                               (powerline-raw (spacemacs|custom-flycheck-lighter warning) face1)
                               (powerline-raw (spacemacs|custom-flycheck-lighter info) face1)))
                          (if active
                              ;; minor modes
                              (list
                               (funcall separator-left face1 mode-line)
                               (powerline-minor-modes mode-line 'l)
                               (powerline-raw mode-line-process mode-line 'l)
                               (powerline-raw " " mode-line)
                               (funcall separator-left mode-line face2)
                               (powerline-narrow face2 'l)
                               (powerline-vc face2 'r))
                            (list (funcall separator-left face1 face2)))))
                        (rhs
                         (list
                          (powerline-raw global-mode-string face2 'r)
                          (funcall separator-right face2 face1)
                          (powerline-raw "%4l" face1 'l)
                          (powerline-raw ":" face1 'l)
                          (powerline-raw "%3c" face1 'r)
                          (funcall separator-right face1 mode-line)
                          (powerline-raw " " mode-line)
                          (powerline-raw "%6p" mode-line 'r)
                          (powerline-hud face2 face1))))
                     (concat
                      (powerline-render lhs)
                      (powerline-fill face2
                                      (powerline-width rhs))
                      (powerline-render rhs)))))))
(powerline-my-theme)

(require-package 'moe-theme)
(require 'moe-theme)
(setq moe-theme-resize-org-title '(2.2 1.8 1.6 1.4 1.2 1.0 1.0 1.0 1.0))
(moe-dark)
(moe-theme-set-color 'blue)

(after 'evil
  (defun my-evil-modeline-hook ()
    "changes the modeline color when the evil mode changes"
    (cond ((evil-insert-state-p) (progn (moe-theme-set-color 'green) (powerline-reset) (powerline-my-theme)))
          ((evil-visual-state-p) (progn (moe-theme-set-color 'orange) (powerline-reset) (powerline-my-theme)))
          ((evil-normal-state-p) (progn (moe-theme-set-color 'blue) (powerline-reset) (powerline-my-theme)))
          (t (progn (moe-theme-set-color 'w/b) (powerline-reset) (powerline-my-theme)))))
  (add-hook 'post-command-hook 'my-evil-modeline-hook))


(require-package 'color-identifiers-mode)
(global-color-identifiers-mode)


(require-package 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.3)
(add-hook 'prog-mode-hook 'highlight-symbol-mode)

(require-package 'highlight-numbers)
(add-hook 'prog-mode-hook 'highlight-numbers-mode)

(require-package 'highlight-quoted)
(add-hook 'prog-mode-hook 'highlight-quoted-mode)

(require-package 'auto-dim-other-buffers)
(add-hook 'after-init-hook 'auto-dim-other-buffers-mode)

(require-package 'indent-guide)
(require 'indent-guide)
(setq indent-guide-recursive nil)
(add-to-list 'indent-guide-inhibit-modes 'package-menu-mode)
(indent-guide-global-mode)


(add-hook 'find-file-hook 'hl-line-mode)


(provide 'init-eyecandy)
