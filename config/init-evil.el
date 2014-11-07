(defcustom dotemacs-evil-state-modes
  '(fundamental-mode
    text-mode
    prog-mode
    sws-mode
    dired-mode
    comint-mode
    log-edit-mode
    compilation-mode)
  "List of modes that should start up in Evil state."
  :type '(repeat (symbol))
  :group 'dotemacs)


(setq evil-search-module 'evil-search)
(setq evil-magic 'very-magic)

(setq evil-emacs-state-cursor '("#e74c3c" box))
(setq evil-normal-state-cursor '("#2ecc71" box))
(setq evil-visual-state-cursor '("#f39c12" box))
(setq evil-insert-state-cursor '("#4aa3df" bar))
(setq evil-replace-state-cursor '("#9b59b6" bar))
(setq evil-operator-state-cursor '("#16a085" hollow))

(require-package 'evil)
(require 'evil)

;; customized kbd
(evil-define-key 'normal global-map (kbd "gh") 'beginning-of-line)
(evil-define-key 'normal global-map (kbd "gl") 'end-of-line)
(require-package 'evil-leader)
(global-evil-leader-mode t)


;; for doc-view-mode
(defun my-evil-doc-view-hook ()
  (turn-off-evil-mode)
  (define-key doc-view-mode-map (kbd "j") 'doc-view-scroll-up-or-next-page)
  (define-key doc-view-mode-map (kbd "k") 'doc-view-scroll-down-or-previous-page)
  (define-key doc-view-mode-map (kbd "h") 'image-backward-hscroll)
  (define-key doc-view-mode-map (kbd "l") 'image-forward-hscroll))

(add-hook 'doc-view-mode-hook 'my-evil-doc-view-hook)


(setq evilnc-hotkey-comment-operator "gc")
(require-package 'evil-nerd-commenter)
(require 'evil-nerd-commenter)


(require-package 'evil-surround)
(global-evil-surround-mode t)


(require-package 'evil-exchange)
(evil-exchange-install)


(setq evil-jumper-auto-center t)
(setq evil-jumper-file (concat dotemacs-cache-directory "evil-jumps"))
(setq evil-jumper-auto-save-interval 3600)
(require-package 'evil-jumper)
(require 'evil-jumper)

(require-package 'evil-matchit)
(defun evilmi-customize-keybinding ()
  (evil-define-key 'normal evil-matchit-mode-map
    "%" 'evilmi-jump-items))
(global-evil-matchit-mode t)


(require-package 'evil-indent-textobject)
(require 'evil-indent-textobject)


(require-package 'evil-visualstar)
(require 'evil-visualstar)


(require-package 'evil-numbers)


(defun my-enable-evil-mode ()
  (if (apply 'derived-mode-p dotemacs-evil-state-modes)
      (turn-on-evil-mode)
    (set-cursor-color "#2ecc71")))
(add-hook 'after-change-major-mode-hook 'my-enable-evil-mode)
(add-hook 'help-mode-hook (lambda () (turn-on-evil-mode)))

(defun my-send-string-to-terminal (string)
  (unless (display-graphic-p) (send-string-to-terminal string)))

(defun my-evil-modeline-change (default-color)
  "changes the modeline color when the evil mode changes"
  (let ((color (cond ((evil-insert-state-p) '("#002233" . "#ffffff"))
                     ((evil-visual-state-p) '("#330022" . "#ffffff"))
                     ((evil-normal-state-p) default-color)
                     (t '("#435160" . "#ffffff")))))
    (set-face-background 'mode-line (car color))
    (set-face-foreground 'mode-line (cdr color))))

(lexical-let ((default-color (cons (face-background 'mode-line)
                                   (face-foreground 'mode-line))))
  (add-hook 'post-command-hook (lambda () (my-evil-modeline-change default-color))))

(defadvice evil-ex-search-next (after advice-for-evil-ex-search-next activate)
  (recenter))

(defadvice evil-ex-search-previous (after advice-for-evil-ex-search-previous activate)
  (recenter))

(provide 'init-evil)
