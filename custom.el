(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(custom-safe-themes
   (quote
    ("5ea20171762b3f9682fbf507ee4b4018ce7b6cc65415fa99799a125f112b2cdb" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" default)))
 '(display-time-mode t)
 '(org-emphasis-alist
   (quote
    (("*" bold)
     ("/" italic)
     ("_" underline)
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim)
     ("+"
      (:strike-through t)))))
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "NovaMono" :foundry "unknown" :slant normal :weight normal :height 120 :width normal))))
 '(highlight ((t (:background "#454545" :foreground nil :bold t :underline nil))))
 '(org-code ((t (:foreground "medium spring green"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#425d78"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#1abc9c"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#2980b9"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#8e44ad"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#f39c12"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#27ae60"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "#7f8c8d"))))
 '(rainbow-delimiters-unmatched-face ((t (:foreground "#e74c3c"))))
 '(sp-show-pair-match-face ((t (:background "coral"))))
 '(trailing-whitespace ((t (:background "DarkOrchid2"))))
 '(which-func ((t (:foreground "#2ecc71")))))
(set-fontset-font t 'unicode (font-spec :family "Source Han Sans" :size 16))
(setq face-font-rescale-alist '(("Source Han Sans" . 1.15) ("Source Han Sans" . 1.15)))
