(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers-width 5)
 '(org-agenda-files '("~/notes/tasks.org"))
 '(org-agenda-sorting-strategy
   '((agenda habit-up time-up priority-down category-keep)
     (todo priority-down category-keep)
     (tags priority-down category-keep)
     (search category-keep)))
 '(org-super-agenda-groups
   '((:name "Today" :time-grid t :scheduled today :deadline today :face
      (:foreground "#DC322F")
      :order 1)
     (:name "In Progress" :todo
      ("IN-PROGRESS")
      :face
      (:foreground "#2AA198")
      :order 2)
     (:name "Next" :todo
      ("NEXT")
      :face
      (:foreground "#6C71C4")
      :order 3)
     (:order-multi
      (2
       (:name "Work" :and
        (:tag "postdoc")
        :order 2)
       (:name "Reading" :and
        (:tag "reading")
        :not
        (:tag "postdoc")
        :order 2)
       (:name "Writing" :and
        (:tag "book" :tag "writing")
        :not
        (:tag "reading")
        :order 2)))
     (:name "Remaining Tasks" :and
      (:todo "TODO" :not
       (:todo "postdoc" :todo "IN-PROGRESS" :todo "NEXT" :todo "reading" :todo "writing")))
     (:todo "WAITING" :order 8)))
 '(org-super-agenda-header-properties
   '(face org-super-agenda-header org-agenda-structural-header t))
 '(writeroom-global-effects
   '(writeroom-set-alpha writeroom-set-menu-bar-lines writeroom-set-tool-bar-lines writeroom-set-vertical-scroll-bars writeroom-set-bottom-divider-width)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number-current-line ((t (:inherit (hl-line default) :foreground "#d65d0e" :strike-through nil :underline nil :slant normal :weight normal))))
 '(org-block ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit (shadow fixed-pitch)))))
 '(org-default ((t (:foreground "black"))))
 '(org-document-info ((t (:foreground "dark orange"))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-document-title ((t (:inherit default :weight bold :font "Source Sans Pro" :height 1.1 :underline nil))))
 '(org-headline-done ((t (:foreground "#427b58" :strike-through nil :weight thin))))
 '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
 '(org-level-1 ((t (:inherit default :weight bold :font "Source Sans Pro" :size 16))))
 '(org-level-2 ((t (:inherit default :weight bold :font "Source Sans Pro" :size 14))))
 '(org-level-3 ((t (:inherit default :weight bold :font "Source Sans Pro" :size 14))))
 '(org-level-4 ((t (:inherit default :weight bold :font "Source Sans Pro"))))
 '(org-level-5 ((t (:inherit default :weight bold :font "Source Sans Pro"))))
 '(org-level-6 ((t (:inherit default :weight bold :font "Source Sans Pro"))))
 '(org-level-7 ((t (:inherit default :weight bold :font "Source Sans Pro"))))
 '(org-level-8 ((t (:inherit default :weight bold :font "Source Sans Pro"))))
 '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-property-value ((t (:inherit fixed-pitch))) t)
 '(org-quote ((t (:extend t))))
 '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-super-agenda-header ((t (:inherit org-agenda-structure :foreground "#6C71C4" :height 1.1))))
 '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
 '(org-tag ((t (:inherit (shadow fixed-pitch) :weight regular :height 0.8))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch))))))
