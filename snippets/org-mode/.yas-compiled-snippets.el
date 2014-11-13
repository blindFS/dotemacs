;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("graph" "#+begin_src dot :file ${1:./assets/image/}${2:xxx}.png :cmdline -Kdot -Tpng :exports ${3:results}\n$0\n#+end_src\n" "graph" nil nil nil nil nil nil)
                       ("sh" "#+begin_src sh :results output\n$0\n#+end_src\n" "sh" nil nil nil nil nil nil)
                       ("uml" "#+begin_src plantuml :file ${1:./assets/image/}${2:xxx}.png :exports ${3:results}\n$0\n#+end_src\n" "uml" nil nil nil nil nil nil)))


;;; Do not edit! File generated at Thu Nov 13 11:36:04 2014
