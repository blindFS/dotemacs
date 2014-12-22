(require-package 'anaconda-mode)
(require 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)
(after 'anaconda-mode (diminish 'anaconda-mode))

(provide 'init-python)
