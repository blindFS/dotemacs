(add-hook
 'org-load-hook
 (lambda ()
   ;; evil key bindings
   (evil-define-key 'normal org-mode-map
     (kbd "RET") 'org-open-at-point
     "o" (lambda ()
           (interactive)
           (end-of-line)
           (if (not (org-in-item-p))
               (insert "\n- ")
             (org-insert-item))
           (evil-append nil)
           )
     "O" (lambda ()
           (interactive)
           (end-of-line)
           (org-insert-heading)
           (evil-append nil)
           )
     "za" 'org-cycle
     "zA" 'org-shifttab
     "zm" 'hide-body
     "zr" 'show-all
     "zo" 'show-subtree
     "zO" 'show-all
     "zc" 'hide-subtree
     "zC" 'hide-all
     (kbd "<tab>") 'org-table-align
     (kbd "M-h") 'org-metaleft
     (kbd "M-j") 'org-metadown
     (kbd "M-k") 'org-metaup
     (kbd "M-l") 'org-metaright
     (kbd "M-H") 'org-shiftmetaleft
     (kbd "M-J") 'org-shiftmetadown
     (kbd "M-K") 'org-shiftmetaup
     (kbd "M-L") 'org-shiftmetaright)

   ;; options
   (setq org-directory "~/Dropbox/org")
   (unless (file-exists-p org-directory)
     (make-directory org-directory))

   (setq my-inbox-org-file (concat org-directory "/inbox.org"))

   (setq org-default-notes-file my-inbox-org-file)
   (setq org-log-done t)
   (setq org-completion-use-ido t)

   (setq org-hide-emphasis-markers t)
   (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\n")
   (custom-set-variables `(org-emphasis-alist ',org-emphasis-alist))

   (setq org-startup-indented t)
   (setq org-indent-indentation-per-level 1)

   (setq org-startup-with-latex-preview t)
   (setq org-startup-with-inline-images t)
   (setq org-src-fontify-natively t)
   (setq org-file-apps '((auto-mode . emacs)
                         ("\\.x?html?\\'" . default)
                         ;; ("\\.pdf\\'" . "evince %s")
                         ))
   ;; for latex export
   (setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                 "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

   ;; minted code block
   (setq org-latex-listings 'minted)
   (add-to-list 'org-latex-packages-alist '("" "minted" nil))
   (add-to-list 'org-latex-packages-alist '("" "zhfontcfg" nil))

   ;; export options
   (setq org-export-with-sub-superscripts '{})
   (setq org-export-with-section-numbers t)
   (require 'ox-publish)
   (setq org-publish-project-alist
         '(("html"
            :base-directory "~/Dropbox/org"
            :base-extension "org"
            :publishing-directory "~/Dropbox/Public/html"
            :publishing-function org-html-publish-to-html)
           ("pdf"
            :base-directory "~/Dropbox/org"
            :base-extension "org"
            :publishing-directory "~/Dropbox/org/pdf"
            :publishing-function org-latex-publish-to-pdf)
           ("all" :components ("html" "pdf"))))

   ;; default css style
   (require 'htmlize)
   (defun my-org-css-hook (exporter)
     (when (eq exporter 'html)
       (setq org-html-head-include-default-style nil)
       (setq org-html-head (concat "<link href=\"assets/css/navigator.css\" rel=\"stylesheet\" type=\"text/css\">\n"
                                   "<link href=\"assets/css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n"))))
   (add-hook 'org-export-before-processing-hook 'my-org-css-hook)

   ;; graphviz plantuml gnuplot
   (lazy-major-mode "\\.dot" graphviz-dot-mode)
   (lazy-major-mode "\\.plt" gnuplot-mode)
   (org-babel-do-load-languages
    'org-babel-load-languages
    '((dot . t)
      (sh . t)
      (gnuplot . t)
      (plantuml . t)))
   (add-to-list 'org-src-lang-modes (quote ("dot" . graphviz-dot)))
   (add-to-list 'org-src-lang-modes (quote ("gnuplot" . gnuplot)))
   (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
   (setq org-plantuml-jar-path
         (expand-file-name "~/bin/plantuml.jar"))

   ;; agenda
   (setq org-agenda-files `(,(concat org-directory "/agenda")))
   (setq org-capture-templates
         '(("t" "Todo" entry (file+headline my-inbox-org-file "INBOX")
            "* TODO %?\n%U\n%a\n")
           ("n" "Note" entry (file+headline my-inbox-org-file "NOTES")
            "* %? :NOTE:\n%U\n%a\n")
           ("m" "Meeting" entry (file my-inbox-org-file)
            "* MEETING %? :MEETING:\n%U")
           ("j" "Journal" entry (file+datetree (concat org-directory "/journal.org"))
            "* %?\n%U\n")))

   (setq org-use-fast-todo-selection t)
   (setq org-treat-S-cursor-todo-selection-as-state-change nil)
   (setq org-todo-keywords
         '((sequence "TODO(t)" "NEXT(n@)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)")))

   (setq org-todo-state-tags-triggers
         ' (("CANCELLED" ("CANCELLED" . t))
            ("WAITING" ("WAITING" . t))
            ("TODO" ("WAITING") ("CANCELLED"))
            ("NEXT" ("WAITING") ("CANCELLED"))
            ("DONE" ("WAITING") ("CANCELLED"))))

   (setq org-refile-targets '((nil :maxlevel . 9)
                              (org-agenda-files :maxlevel . 9)))

   (after 'org-mobile
     (setq org-mobile-directory (concat org-directory "/MobileOrg"))
     (unless (file-exists-p org-mobile-directory)
       (make-directory org-mobile-directory))
     (setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org")))

   (after 'evil
     (add-hook 'org-capture-mode-hook 'evil-insert-state))

   (add-hook 'org-mode-hook 'company-mode)
   (add-hook 'org-mode-hook (lambda ()
                              (when (or (executable-find "aspell")
                                        (executable-find "ispell")
                                        (executable-find "hunspell"))
                                (flyspell-mode))))))

(provide 'init-org)
