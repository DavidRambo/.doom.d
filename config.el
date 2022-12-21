(setq user-full-name "David Rambo"
      user-mail-address "davidrambo@mailfence.com")

(cond ((eq system-type 'gnu/linux)
        (setq doom-font (font-spec :family "SauceCodePro NF" :size 14.0)
            doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 16.0 :weight 'regular)
            doom-serif-font (font-spec :family "DejaVu Serif" :size 16.0)
            doom-big-font (font-spec :size 28.0))
       )
      ((eq system-type 'darwin)
        (setq doom-font (font-spec :family "SauceCodePro Nerd Font Mono" :size 16.0)
            doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 18.0 :weight 'regular)
            doom-serif-font (font-spec :family "PT Serif" :size 16.0)
            doom-big-font (font-spec :size 28.0))
       ))

(setq doom-theme 'doom-vibrant)

;(cond ((eq system-type 'gnu/linux)
;        (setq doom-theme 'doom-gruvbox)
;            (after! doom-themes
;            (setq doom-themes-enable-bold t
;                    doom-themes-enable-italic t
;                    doom-gruvbox-light-variant "hard"
;                    doom-gruvbox-dark-variant "medium"))
;       ))
;
;(cond ((eq system-type 'darwin)
;        (setq doom-theme 'doom-one)
;       ))

(setq fringe-mode 'default
      display-line-numbers-type 'relative)

(defun dr/display-line-numbers-hook ()
  (display-line-numbers-mode 1)
  )
(add-hook 'prog-mode-hook 'dr/display-line-numbers-hook)
(add-hook 'text-mode-hook 'dr/display-line-numbers-hook)

(defun dr/disable-line-numbers-hook ()
  (display-line-numbers-mode 0)
  )
(add-hook 'org-mode-hook 'dr/disable-line-numbers-hook)

(setq global-hl-line-mode 't)

(setq  evil-want-fine-undo t
       undo-limit 80000000)

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit evil-window-new)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(setq split-height-threshold nil)
(setq split-width-threshold 0)

(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
         (next-win-buffer (window-buffer (next-window)))
         (this-win-edges (window-edges (selected-window)))
         (next-win-edges (window-edges (next-window)))
         (this-win-2nd (not (and (<= (car this-win-edges)
                     (car next-win-edges))
                     (<= (cadr this-win-edges)
                     (cadr next-win-edges)))))
         (splitter
          (if (= (car this-win-edges)
             (car (window-edges (next-window))))
          'split-window-horizontally
        'split-window-vertically)))
    (delete-other-windows)
    (let ((first-win (selected-window)))
      (funcall splitter)
      (if this-win-2nd (other-window 1))
      (set-window-buffer (selected-window) this-win-buffer)
      (set-window-buffer (next-window) next-win-buffer)
      (select-window first-win)
      (if this-win-2nd (other-window 1))))))

(global-set-key (kbd "C-x |") 'toggle-window-split)

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

(use-package dired
  :ensure nil
  :commands dired dired-jump
  :custom ((dired-listing-switches -agho --group-directories-first))
  :config
     (evil-collection-define-key 'normal 'dired-mode-map
      "h" 'dired-single-up-directory
      "l" 'dired-single-buffer))

;(use-package git-gutter
;  :config
;  (setq git-gutter-mode nil))

(use-package centered-cursor-mode
  :init
  (setq ccm-recenter-at-end-of-file t)
  )

(map! :desc "centered cursor mode"
      "C-c c" #'centered-cursor-mode)

(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up)))

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
      (setq variable-pitch (font-spec :family "SauceCodePro Nerd Font"))
      (cond ((eq system-type 'gnu/linux)
            (set-face-attribute 'variable-pitch nil :height 160)
             )
            ((eq system-type 'darwin)
            (set-face-attribute 'variable-pitch nil :height 180)
             )
        )

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
  (cond ((eq system-type 'gnu/linux)
        (setq variable-pitch-serif-font (font-spec :family "Palatino Linotype" :size 18.0))
       )
      ((eq system-type 'darwin)
        (setq variable-pitch-serif-font (font-spec :family "Palatino" :size 18.0)))
  )
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
 (setq org-ellipsis " ▾ "
       ;org-agenda-files (file-expand-wildcards "~/notes/*.org")
       org-agenda-files '("~/notes/tasks.org")
       org-hide-emphasis-markers t
       org-startup-folded 'content
       ;line-spacing 0.3
       org-bullets-face-name doom-font
       ;; display-line-numbers-type nil
       hl-line-mode nil
       org-indent-indentation-per-level 1
       )

 (custom-set-faces
  ;; '(org-block ((t (:inherit doom-font) :size 14)))
  ;; '(org-quote ((t (:inherit shadow :slant normal))))
  '(org-indent ((t (:inherit (org-hide fixed-pitch)))))
  '(org-document-title ((t (:inherit default :weight bold :height 1.1 :underline nil))))
;  '(org-document-info ((t (:foreground "dark orange"))))
  '(line-number-current-line ((t (:inherit (hl-line default) :strike-through nil :underline nil :slant normal :weight normal))))
  '(org-tag ((t (:inherit (shadow fixed-pitch) :weight regular :height 1.0))))
  '(org-property-value ((t (:inherit (fixed-pitch) :weight regular :height 1.0))))
  '(org-special-keyword ((t (:inherit (fixed-pitch) :weight regular :height 1.0))))
;  '(org-super-agenda-header ((t (:foreground "#076678"))))
  '(org-agenda-structure ((t (:foreground "#076678"))))
 )

 (require 'org-inlinetask) ; C-c C-x t
) ; end after! org

(after! org
    (setq company-global-modes '(not org-mode)))

;(add-hook 'org-mode-hook (lambda ()
;            (setq hl-line-mode nil)))

(after! org
  (setq
        ;; org-fontify-quote-and-verse-blocks 'nil
        org-fontify-done-headline t
        org-fontify-todo-headline t)
  )

(after! org
 (setq org-todo-keywords
       (quote ((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i)" "|" "DONE(d)")
               (sequence "READ(r)" "READING(g)" "|" "DONE(d)")
               (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "MEETING")))
  )
 (setq org-lowest-priority ?C) ;; This is the default.
)

(after! org
 (setq org-todo-keyword-faces
  '(("TODO" . (:foreground "#FB4934" :weight regular))
    ("NEXT" . (:foreground "#458588" :slant italic))
    ("IN-PROGRESS" . (:foreground "#076678" :slant italic))
    ("DONE" . (:foreground "#8EC07C" :weight light :strike-through t))
    ("READ" . (:foreground "#b16286" :weight regular))
    ("READING" . (:foreground "#8f3f71" :weight regular))
    ("WAITING" . (:foreground "black" :weight light))
   )
 )
)

(use-package! org-superstar-mode
  :custom
    org-superstar-headline-bullets-list '("◉" "○" "◌" "⁖" "◿")
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
                  ("READ" .  )
                  ("READING" . 龎 )
                  ;; (" READ" . 9744)
                  ;; (" READING" . )
                  ("NEXT" . 9744)
                  ("IN-PROGRESS" . ))
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
                          ("[-]" . "❍")
                          ("[X]" . "☑"))
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
        org-journal-time-format "%I:%M %p\n"
        org-journal-file-format "%Y-%m-%d.org")

  (setq org-journal-enable-agenda-integration nil)
)

(defun fw/agenda-icon-octicon (name)
  "Returns an all-the-icons-octicon icon"
  (list (all-the-icons-octicon name)))

(defun fw/agenda-icon-faicon (name)
  "Returns an all-the-icons-faicon icon"
  (list (all-the-icons-faicon name)))

;; The strings listed first ("Postdoc", etc.) refer to the categories under headings in my tasks.org file.
;; https://old.reddit.com/r/emacs/comments/hnf3cw/my_orgmode_agenda_much_better_now_with_category/
(setq org-agenda-category-icon-alist
      `(("Postdoc" ,(fw/agenda-icon-octicon "pencil") nil nil :ascent center)
        ("Coding" ,(fw/agenda-icon-faicon "code") nil nil :ascent center)
        ("FRG" ,(fw/agenda-icon-octicon "book") nil nil :ascent center)
        ("Home" ,(fw/agenda-icon-octicon "home") nil nil :ascent center)
        ("Habits" ,(fw/agenda-icon-faicon "calendar-check-o") nil nil :ascent center)
        ))

(setq org-agenda-custom-commands
  '(
    ("n" "In-Progress and Next Tasks"
     (
        (todo "IN-PROGRESS|READING"
                ((org-agenda-overriding-header "\nIn-Progress Tasks\n-----------------")
                (org-agenda-prefix-format "   %i %?-2 t%s")
                (org-agenda-remove-tags t)))
        (todo "NEXT"
                ((org-agenda-overriding-header "\nNext Tasks\n----------")
                (org-agenda-prefix-format "   %i %?-2 t%s")
                (org-agenda-remove-tags t)))
        (agenda "" (
                (org-deadline-warning-days 8)
                (org-agenda-remove-tags t)
                (org-agenda-current-time-string "ᐊ┈┈┈┈┈┈┈ Now")
                (org-agenda-overriding-header "\nSchedule\n--------")))))

    ("h" "Home-related tasks"
       (tags-todo "home"
        ((org-agenda-overriding-header "Home Tasks")
        (org-agenda-remove-tags t)
        ))
     )

    ("w" "Work-related tasks"
     (
      (tags-todo "+postdoc-jobs"
        ((org-agenda-overriding-header "\nPostdoc Tasks")))
      (tags-todo "book"
        ((org-agenda-overriding-header "\nBook Tasks")))
      (tags-todo "jobs"
        ((org-agenda-overriding-header "\nJob Application Tasks")))
     ))

    ("b" "Book-related tasks"
     ( tags-todo "book"
        ((org-agenda-overriding-header "\nBook Tasks")
        (org-agenda-remove-tags t)
        )
     ))

    ("r" "Reading Tasks"
     ((todo "READING"
        ((org-agenda-overriding-header "\nCurrently Reading")
        (org-agenda-remove-tags t)
        ))
      (todo "READ"
        ((org-agenda-overriding-header "\nTo Read")
        (org-agenda-remove-tags t)
        ))
      ))
))

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq
        org-log-done nil
        org-agenda-start-day nil
        org-agenda-span 7
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t
        org-agenda-block-separator 9472
        org-agenda-tags-column 100
        org-agenda-compact-blocks nil
        org-agenda-dim-blocked-tasks nil
        org-agenda-start-on-weekday nil
        org-super-agenda-groups nil
        )
  :config
  (org-super-agenda-mode)
)

;(setq org-super-agenda-groups
;      '((:name "Today"
;         :time-grid t
;         :scheduled today
;         :deadline today
;         :face (:foreground "#DC322F")
;         :order 1)
;        (:name "In Progress"
;         :todo ("IN-PROGRESS(p)")
;         :face (:foreground "#2AA198")
;         :order 2)
;        (:name "Next"
;         :todo ("NEXT(n)")
;         :face (:foreground "#6C71C4")
;         :order 3)
;        (:name "To Do"
;         :todo ("TODO(t)")
;         :face (:foreground "#DC322F")
;         :order 4)
;        (:order-multi (5 (:name "Work"
;                          :and (:tag "postdoc" :tag "book"))
;                         (:name "Writing"
;                          :and (:tag "book" :tag "writing"))
;                         (:name "Reading"
;                          :and (:tag "reading"))
;                         (:name "Home"
;                          :and (:tag "home"))
;                      )
;        )
;;         (:name "Remaining Tasks"
;;                :and (:todo "TODO"
;;                      :not (:todo "postdoc" :todo "IN-PROGRESS" :todo "NEXT" :todo "reading" :todo "writing")))
;         (:todo "WAITING" :order 8)
;       )
;)

(use-package hide-mode-line)

(defun efs/presentation-setup ()
  ;; Hide the mode line
  (hide-mode-line-mode 1)

  ;; Display images inline
  (org-display-inline-images) ;; Can also use org-startup-with-inline-images

  ;; Scale the text.  The next line is for basic scaling:
  (setq text-scale-mode-amount 2)
  (text-scale-mode 1))

  ;; This option is more advanced, allows you to scale other faces too
  ;; (setq-local face-remapping-alist '((default (:height 2.0) variable-pitch)
  ;;                                    (org-verbatim (:height 1.75) org-verbatim)
  ;;                                    (org-block (:height 1.25) org-block))))

(defun efs/presentation-end ()
  ;; Show the mode line again
  (hide-mode-line-mode 0)

  ;; Turn off text scale mode (or use the next line if you didn't use text-scale-mode)
  (text-scale-mode 0))

  ;; If you use face-remapping-alist, this clears the scaling:
 ; (setq-local face-remapping-alist '((default variable-pitch default))))

(use-package org-tree-slide
  :hook ((org-tree-slide-play . efs/presentation-setup)
                (org-tree-slide-stop . efs/presentation-end))
  :custom
  (org-tree-slide-slide-in-effect t)
  (org-tree-slide-activate-message "Presentation started!")
  (org-tree-slide-deactivate-message "Presentation finished!")
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " > ")
  (org-image-actual-width nil)
  (org-tree-slide-skip-outline-level 4))

(use-package org-roam
  ;:ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/notes")
  (org-roam-capture-templates
   '(("d" "default" plain
      "#+filetags: %?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
      :unnarrowed t)))

  (org-roam-node-display-template
          (concat "${title:*} "
                  (propertize "${tags:10}" 'face 'org-tag)))
  :config
  (org-roam-setup))

(map! :leader
      (:prefix-map ("r" . "Org-Roam commands")
       :desc "Toggle org-roam buffer"
       "t" #'org-roam-buffer-toggle
       :desc "Find or Create Node"
       "f" #'org-roam-node-find
       :desc "Insert Node"
       "i" #'org-roam-node-insert
       :desc "Create id for heading node"
       "c" #'org-id-get-create
       :desc "Add alias for node"
       "a" #'org-roam-alias-add
       )
      )

(setq org-clock-sound "~/.doom.d/pomo_bell.wav")

(after! org
  (setq org-export-with-toc nil))

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
              '("org-plain-latex"
                "\\documentclass{article}
                [NO-DEFAULT-PACKAGES]
                [PACKAGES]
                [EXTRA]"
                        ("\\section{%s}" . "\\section*{%s}")
                        ("\\subsection{%s}" . "\\subsection*{%s}")
                        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                        ("\\paragraph{%s}" . "\\paragraph*{%s}")
                        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(use-package python
  ;:ensure t
  :custom
    (python-shell-interpreter "python3")
)

;(add-hook  'python-mode-hook
;           (lambda () (setq-local display-line-numbers-type t)))
;(add-hook 'python-mode-hook 'display-line-numbers-mode t)

(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-mode)

(setq py-autopep8-options '("--max-line-length=90" "--aggressive"))

(map! :leader
      :desc "Toggle narrow subtree"
      "t n" #'org-toggle-narrow-to-subtree)

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
  (setq avy-keys '(?t ?e ?i ?s ?r ?o ?a ?n)))

(setq fill-column 85)

(defun center-visual-fill ()
  (setq visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook 'visual-line-mode-hook #'center-visual-fill)

(map! :leader
      :desc "visual-fill-column-mode"
;      "W" #'writeroom-mode)
      "W" #'visual-fill-column-mode)

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

;(map! :leader
;      :desc "Toggle org-sidebar-tree"
;      "t s" #'org-sidebar-tree-toggle)
