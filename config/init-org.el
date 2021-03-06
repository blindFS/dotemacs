(use-package org-bullets
  :ensure t
  :commands org-bullets-mode)

(use-package htmlize :ensure t)

(add-hook
 'org-load-hook
 (lambda ()
   ;; evil key bindings
   (after 'evil
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
     (evil-define-key 'insert org-mode-map
       (kbd "C-l") 'org-table-next-field))

   ;; options
   (setq org-directory "~/Dropbox/org")
   (unless (file-exists-p org-directory)
     (make-directory org-directory))

   (setq org-log-done t)
   (setq org-completion-use-ido t)

   (setq org-hide-emphasis-markers t)
   (setcar (nthcdr 2 org-emphasis-regexp-components) " \t\n")
   (custom-set-variables `(org-emphasis-alist ',org-emphasis-alist))

   (setq org-startup-indented t)
   (setq org-indent-indentation-per-level 1)

   (setq org-startup-with-latex-preview t)
   (setq org-startup-with-inline-images t)
   (setq org-pretty-entities t)
   (setq org-pretty-entities-include-sub-superscripts nil)
   (setq org-src-fontify-natively t)
   (setq org-file-apps '((auto-mode . emacs)
                         ("\\.x?html?\\'" . default)
                         ;; ("\\.pdf\\'" . "evince %s")
                         ))

   (require 'ox-latex)
   (unless (boundp 'org-latex-classes)
     (setq org-latex-classes nil))
   (setq org-latex-default-class "org-article")
   (add-to-list 'org-latex-classes
                '("org-article"
                  "\\documentclass{article}
                   \\usepackage{mathpazo}"
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                  ("\\paragraph{%s}" . "\\paragraph*{%s}")
                  ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

   ;; for latex export
   (setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                 "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

   ;; minted code block
   (setq org-latex-listings 'minted)
   (add-to-list 'org-latex-packages-alist '("" "minted" nil))
   (add-to-list 'org-latex-packages-alist '("" "zhfontcfg" nil))
   (add-to-list 'org-latex-packages-alist '("" "mathpazo" t))

   ;; export options
   (setq org-export-with-sub-superscripts '{})
   (setq org-export-with-section-numbers t)
   (require 'ox-publish)
   (setq org-publish-timestamp-directory
         (concat dotemacs-cache-directory "org-timestamps"))
   (setq org-publish-project-alist
         '(("html"
            :base-directory "~/Dropbox/org/notes"
            :base-extension "org"
            :publishing-directory "~/Dropbox/Public/html"
            :publishing-function org-html-publish-to-html)
           ("pdf"
            :base-directory "~/Dropbox/org/notes"
            :base-extension "org"
            :publishing-directory "~/Dropbox/org/pdf"
            :publishing-function org-latex-publish-to-pdf)
           ("all" :components ("html" "pdf"))))

   ;; default css style
   (defun my-org-css-hook (exporter)
     (when (eq exporter 'html)
       (setq org-html-head-include-default-style nil)
       (setq org-html-head (concat "<link href=\"assets/css/navigator.css\" rel=\"stylesheet\" type=\"text/css\">\n"
                                   "<link href=\"assets/css/style.css\" rel=\"stylesheet\" type=\"text/css\">\n"))))
   (add-hook 'org-export-before-processing-hook 'my-org-css-hook)

   ;; graphviz plantuml gnuplot
   (use-package graphviz-dot-mode
     :ensure t
     :mode "\\.dot$")

   (use-package gnuplot-mode
     :ensure t
     :mode "\\.plt$")

   (use-package ess
     :ensure t)

   (org-babel-do-load-languages
    'org-babel-load-languages
    '((dot . t)
      (sh . t)
      (R . t)
      (gnuplot . t)
      (plantuml . t)))
   (add-to-list 'org-src-lang-modes (quote ("dot" . graphviz-dot)))
   (add-to-list 'org-src-lang-modes (quote ("gnuplot" . gnuplot)))
   (add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))
   (setq org-plantuml-jar-path
         (expand-file-name "/opt/plantuml/plantuml.jar"))

   ;; GTD stuff
   (setq org-agenda-files (quote ("~/Dropbox/org/GTD/gtd.org")))
   (setq my-inbox-org-file (concat org-directory "/GTD/inbox.org"))
   (setq org-default-notes-file my-inbox-org-file)
   (setq org-capture-templates
         '(("t" "Todo" entry (file+headline my-inbox-org-file "INBOX")
            "* TODO %?\n%U\n%a\n")
           ("n" "Note" entry (file+headline my-inbox-org-file "NOTES")
            "* %? :NOTE:\n%U\n%a\n")
           ("m" "Meeting" entry (file my-inbox-org-file)
            "* MEETING %? :MEETING:\n%U")
           ("j" "Journal" entry (file+datetree (concat org-directory "/GTD/journal.org"))
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

   ;; org mobile
   (after 'org-mobile
     (setq org-mobile-directory (concat org-directory "/MobileOrg"))
     (unless (file-exists-p org-mobile-directory)
       (make-directory org-mobile-directory))
     (setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org")))

   (after 'evil
     (add-hook 'org-capture-mode-hook 'evil-insert-state))

   (defface org-decorator-face
        '((((class color) (min-colors 88) (background dark))
          :foreground "#bb79d6"))
       "for org-mode decorators."
       :group 'basic-faces)

   (font-lock-add-keywords
    'org-mode '(("^\s*\\([+-]\\|[0-9][.)]\\)\s"
                 .
                 'org-decorator-face)
                ("^\s*\\(+\\)\s"
                 1
                 (compose-region (- (match-end 0) 2)
                                 (- (match-end 0) 1)
                                 "►"))
                ("^\s*\\(-\\)\s"
                 1
                 (compose-region (- (match-end 0) 2)
                                 (- (match-end 0) 1)
                                 "◅"))))

   (add-hook 'org-mode-hook (lambda ()
                              (when (or (executable-find "aspell")
                                        (executable-find "ispell")
                                        (executable-find "hunspell"))
                                (flyspell-mode))
                              (diminish 'org-indent-mode)
                              (org-bullets-mode 1)))))

(defun dia-from-table (table)
  (cl-flet ((struct-name (x) (save-match-data
                               (and (string-match "\\(struct\\|class\\) \\([^ ]*\\)" x)
                                    (match-string 2 x)))))
    (let ((all-structs (mapcar 'car table)))
      (mapcar #'(lambda (x)
                  (let ((lhead (car x))
                        (ltail (cdr x)))
                    (princ (concat lhead " [label=\"<head> "
                                   lhead " |"
                                   (mapconcat (lambda (y)
                                                (concat " <" (replace-regexp-in-string
                                                              "\\W" "_" y) "> " y))
                                              (delq "" ltail) " | ") "\", shape=\"record\"];\n"))
                    (mapcar (lambda (y)
                              (let ((sname (struct-name y)))
                                (and (member sname all-structs)
                                     (princ (format "%s:%s -> %s:head\n"
                                                    lhead (replace-regexp-in-string
                                                           "\\W" "_" y) sname)))))
                            ltail))) table))))
(provide 'init-org)
