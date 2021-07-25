(setq user-full-name "David Rambo"
      user-mail-address "davrambo@gmail.com")

(setq  evil-want-fine-undo t
       undo-limit 80000000)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit evil-window-new)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :height 140)
      doom-variable-pitch-font (font-spec :family "Source Sans Pro" :height 160))

(setq doom-theme 'doom-gruvbox-light)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t
        doom-gruvbox-light-variant "hard"))

;(custom-theme-set-faces! 'doom-gruvbox
;  '(org-level-1 :foreground #076678)
;  '(org-level-2 :foreground #b57614)
;  '(org-level-3 :foreground #8f3f71)
;  '(org-level-4 :foreground #9d0006)
;  '(org-level-5 :foreground #79740e)
;  '(org-level-6 :foreground #427b58)
;  '(org-level-7 :foreground #458588)
;  '(org-level-8 :foreground #af3a03)
;  )

(setq +modeline-height 22)

(use-package! mixed-pitch
  :hook (org-mode . mixed-pitch-mode)
  :config
        (setq mixed-pitch-set-height t)
        (set-face-attribute 'variable-pitch nil :height 160)
        )

(setq org-directory "~/notes/")

(after! org
 (add-hook 'org-mode-hook 'org-indent-mode)
 (setq
       ;org-agenda-files (file-expand-wildcards "~/notes/*.org")
       org-agenda-files '("~/notes/tasks.org")
       org-hide-emphasis-markers t)

 (require 'org-inlinetask) ; C-c C-x t

; (let* ((variable-tuple
;          (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
;                ((x-list-fonts "Ubuntu") '(:font "Ubuntu"))
;                ((x-family-fonts "Serif")    '(:family "Serif"))
;                (nil (warn "Cannot find a Sans Serif Font. Install Source Sans Pro."))))
;         (headline           `(:inherit default :weight bold))
;        )
;
;    (custom-theme-set-faces
;     'user
;;     `(org-level-8 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-7 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-6 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-5 ((t (,@headline ,@variable-tuple))))
;;     `(org-level-4 ((t (,@headline ,@variable-tuple))))
;     `(org-level-3 ((t (,@headline :size 16))))
;     `(org-level-2 ((t (,@headline :size 16))))
;     `(org-level-1 ((t (,@headline :size 18))))
;     `(org-document-title ((t (,@headline ,@variable-tuple :height 1.1 :underline nil)))))
; ) ; end (let*)

; (custom-theme-set-faces
;  'user
;  '(variable-pitch ((t (:family "Source Sans Pro" :size 14 :weight regular))))
;  '(fixed-pitch ((t ( :family "SauceCodePro Nerd Font" :size 12 :weight regular )))))

; (custom-theme-set-faces
;   'user
;;   '(org-default((t (:foreground "black"))))
;   '(org-block ((t (:inherit doom-font))))
;   '(org-code ((t (:inherit (shadow fixed-pitch)))))
;   '(org-document-info ((t (:foreground "dark orange"))))
;   '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
;   '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
;   ;'(org-link ((t (:foreground "royal blue" :underline t))))
;   '(org-meta-line ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;   '(org-property-value ((t (:inherit fixed-pitch :size 14))) t)
;   '(org-special-keyword ((t (:inherit (font-lock-comment-face fixed-pitch)))))
;   '(org-table ((t (:inherit fixed-pitch :foreground "#83a598" :size 12))))
;   '(org-tag ((t (:inherit (shadow fixed-pitch) :weight regular :height 0.8))))
;   '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
;) ; end custom-theme-set-faces
) ; end after! org

(after! org
    (setq company-global-modes '(not org-mode)))

(after! org
    (setq org-fontify-quote-and-verse-blocks 'nil
          org-fontify-done-headline t))

(setq display-line-numbers-type t)

; Disable line numbers for certain modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

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
    ("DONE" . (:foreground "#427b58" :weight light))
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
        ("b" "Book-related tasks" tags-todo "book")
        ("r" "Reading tasks" tags-todo "reading"))
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
        org-agenda-compact-blocks nil
        )
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
        (:name "To Do"
         :todo ("TODO(t)")
         :face (:foreground "#DC322F")
         :order 4)
        (:order-multi (5 (:name "Work"
                          :and (:tag "postdoc"))
                         (:name "Writing"
                          :and (:tag "book" :tag "writing"))
                         (:name "Reading"
                          :and (:tag "reading"))
                         (:name "Home"
                          :and (:tag "home"))
                      )
        )
;         (:name "Remaining Tasks"
;                :and (:todo "TODO"
;                      :not (:todo "postdoc" :todo "IN-PROGRESS" :todo "NEXT" :todo "reading" :todo "writing")))
         (:todo "WAITING" :order 8)
       )
)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(define-key evil-normal-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-next-line>") 'evil-next-visual-line)
(define-key evil-motion-state-map (kbd "<remap> <evil-previous-line>") 'evil-previous-visual-line)
; Make horizontal movement cross lines
(setq-default evil-cross-lines t)

(define-key evil-motion-state-map "s" 'evil-substitute)
(define-key evil-motion-state-map "S" 'evil-change-whole-line)

(global-set-key (kbd "C-<prior>") #'previous-buffer)
(global-set-key (kbd "C-<next>") #'next-buffer)

(map! :map evil-window-map
      "SPC" #'rotate-layout
      ;; Navigation
      "<left>"  #'evil-window-left
      "<down>"  #'evil-window-down
      "<up>"    #'evil-window-up
      "<right>" #'evil-window-right
      ;; Swapping windows
      "C-<left>"      #'+evil/window-move-left
      "C-<down>"      #'+evil/window-move-down
      "C-<up>"        #'+evil/window-move-up
      "C-<right>"     #'+evil/window-move-right)

(use-package writeroom-mode
  :config
  (setq writeroom-fullscreen-effect nil
        writeroom-mode-line t
        writeroom-width 80)
    )

(map! :leader
      :desc "Writeroom-mode"
      "W" #'writeroom-mode)

;(use-package writeroom-mode
;  :ensure t
;  :init (add-hook 'org-mode-hook 'writeroom-mode)
;  :after org)

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
