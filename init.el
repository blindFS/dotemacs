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

(defcustom dotemacs-modules
  '(init-core
    init-packages
    init-util
    init-evil
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
    init-python
    init-web
    init-lisp
    init-pretty
    init-misc
    init-func
    init-bindings
    init-fp)
  "Set of modules enabled in dotemacs."
  :group 'dotemacs)

(dolist (module dotemacs-modules)
  (require module))
