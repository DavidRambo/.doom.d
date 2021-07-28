(setq user-full-name "David Rambo"
      user-mail-address "davrambo@gmail.com")

(setq doom-font (font-spec :family "SauceCodePro Nerd Font" :height 140)
      doom-variable-pitch-font (font-spec :family "Source Sans Pro" :height 160 :weight 'regular)
      doom-serif-font (font-spec :family "DejaVu Serif" :height 160))

(setq doom-theme 'doom-gruvbox-light)
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t
        doom-gruvbox-light-variant "hard"))

;(custom-set-faces!
;  '(doom-modeline-buffer-modified :foreground "orange"))

(setq  evil-want-fine-undo t
       undo-limit 80000000)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit evil-window-new)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(use-package vterm
  :commands vterm
  :config
  (setq term-prompt-regex "^[^#$%>\n]*[#$%>] *")
  ;(setq vterm-max-scrollback 10000)
)

(use-package eterm-256color
  :hook (vterm-mode . eterm-256color-mode))

(setq +modeline-height 22)

;; From hlissner's private config:
(after! ivy
  ;; I prefer search matching to be ordered; it's more precise
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus)))

;(use-package! mixed-pitch
;  :hook (org-mode . mixed-pitch-mode)
;  :config
;        (setq mixed-pitch-set-height t)
;        (set-face-attribute 'variable-pitch nil :height 160)
;        )

(defvar mixed-pitch-modes '(org-mode LaTeX-mode markdown-mode)
  "Modes that `mixed-pitch-mode' should be enabled in, but only after UI initialisation.")
(defun init-mixed-pitch-h ()
  "Hook `mixed-pitch-mode' into each mode in `mixed-pitch-modes'.
Also immediately enables `mixed-pitch-modes' if currently in one of the modes."
  (when (memq major-mode mixed-pitch-modes)
    (mixed-pitch-mode 1))
  (dolist (hook mixed-pitch-modes)
    (add-hook (intern (concat (symbol-name hook) "-hook")) #'mixed-pitch-mode)))
(add-hook 'doom-init-ui-hook #'init-mixed-pitch-h)

(autoload #'mixed-pitch-serif-mode "mixed-pitch"
  "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch." t)

(after! mixed-pitch

      (setq mixed-pitch-set-height t)
      (set-face-attribute 'variable-pitch nil :height 160)
  (defun mixed-pitch-sans-mode (&optional arg)
    "Change the default face of the current buffer to a sans-serif variable pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch))
      (mixed-pitch-mode (or arg 'toggle))))

  (defface variable-pitch-serif
    '((t (:family "serif")))
    "A variable-pitch face with serifs."
    :group 'basic-faces)

  (setq mixed-pitch-set-height t)
  (setq variable-pitch-serif-font (font-spec :family "Palatino Linotype" :size 18))
  (set-face-attribute 'variable-pitch-serif nil :font variable-pitch-serif-font)

  (defun mixed-pitch-serif-mode (&optional arg)
    "Change the default face of the current buffer to a serifed variable pitch, while keeping some faces fixed pitch."
    (interactive)
    (let ((mixed-pitch-face 'variable-pitch-serif))
      (mixed-pitch-mode (or arg 'toggle))))
)

(setq org-directory "~/notes/")

(after! org
 (add-hook 'org-mode-hook 'org-indent-mode)
 (setq
       ;org-agenda-files (file-expand-wildcards "~/notes/*.org")
       org-agenda-files '("~/notes/tasks.org")
       org-hide-emphasis-markers t
       org-startup-folded 'content
;       line-spacing 0.3
       org-bullets-face-name doom-font
       )

 (custom-set-faces
  '(org-block ((t (:inherit doom-font) :size 14)))
  ;'(org-code ((t (:inherit shadow doom-font))))
 ; '(org-code ((t (:inherit doom-font))))
  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
  '(org-document-title ((t (:inherit default :weight bold :height 1.1 :underline nil))))
;  '(org-document-info ((t (:foreground "dark orange"))))
  '(line-number-current-line ((t (:inherit (hl-line default) :background "none" :strike-through nil :underline nil :slant normal :weight normal))))
  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight regular :height 0.8))))
  '(org-property-value ((t (:inherit (fixed-pitch) :weight regular :height 0.8))))
 )

 (require 'org-inlinetask) ; C-c C-x t

) ; end after! org

(after! org
    (setq company-global-modes '(not org-mode)))

(after! org
  (setq org-fontify-quote-and-verse-blocks 'nil
        org-fontify-done-headline t
        org-fontify-todo-headline t)
  )

(setq display-line-numbers-type nil)

; Disable line numbers for certain modes
;(dolist (mode '(org-mode-hook
;                term-mode-hook
;                eshell-mode-hook))
;  (add-hook mode (lambda () (display-line-numbers-mode 'relative))))

;(add-hook 'org-mode-hook (lambda ()
;            (setq hl-line-mode nil)))

(after! org
 (setq org-todo-keywords
       (quote ((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i)" "|" "DONE(d)")
               (sequence " READ(r)" " READING(g)" "|" "DONE(d)")
               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING")))
  )
 (setq org-lowest-priority ?C) ;; This is the default.
)

(after! org
 (setq org-todo-keyword-faces
  '(("TODO" . (:foreground "#FB4934" :weight regular))
    ("NEXT" . (:foreground "#B16286" :slant italic))
    ("IN-PROGRESS" . (:foreground "#458588" :slant italic))
    ("DONE" . (:foreground "#8EC07C" :weight light :strike-through t))
    (" READ" . (:foreground "#D79921" :weight light))
    (" READING" . (:foreground "#FABD2F" :weight regular))
    ("WAITING" . (:foreground "black" :weight light))
   )
 )
)

(use-package! org-superstar-mode
  :custom
    org-superstar-headline-bullets-list '("◉" "○" "⁖" "◌" "◿")
    org-superstar-first-inlinetask-bullet '("-")
    org-superstar-remove-leading-stars
  :hook (org-mode . org-bullets-mode))

(after! org-superstar
  (setq org-superstar-special-todo-items t
        org-superstar-todo-bullet-alist
                '(("TODO" . 9744)
                  ("[ ]" . 9744)
                  ("DONE" . 9745)
                  ("[X]" . 9745)
                  (" READ" . ? )
                  (" READING" . ?龎 )
                  ("NEXT" . 9744)
                  ("IN-PROGRESS" . ?))
        org-superstar-item-bullet-alist
                '((?* . ?•)
                  (?+ . ?○)
                  (?- . ?–))
    )
)

(use-package! prettify-symbols-mode
  :custom
; ; (push '("[ ]" .  "☐") prettify-symbols-alist)
  prettify-symbols-alist '(("[ ]" . "☐")
                          ("[X]" . "☑")
                          ("[-]" . "❍"))
  :hook (org-mode . prettify-symbols-mode)
)

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
        ("h" "Home-related tasks" tags "home"
           ((org-agenda-files '("~/notes/tasks.org"))) ; For when I expand agenda files and want this to be quick.
           )
        ("w" "Work-related tasks" tags "postdoc|book")
        ("b" "Book-related tasks" tags "book")
        ("r" "Reading tasks" tags "reading"))
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
        org-agenda-dim-blocked-tasks nil
        org-agenda-start-on-weekday 0
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

(after! avy
  ;; home row priorities: 8 6 4 5 - - 1 2 3 7
  (setq avy-keys '(?n ?e ?i ?s ?t ?r ?o ?a)))

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
