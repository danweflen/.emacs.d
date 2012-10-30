;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;;Define local variables
(setq whole-alphabet 
      '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" 
       "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")) 

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; Adds things to the emacs load path
(add-to-list 'load-path "/home/becker/weflen/.emacs.d")

;; Sets the emacs theme
;; Examples of themes can be found at 
;; http://gnuemacscolorthemetest.googlecode.com/svn/html/index-c.html
;; and on the emacs wiki page for color theme

(require 'color-theme)
(color-theme-initialize)

;;Themes I like
(color-theme-euphoria);;  Makes it difficult to use shell-mode, as "executable" green is the same as standard text
;;(color-theme-calm-forest);; Makes it difficult to use shell-mode, as "executable" green is the same as standard text
;;(color-theme-hober) ;; Makes it difficult to use shell-mode, as "executable" green is the same as standard text
;; (color-theme-oswald);; Makes it difficult to use shell-mode, as "executable" green is the same as standard text
;; (color-theme-midnight) ;; Comments don't stand out
;; (color-theme-renegade) ;; Keywords don't stand out
;; (color-theme-taylor)
;; (color-theme-wheat)
;; (color-theme-tty-dark) ;; Hard to read 
;; (color-theme-taming-mr-arneson)
;; (color-theme-lethe)
;; (color-theme-arjen)
;; (color-theme-billw);; Comments don't stand out
;; (color-theme-comidia)

;;Loads egg (emacs git mode)

;;(require 'egg)

;;Loads git-mode (the official one)
(require 'git)
(require 'git-blame)

;; Loads magit (another git mode)
;;(require 'magit)

;;Sets order of default backends
(setq vc-handled-backends '(Bzr Git Hg RCS CVS SVN Mtn Arch SCCS))


;Sets the path emacs uses to search for things
(setq exec-path (append exec-path '("/home/becker/weflen/progs" "/home/becker/weflen/progs/bin")))

;; always end a file with a newline
;;(setq require-final-newline 'query)

;;line-number-mode 1
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(egg-enable-tooltip t)
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)    

(setq scroll-conservatively 10)

(setq blink-matching-delay 0.3)

(setq add-log-mailing-address "weflen@colorado.edu")

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;Make ".m" files open in octave mode instead of Obj-C mode.
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

(defun ol-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (progn (add-hook prog-mode-hook 'linum-mode)
	 (add-hook prog-mode-hook 'show-paren-mode) ) )

(defun cl-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (add-hook prog-mode-hook 'linum-mode)
  (add-hook prog-mode-hook 'show-paren-mode)
  (add-hook prog-mode-hook (lambda () (global-set-key [?\s-c] 'compile)) ) )

(defun il-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (progn (add-hook prog-mode-hook 'linum-mode)
	 (add-hook prog-mode-hook 'show-paren-mode)
	 (add-hook prog-mode-hook  
		   (lambda () (global-set-key [?\s-r] 'executable-interpret)) ) ) ) 


(make-variable-buffer-local 'show-paren-mode)

(let ( 
      (c-lang-hooks '(c-mode-hook c++-mode-hook f90-mode-hook) )
      (i-lang-hooks '(python-mode-hook shell-script-mode-hook ) )
      (o-lang-hooks '(latex-mode-hook makefile-gmake-mode-hook emacs-lisp-mode-hook awk-mode-hook octave-mode-hook) )
      )
  (mapc 'il-add-to-hooks i-lang-hooks)
  (mapc 'cl-add-to-hooks c-lang-hooks)
  (mapc 'ol-add-to-hooks o-lang-hooks)
  )

(add-hook 'emacs-lisp-mode-hook (lambda () (global-set-key [?\s-c] 'byte-compile-file)) )

(add-hook 'compilation-mode-hook 'visual-line-mode)

(global-set-key [?\s-l] 'add-change-log-entry-other-window)
(global-set-key [?\s-g] 'goto-line)
(global-set-key [?\s-\s] 'point-to-register)
(global-set-key [?\s-j] 'jump-to-register)
(global-set-key [?\s-s] 'copy-to-register)
(global-set-key [?\s-i] 'insert-register)
(global-set-key [?\s-h] 'shell)

(setq tab-width 8)
(setq c-basic-offset 8)
(setq c-default-style "linux" c-basic-offset 4)
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))
