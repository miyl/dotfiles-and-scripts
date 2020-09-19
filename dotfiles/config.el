;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


; SETTINGS {{{

; Case insensitive completion in the mini buffer (the bottom part of the screen handling file names etc.)
(setq completion-ignore-case  t)

; Set minibuffer completion style to include matching substrings. All the others were included by default.
; "Emacs tries each completion style in turn. If a style yields one or more matches, that is used as the list of completion alternatives. If a style produces no matches, Emacs falls back on the next style."
; SRC: https://www.gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html#Completion-Styles
(setq completion-styles '(basic partial-completion emacs22 substring))

; highlight current line. seems to be default with doom mode anyway, but in case i want to roll my own full config at some point.
(global-hl-line-mode 1)


; Default major mode for files it can't detect the type of is fundamental, but until I get a reason not to I might as well set it to text so my hooks work and because they probably are text
(setq-default major-mode 'text-mode)

; Display line numbers in all files (major modes)
;(global-display-line-numbers-mode t)
(add-hook 'text-mode-hook 'global-display-line-numbers-mode t)

; :set number relativenumber, please
; Also these can be toggled with space-t-l in doom emacs
; https://stackoverflow.com/questions/57439496/how-to-set-relative-line-numbers-in-doom-emacs
;(linum-mode)
;(linum-relative-global-mode)
;(setq doom-line-numbers-style 'relative)
(setq display-line-numbers-type 'relative)

; Set default indentation to 2 instead of 4. Specific language modes may override this so I need to add those too.
; TODO: Not sure what this affects? Maybe it's what's inserted if you write say if () { and then press enter, it indents you by this number of spaces?
(setq c-basic-offset 2)
; ...this makes a tab count for two spaces. And currently it seems I have some equivalent of expandtab already there, so tabs are autoconverted to spaces, fortunately.
; "NOTE: This controls the display width of a TAB character, and not the size of an indentation step."
(setq-default tab-width 2)
; The variable tab-stop-list "controls what characters are inserted when you press the <TAB> character in certain modes."

; Instead of breaking lines at the default of 80 characters, break them at this value
(setq-default fill-column 120)

; Don't mess up my directories by putting the automatic backup files in the same dirs as the edited file. Instead store them in the dir specified here (ensure that it exists!):
(setq backup-directory-alist `(("." . "~/.emacs-backup-files")))


; Enable making nice Org tables in markdown (via a minor mode rather than overwriting the major mode), rst and txt files as well
; https://orgmode.org/manual/Orgtbl-Mode.html#Orgtbl-Mode
; Makes this apply only for text files that ARE NOT Org files. Alternately suppress the error of trying to enable it when it already is.
(unless major-mode org-mode add-hook 'text-mode-hook 'turn-on-orgtbl t)

; Enable Org's list editing etc. in other text files. https://web.archive.org/web/20190203110816/https://orgmode.org/manual/Orgstruct-mode.html
;(add-hook 'text-mode-hook 'turn-on-orgstruct)

; }}}


; INLINE IMAGES {{{

; If I want to default to showing inline images
(setq org-startup-with-inline-images t)

; }}}


; PACKAGES {{{

;(setq org-reveal-root "file:////home/mi/applications/reveal.js")
(setq org-reveal-root "file:////home/mi/applications/reveal-js-newer")

(add-to-list 'load-path "/home/mi/.emacs.d/lisp")
(add-to-list 'load-path "/home/mi/.emacs.d/lisp/org-reveal/")
(require 'ox-reveal)

; }}}

; {{{ MAPPINGS:

; Bind to evil mode normal with less code
;(defun nmap (keyrep defstr) "Vim-style keybinding for `evil-normal-state'. Uses the `define-key' binding function."
;      (xmap evil-normal-state-map keyrep defstr))

; https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Commands.html
(global-set-key (kbd "C-c l") 'org-store-link)
; Not sure if I'll use these two but for now let's just add them
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)

; Easier buffer switching than C-x left, C-x right
;(nmap æ :bp)
;(nmap ø :bn)
(define-key evil-normal-state-map "æ" 'previous-buffer)
(define-key evil-normal-state-map "ø" 'next-buffer)
;(define-key evil-normal-state-map "qw" 'save-buffer)

; Remove highlights from a search, like vim's :noh
(define-key evil-normal-state-map (kbd "<f4>") 'evil-ex-nohighlight)

;qw bind to easily save?

;(global-set-key [C-pause] 'previous-buffer)
;(define-key evil-normal-state-map:)
; (define-key evil-normal-state-map (kbd+ æ) (edmacro-parse-keys previous-buffer t
; }}}


; {{{ FUNCTIONS:

; For renaming the current file incl. its buffer faster
(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let* ((name (buffer-name))
        (filename (buffer-file-name))
        (basename (file-name-nondirectory filename)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " (file-name-directory filename) basename nil basename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))
; }}}
