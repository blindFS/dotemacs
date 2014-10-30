(defgroup dotemacs nil
  "Custom configuration for dotemacs."
  :group 'local)

(defcustom dotemacs-cache-directory (concat user-emacs-directory ".cache/")
  "The storage location for various persistent files."
  :group 'dotemacs)

(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))

(add-to-list 'load-path (concat user-emacs-directory "config"))

(require 'cl)
(require 'init-packages)
(require 'init-util)

; (let ((base (concat user-emacs-directory "elisp")))
;   (add-to-list 'load-path base)
;   (dolist (dir (directory-files base t))
;     (when (and (file-directory-p dir)
;                (not (equal (file-name-nondirectory dir) ".."))
;                (not (equal (file-name-nondirectory dir) ".")))
;       (add-to-list 'load-path dir))))

(defcustom dotemacs-modules
  '(init-core

    init-eshell
    init-org
    init-erc
    init-eyecandy
    init-smartparens
    init-yasnippet
    init-company
    init-helm
    init-ido
    init-vcs
    init-flycheck
    init-js
    init-web
    init-lisp
    init-misc
    init-evil
    init-bindings
    init-fp)
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))
