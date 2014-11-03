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
     (kbd "H") 'org-shiftleft
     (kbd "J") 'org-shiftdown
     (kbd "K") 'org-shiftup
     (kbd "L") 'org-shiftright
     (kbd "M-h") 'org-metaleft
     (kbd "M-j") 'org-metadown
     (kbd "M-k") 'org-metaup
     (kbd "M-l") 'org-metaright
     (kbd "M-H") 'org-shiftmetaleft
     (kbd "M-J") 'org-shiftmetadown
     (kbd "M-K") 'org-shiftmetaup
     (kbd "M-L") 'org-shiftmetaright)

   (setq org-directory "~/Dropbox/org")
   (unless (file-exists-p org-directory)
     (make-directory org-directory))

   (setq my-inbox-org-file (concat org-directory "/inbox.org"))

   (setq org-default-notes-file my-inbox-org-file)
   (setq org-log-done t)

   (setq org-startup-indented t)
   (setq org-indent-indentation-per-level 3)

   (setq org-startup-with-latex-preview t)
   (setq org-startup-with-inline-images t)
   (setq org-src-fontify-natively t)

   ;; for latex export
   (setq org-latex-pdf-process '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                                 "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

   ;; minted code block
   (setq org-latex-listings 'minted)

   (setq org-agenda-files `(,org-directory))
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
   (setq org-completion-use-ido t)

   (after 'org-mobile
     (setq org-mobile-directory (concat org-directory "/MobileOrg"))
     (unless (file-exists-p org-mobile-directory)
       (make-directory org-mobile-directory))
     (setq org-mobile-inbox-for-pull (concat org-directory "/from-mobile.org")))

   (after 'evil
     (add-hook 'org-capture-mode-hook 'evil-insert-state))

   (when (boundp 'org-plantuml-jar-path)
     (org-babel-do-load-languages
      'org-babel-load-languages
      '((plantuml . t))))

   (add-hook 'org-mode-hook (lambda ()
                              (when (or (executable-find "aspell")
                                        (executable-find "ispell")
                                        (executable-find "hunspell"))
                                (flyspell-mode))))))


(provide 'init-org)
