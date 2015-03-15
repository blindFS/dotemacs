(global-linum-mode t)
(column-number-mode t)
(display-time-mode t)
(size-indication-mode t)


(use-package diminish
  :ensure t
  :init
  (progn
    (diminish 'visual-line-mode)
    (after 'abbrev (diminish 'abbrev-mode))
    (after 'hs-minor-mode (diminish 'hs-minor-mode))
    (after 'flyspell (diminish 'flyspell-mode " Ⓢ"))
    (after 'whitespace (diminish 'whitespace-mode " Ⓦ"))
    (after 'eldoc (diminish 'eldoc-mode " Ⓔ"))))

(setq which-func-format
      `((:propertize which-func-current local-map ,which-func-keymap
                     face which-func mouse-face mode-line-highlight help-echo
                     "mouse-1: go to beginning\nmouse-2: toggle rest visibility\nmouse-3: go to end")))

(use-package powerline
  :ensure t
  :init
  (progn
    (setq-default powerline-default-separator 'slant)

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
    (powerline-my-theme)))

(use-package moe-theme
  :ensure t
  :config
  (progn
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
      (add-hook 'post-command-hook 'my-evil-modeline-hook))))


(use-package color-identifiers-mode
  :ensure t
  :diminish (color-identifiers-mode . "")
  :init
  (global-color-identifiers-mode t))


(use-package highlight-symbol
  :ensure t
  :diminish ""
  :init
  (add-hook 'prog-mode-hook 'highlight-symbol-mode)
  :config
  (setq highlight-symbol-idle-delay 0.3))

(use-package highlight-numbers
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package highlight-quoted
  :ensure t
  :init
  (add-hook 'prog-mode-hook 'highlight-quoted-mode))

(use-package auto-dim-other-buffers
  :ensure t
  :diminish ""
  :init
  (auto-dim-other-buffers-mode))

(use-package indent-guide
  :ensure t
  :diminish " →"
  :config
  (progn
    (add-to-list 'indent-guide-inhibit-modes 'package-menu-mode)
    (indent-guide-global-mode t)
    (setq indent-guide-recursive nil)))

(add-hook 'find-file-hook 'hl-line-mode)

(provide 'init-eyecandy)
