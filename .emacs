;General userinterface and appearance

 (tool-bar-mode -1)                             ; No toolbar
 (menu-bar-mode -1)                             ; No menubar
 (define-key menu-bar-tools-menu [games] nil)   ; Remove games menu
 (scroll-bar-mode -1)                           ; No scrollbar
 (set-scroll-bar-mode 'right)                   ; Scrollbar on the right
 (setq inhibit-startup-message t)               ; No message at startup
 (setq visible-bell t)                          ; No beep when reporting errors
 (global-font-lock-mode 1)                      ; Color enabled
 (set-background-color "darkblue")              ; Background color
 ;(set-face-background 'region "gray80")         ; Color for selected lines
 (global-hl-line-mode t)                        ; Highlight cursor line
 (add-to-list 'default-frame-alist '(font . "")); Change fonts

;Cursor and mouse

 (blink-cursor-mode 0)                          ; No blinking cursor
 (setq track-eol nil)                           ; Cursor don't track end-of-line
 (setq mouse-yank-at-point t)                   ; Paste at cursor position
 (setq scroll-preserve-screen-position t)       ; Scroll without moving cursor
 (mouse-avoidance-mode 'jump)                   ; Mouse avoids cursor
 (set-cursor-color "black")                     ; Cursor color
 (column-number-mode t)                         ; Show column number in mode-line
 (mouse-wheel-mode t)                           ; Mouse-wheel enabled

;Customization for your locale, environment and computer.

 (setq european-calendar-style 't)              ; European style calendar
 (setq calendar-week-start-day 1)               ; Week starts monday
 (setq ps-paper-type 'a4)                       ; Specify printing format
 (setq ispell-dictionary "english")             ; Set ispell dictionary
 (setq shell-file-name "/bin/bash")             ; Set Shell for M-| command
 (setq tex-shell-file-name "/bin/bash")         ; Set Shell used by TeX
 (setq grep-command "grep -i -nH -e ")          ; Set grep command options
 (setq exec-path (append exec-path '("/bin")))  ; Change binary path

;Files and sessions

 ;(setq auto-save-timeout 60)                    ; Autosave every minute
 (desktop-save-mode t)                          ; Save session before quitting
 (setq confirm-kill-emacs 'yes-or-no-p)         ; Confirm quit
 ;(speedbar t)                                   ; Quick file access with bar
 (setq make-backup-files nil)                   ; No backup files ~
 (setq read-file-name-completion-ignore-case 't); Ignore case when completing file names

;Tabs, spaces, lines and parenthesis

 (setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
 (setq tab-width 4)                             ; Length of tab is 4 SPC
 (setq sentence-end-double-space nil)           ; Sentences end with one space
 (setq truncate-partial-width-windows nil)      ; Don't truncate long lines
 (setq-default indicate-empty-lines t)          ; Show empty lines
 (setq next-line-add-newlines t)                ; Add newline when at buffer end
 (setq require-final-newline 't)                ; Always newline at end of file
 (global-linum-mode 1)                          ; Show line numbers on buffers
 (show-paren-mode 1)                            ; Highlight parenthesis pairs
 (setq blink-matching-paren-distance nil)       ; Blinking parenthesis
; (setq show-paren-style 'expression)            ; Highlight text between parens

;Buffers and windows

 (setq pop-up-frame t)                          ; Buffers in separate frames
 (setq frame-title-format "%b - emacs")         ; Use buffer name as frame title
 (global-set-key "\C-x\C-b" 'buffer-menu)       ; CxCb puts point on buffer list
 (setq window-min-height 10)                    ; Minimal height of windows
 (setq enable-recursive-minibuffers t)          ; Stack  minibuffers
 (icomplete-mode t)                             ; Completion in mini-buffer
 (setq read-buffer-completion-ignore-case 't)   ; Ignore case when completing buffer names
 (windmove-default-keybindings)                 ; Shift arrows switch windows
                                                ; Note: This interferes with
                                                ;  cua-mode where shift arrow starts
                                                ;  marking. An alternative is
                                                ;  (windmove-default-keybindings 'meta)
 (setq-default case-fold-search t)              ; Search is case sensitive

;Key bindings

 (setq suggest-key-bindings nil)                ; No key-binsing hints for M-x
 (global-unset-key "\C-x\C-v")                  ; Suppress a shortcut
 ;(cua-mode t)                                   ; Cut/Paste with C-x/C-c/C-v

;Miscellaneous

 (put 'narrow-to-region  'disabled nil)         ; Allow narrow-to-region command
 (setq disabled-command-hook nil)               ; Allow all disabled commands
 (setq undo-limit 100000)                       ; Increase number of undo
 (defalias 'qrr 'query-replace-regexp)          ; Define an alias
 (setq default-major-mode 'text-mode)           ; Text-mode is default mode
 (add-hook 'text-mode-hook 'turn-on-auto-fill)  ; auto-formatting in text-mode
 (defalias 'yes-or-no-p 'y-or-n-p)              ; y/n instead of yes/no
 (require 'cl)                                  ; Use Common Lisp features
                                                ; Note: There are some problems
                                                ;  with this. It might be better
                                                ;  to just use it when compiling
                                                ;  elisp files, see the elisp manual.

;Some of the functions called with a ânilâ argument work slightly better with a negative numeric argument. For example the following are called with ânilâ but their help in Emacs 23.X mentions that

 (tool-bar-mode nil)                            ; No toolbar
 ;(mouse-wheel-mode t)                           ; Mouse-wheel enabled
 ;(column-number-mode t)                         ; Show column number in mode-line
 ;(global-hl-line-mode t)                        ; Highlight cursor line
 ;(blink-cursor-mode 0)                          ; No blinking cursor
 ;(icomplete-mode t)                             ; Completion in mini-buffer
 ;(desktop-save-mode t)                          ; Save session before quitting
 (speedbar t)                                   ; Quick file access with bar
 ;(cua-mode t)                                   ; Cut/Paste with C-x/C-c/C-v

;;myCustomizations:
;; To customize the background color
;;(set-face-background 'highlight-current-line-face  "yellow")
;(require 'highlight-current-line)
;(highlight-current-line-on t)

;; To customize the background color
;(set-face-background 'highlight-current-line-face "light yellow")
;(global-hl-line-mode t)

;; To customize the background color
;(set-face-background 'hl-line "#330")  ;; Emacs 22 Only
;(set-face-background 'highlight "#fff")  ;; Emacs 21 Only
;(set-face-background hl-line-face (shade-color 08))
;;; From emacs-wiki:
;(defun shade-color (intensity)
;  "print the #rgb color of the background, dimmed according to intensity"
;  (interactive "nIntensity of the shade : ")
;  (apply 'format "#%02x%02x%02x"
;         (mapcar (lambda (x)
;                   (if (> (lsh x -8) intensity)
;                       (- (lsh x -8) intensity)
;                     0))
;                 (color-values (cdr (assoc 'background-color (frame-parameters)))))))
;
;;; Default hl
;(global-hl-line-mode t)
;(make-variable-buffer-local 'global-hl-line-mode)
;(set-face-background hl-line-face (shade-color 08))
;
;(defface hl-line-highlight-face
;  '((t :inherit highlight))
;  "Face for highlighting the current line with `hl-line-fancy-highlight'."
;  :group 'hl-line)
;
;(defun hl-line-fancy-highlight ()
;  (set (make-local-variable 'hl-line-face) 'hl-line-highlight-face)
;  ;;    (set (make-local-variable 'line-move-visual) nil)
;  ;;    (set (make-local-variable 'cursor-type) nil)
;  (setq global-hl-line-mode nil)
;  (hl-line-mode))
;
;(add-hook 'org-agenda-mode-hook 'hl-line-fancy-highlight)
;(add-hook 'gnus-summary-mode-hook 'hl-line-fancy-highlight)
;(add-hook 'gnus-group-mode-hook 'hl-line-fancy-highlight)

; (add-to-list 'load-path "~/.emacs.d/themes/color-theme-6.6.0/color-theme.el")
; (require 'color-theme)
; ;(load 'zenburn)  ;; requires that zenburn.el is in your load path
; (eval-after-load "color-theme"
;   '(progn
;      (color-theme-initialize)
;      (color-theme-zenburn)))

; (add-to-list 'load-path "~/.emacs.d/elisp/")
; (require 'color-theme)
; (load 'zenburn)  ;; requires that zenburn.el is in your load path
; (eval-after-load "color-theme"
;   '(progn
;      (color-theme-initialize)
;      (color-theme-zenburn)))

 (setq debug-on-error t)

 ;(add-to-list 'load-path "~/.emacs.d/elisp/zenburn.el")
 ;(require 'color-theme)
 ;(load zenburn)
 ;(load 'zenburn)
 ;(eval-after-load "color-theme"
 ;  '(progn
 ;    (color-theme-initialize)
 ;     (color-theme-zenburn))))

 ;(load-file "~/.emacs.d/elisp/zenburn.el")
 ;(zenburn)

 ;(load-file "~/.emacs.d/elisp/zenburn-emacs/zenburn-theme.el")
 ;(zenburn)

 ;(load-theme 'solarized-dark t)



(require 'package)
(add-to-list 'package-archives 
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(eval-after-load 'linum
;  '(progn
;     (defface linum-leading-zero
;       `((t :inherit 'linum
;            :foreground ,(face-attribute 'linum :background nil t)))
;       "Face for displaying leading zeroes for line numbers in display margin."
;       :group 'linum)
;
;     (defun linum-format-func (line)
;       (let ((w (length
;                 (number-to-string (count-lines (point-min) (point-max))))))
;         (concat
;          (propertize (make-string (- w (length (number-to-string line))) ?0)
;                      'face 'linum-leading-zero)
;          (propertize (number-to-string line) 'face 'linum))))
;
;     (setq linum-format 'linum-format-func)))

;(setq linum-format "%4d \u2502")
;(setq linum-format "%4d")
(setq linum-format "%d \u2502")

(require 'linum)
;(require 'cmmove)

;; To use % as in vim
          
          (global-set-key "%" 'match-paren)
          
          (defun match-paren (arg)
            "Go to the matching paren if on a paren; otherwise insert %."
            (interactive "p")
            (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
                  ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
                  (t (self-insert-command (or arg 1)))))
(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer 
          (delq (current-buffer) 
                (remove-if-not 'buffer-file-name (buffer-list)))))

; (require 'chm-view)

;(defun djcb-gtags-create-or-update ()
;  "create or update the gnu global tag file"
;  (interactive)
;  (if (not (= 0 (call-process "global" nil nil nil " -p"))) ; tagfile doesn't exist?
;    (let ((olddir default-directory)
;          (topdir (read-directory-name  
;                    "gtags: top of source tree:" default-directory)))
;      (cd topdir)
;      (shell-command "gtags && echo 'created tagfile'")
;      (cd olddir)) ; restore   
;    ;;  tagfile already exists; update it
;    (shell-command "global -u && echo 'updated tagfile'")))
;
;(add-hook 'gtags-mode-hook 
;  (lambda()
;    (local-set-key (kbd "M-.") 'gtags-find-tag)   ; find a tag, also M-.
;    (local-set-key (kbd "M-,") 'gtags-find-rtag)))  ; reverse tag
;
;(add-hook 'c-mode-common-hook
;  (lambda ()
;    (require 'gtags-mode)
;    (gtags-mode t)
;    (djcb-gtags-create-or-update)))
;
;(add-hook 'c-mode-common-hook
;  (lambda ()
;    (require 'gtags-mode)
;    (gtags-mode t)
;    (when (not (string-match "/usr/src/linux/" (expand-file-name default-directory)))  
;      (djcb-gtags-create-or-update))))

;    (add-to-list 'load-path "~/.emacs.d/elisp/")

    (add-to-list 'load-path "~/emacs/slime/slime/")  ; your SLIME directory
    (setq inferior-lisp-program "/usr/bin/sbcl") ; your Lisp system
    (require 'slime)
    (slime-setup)

(add-to-list 'load-path "~/.emacs.d/elisp-custom/")
(require 'gtags)
(defun ww-next-gtag ()
  "Find next matching tag, for GTAGS."
  (interactive)
  (let ((latest-gtags-buffer
         (car (delq nil  (mapcar (lambda (x) (and (string-match "GTAGS SELECT" (buffer-name x)) (buffer-name x)) )
                                 (buffer-list)) ))))
    (cond (latest-gtags-buffer
           (switch-to-buffer latest-gtags-buffer)
           (forward-line)
           (gtags-select-it nil))
          ) ))

;Here’s my key binding for using GNU Global.

(global-set-key "\M-;" 'ww-next-gtag)   ;; M-; cycles to next result, after doing M-. C-M-. or C-M-,
(global-set-key "\M-." 'gtags-find-tag) ;; M-. finds tag
(global-set-key [(control meta .)] 'gtags-find-rtag)   ;; C-M-. find all references of tag
(global-set-key [(control meta ,)] 'gtags-find-symbol) ;; C-M-, find all usages of symbol.

