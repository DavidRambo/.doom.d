(setq user-full-name "David Rambo"
      user-mail-address "davrambo@gmail.com")

(set-face-attribute 'default nil :font "Ubuntu Mono-16")
;(set-face-attribute 'fixed-pitch nil :font "Ubuntu Mono-14")
;(set-face-attribute 'variable-pitch nil :font "Source Sans Pro")
;
;(dolist (face '(default fixed-pitch))
;  (set-face-attribute `,face nil :font "Ubuntu Mono-14"))
;(dolist (face '(default variable-pitch))
;  (set-face-attribute `,face nil :font "ETBembo"))

(setq doom-theme 'doom-gruvbox-light)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t
        doom-gruvbox-light-variant "hard"))

(after! org
 (add-hook 'org-mode-hook 'org-indent-mode)
 (setq org-directory "~/notes/"
       ;org-agenda-files (file-expand-wildcards "~/notes/*.org")
       org-agenda-files '("~/notes/tasks.org")
       org-hide-emphasis-markers t)

 (require 'org-inlinetask) ; C-c C-x t

 ;; Turn off quote block styling by toggling
 (setq org-fontify-quote-and-verse-blocks 'nil)

 (let* ((variable-tuple
          (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Ubuntu") '(:font "Ubuntu"))
                ((x-family-fonts "Serif")    '(:family "Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (headline           `(:inherit default :weight bold)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :size 16))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :size 16))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :size 18))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.1 :underline nil))))))

 (custom-theme-set-faces
  'user
  ;'(variable-pitch ((t (:family "ETBembo" :height 160 :weight thin))))
  '(variable-pitch ((t (:family "Source Sans Pro" :size 16 :weight regular))))
  '(fixed-pitch ((t ( :family "Ubuntu Mono" )))))

 (add-hook 'org-mode-hook 'variable-pitch-mode)

 (custom-theme-set-faces
   'user
;   '(org-default((t (:foreground "black"))))
   '(org-block ((t (:inherit fixed-pitch))))
   '(org-code ((t (:inherit (shadow fixed-pitch)))))
   '(org-document-info ((t (:foreground "dark orange"))))
   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
   ;'(org-link ((t (:foreground "royal blue" :underline t))))
   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-property-value ((t (:inherit fixed-pitch))) t)
   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598"))))
   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight regular :height 0.8))))
   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
)

) ; end after! org

(setq company-global-modes '(not org-mode))

(setq display-line-numbers-type nil)

;(global-linum-mode t)
;(setq linum-format "%2d ")

;(add-hook 'org-mode-hook (lambda ()
;            (setq hl-line-mode nil)))

(after! org
 (setq org-todo-keywords
       (quote ((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i)" "|" "DONE(d)")
               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING")))
  )
)

(after! org
 (setq org-todo-keyword-faces
  '(("TODO" . (:foreground "#DC322F" :weight regular))
    ("NEXT" . (:foreground "#6C71C4" :weight bold))
    ("IN-PROGRESS" . (:foreground "#2AA198" :weight bold))
    ("DONE" . (:foreground "#002B36" :weight light))
   )
 )
)

(use-package! org-superstar-mode
    :custom
    org-superstar-headline-bullets-list '("◉" "○" "⁖" "◌" "◿")
    org-superstar-first-inlinetask-bullet '("-")
 ;   org-superstar-item-bullet-alist '("•")
    :hook (org-mode . org-bullets-mode))

(setq deft-directory "~/notes/"
      deft-extensions '("org")
      deft-recursive t)

(use-package! org-journal
  :init
  (setq org-journal-dir "~/notes/journal/"
        org-journal-file-type 'daily
        org-journal-date-prefix "#+TITLE: "
        org-journal-time-prefix "* "
        org-journal-date-format "%B %d, %Y (%A) "
        org-journal-file-format "%Y-%m-%d.org")

  (setq org-journal-enable-agenda-integration nil)
)

(setq org-agenda-custom-commands
      '(("n" "Agenda and all TODOs"
         ((agenda "")
         (alltodo "")))
        ("h" "Home-related tasks" tags-todo "home"
           ((org-agenda-files '("~/notes/tasks.org"))) ; For when I expand agenda files and want this to be quick.
           )
        ("w" "Work-related tasks" tags-todo "postdoc|book")
        ("b" "Book-related tasks" tags-todo "book"))
)

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq
        org-log-done nil
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator 9472
        org-agenda-tags-column 100
        org-agenda-compact-blocks nil)
  :config
  (org-super-agenda-mode)
)

(setq org-super-agenda-groups
      '((:name "Today"
         :time-grid t
         :scheduled today
         :deadline today
         :face (:foreground "#DC322F")
         :order 1)
        (:name "In Progress"
         :todo ("IN-PROGRESS(p)")
         :face (:foreground "#2AA198")
         :order 2)
        (:name "Next"
         :todo ("NEXT(n)")
         :face (:foreground "#6C71C4")
         :order 3)
        (:order-multi (2 (:name "Work"
                          :and (:tag "postdoc"))
                         (:name "Reading"
                          :and (:tag "reading")
                          :not (:tag "postdoc")
                          :not (:tag "home"))
                         (:name "Writing"
                          :and (:tag "book" :tag "writing")
                          :not (:tag "reading"))
                      )
        )
         (:name "Remaining Tasks"
                :and (:todo "TODO"
                      :not (:todo "postdoc" :todo "IN-PROGRESS" :todo "NEXT" :todo "reading" :todo "writing")))
         (:todo "WAITING" :order 8)
       )
)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

(global-set-key (kbd "C-<prior>") #'previous-buffer)
(global-set-key (kbd "C-<next>") #'next-buffer)

(define-key evil-motion-state-map "s" 'evil-substitute)
(define-key evil-motion-state-map "S" 'evil-change-whole-line)

(map! :leader
      :desc "Writeroom-mode"
      "W" #'writeroom-mode)

(use-package writeroom-mode
  :ensure t
  :init (add-hook 'org-mode-hook 'writeroom-mode)
  :after org)

(defun open-task-file ()
  "Open tasks.org file."
  (interactive)
  (find-file-existing "~/notes/tasks.org"))
(global-set-key (kbd "C-c t") 'open-task-file)

(defun open-hours-log ()
  "Open hours-log.org file."
  (interactive)
  (find-file-existing "~/notes/hours-log.org"))
(global-set-key (kbd "C-c h") 'open-hours-log)

;(defun open-journal-entry ()
;  "Open today's journal entry."
;  (interactive)
;  (find-file-existing "~/notes/journal/%Y-%m-%d.org"))
;(global-set-key (kbd "C-c j") 'open-journal-entry)

(map! :leader
      :desc "Toggle flyspell"
      "t s" #'flyspell-mode)
