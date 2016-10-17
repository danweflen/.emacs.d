;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;;Define local variables
(setq package-enable-at-startup nil)
(package-initialize)
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
(add-to-list 'load-path "/home/daniel/.emacs.d/lisp" )


;;Sets order of default backends
(setq vc-handled-backends '(Bzr Git Hg RCS CVS SVN Mtn Arch SCCS))


;Sets the path emacs uses to search for things
(setq exec-path (append exec-path '("/home/daniel/progs" "/home/daniel/progs/bin")))


;;ediff prefrences
(setq-default ediff-ignore-similar-regions t)
(setq-default ediff-highlight-all-diffs nil)

;;automatically reread files from disk if modified
;;(this is useful for having separate git branches)
(global-auto-revert-mode t)

(autoload 'linum-mode "linum" "toggle line numbers on/off" t) 
(global-set-key (kbd "C-<f5>") 'linum-mode)    


(setq scroll-conservatively 10)

(setq blink-matching-delay 0.3)

(setq add-log-mailing-address "weflen@colorado.edu")

(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-selection-value)

;;Make ".m" files open in octave mode instead of Obj-C mode.
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pl$" . gnuplot-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.cu$") )

; Other languages
(defun ol-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (progn (add-hook prog-mode-hook #'linum-mode)
	 (add-hook prog-mode-hook #'show-paren-mode) ) )

; Compiled Languages
(defun cl-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (add-hook prog-mode-hook #'linum-mode)
  (add-hook prog-mode-hook #'show-paren-mode)
  (add-hook prog-mode-hook (lambda () (global-set-key [?\s-c] 'compile)) ) )

; Interpreted Languages
(defun il-add-to-hooks (prog-mode-hook)
  "add a series of functions to prog-mode-hook"
  (progn (add-hook prog-mode-hook #'linum-mode)
	 (add-hook prog-mode-hook #'show-paren-mode)
	 (add-hook prog-mode-hook  
		   (lambda () (global-set-key [?\s-r] 'executable-interpret)) ) ) ) 

;; Setting custom key bindings for specific programming languages.
(make-variable-buffer-local 'show-paren-mode)

(let ( 
      (c-lang-hooks '(c-mode-hook c++-mode-hook f90-mode-hook cuda-mode-hook) )
      (i-lang-hooks '(python-mode-hook shell-script-mode-hook ) )
      (o-lang-hooks '(latex-mode-hook makefile-gmake-mode-hook emacs-lisp-mode-hook awk-mode-hook octave-mode-hook) )
      )
  (mapc 'il-add-to-hooks i-lang-hooks)
  (mapc 'cl-add-to-hooks c-lang-hooks)
  (mapc 'ol-add-to-hooks o-lang-hooks)
  )

(add-hook 'emacs-lisp-mode-hook (lambda () (global-set-key [?\s-b] 'byte-compile-file)) )

(add-hook 'compilation-mode-hook 'visual-line-mode)

(global-set-key [?\s-l] #'add-change-log-entry-other-window)
(global-set-key [?\s-g] #'goto-line)
(global-set-key [?\s-\s] #'point-to-register)
(global-set-key [?\s-j] #'jump-to-register)
(global-set-key [?\s-s] #'copy-to-register)
(global-set-key [?\s-i] #'insert-register)
(global-set-key [?\s-h] #'shell)
(global-set-key [?\s-e] #'eshell)

(setq tab-width 8)
(setq c-basic-offset 8)
(setq c-default-style "linux" c-basic-offset 4)
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))

;; Adding package archives to emacs' package system
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ))

(linum-mode)

(emoji-fontset-enable "Symbola")

(autoload 'ssh-config-mode "ssh-config-mode" t)
(add-to-list 'auto-mode-alist '("/\\.ssh/config\\'"     . ssh-config-mode))
(add-to-list 'auto-mode-alist '("/sshd?_config\\'"      . ssh-config-mode))
(add-to-list 'auto-mode-alist '("/known_hosts\\'"       . ssh-known-hosts-mode))
(add-to-list 'auto-mode-alist '("/authorized_keys2?\\'" . ssh-authorized-keys-mode))
(add-hook 'ssh-config-mode-hook 'turn-on-font-lock)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (euphoria)))
 '(custom-safe-themes
   (quote
    ("fe349b21bb978bb1f1f2db05bc87b2c6d02f1a7fe3f27584cd7b6fbf8e53391a" "073ddba1288a18a8fb77c8859498cf1f32638193689b990f7011e1a21ed39538" "d6b0d76d584523e903ed1099a7f52619d21a23dc34404c115c65d6099c56ca5f" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" default)))
 '(egg-enable-tooltip t)
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Package specific initialization commands
;;Adjust-parens
(require 'adjust-parens)
(add-hook 'emacs-lisp-mode-hook #'adjust-parens-mode)
(add-hook 'clojure-mode-hook #'adjust-parens-mode)

(local-set-key (kbd "TAB") #'lisp-indent-adjust-parens)
(local-set-key (kbd "<backtab>") #'lisp-dedent-adjust-parens)

;;Helm configuration and initialization.
(require 'helm)
(require 'helm-config)

;; Thre default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-net-prefer-curl t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)

;; Octave Autocomplete initialization

(require 'ac-octave)
(defun ac-octave-mode-setup ()
  (setq ac-sources '(ac-source-octave)))
  (add-hook 'octave-mode-hook
	    '(lambda () (ac-octave-mode-setup)))

;; Ace-window init, this allows the use of M-p to quickly switch windows.

(global-set-key (kbd "M-p") 'ace-window)

;; Browse-kill-ring lets you pick from the kill ring like a menu
(require 'browse-kill-ring)

;; Sets the manual path for "woman"
(setq woman-manpath '("/usr/share/man/"))

