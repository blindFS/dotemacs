(setq helm-command-prefix-key "C-c h")
(setq helm-quick-update t)
(setq helm-bookmark-show-location t)
(setq helm-buffers-fuzzy-matching t)

(require-package 'helm)
(require-package 'helm-swoop)

(require 'helm-config)

(provide 'init-helm)
