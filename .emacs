;;(setq tool-bar-mode nil)            ;; Disable the button bar atop screen
(setq scroll-bar-mode nil)                ; Disable scroll bar
(setq inhibit-startup-screen t)     ; Disable startup screen with graphics
(set-default-font "Monaco 12")      ; Set font and size
(setq-default indent-tabs-mode nil) ; Use spaces instead of tabs
(setq tab-width 2)                  ; Four spaces is a tab
(setq visible-bell nil)             ; Disable annoying visual bell graphic
(setq ring-bell-function 'ignore)   ; Disable super annoying audio bell

(set-cursor-color "Orchid")
(set-mouse-color "Orchid")

;; Unset C-z
(global-unset-key (kbd "C-z"))

;; Highlight marked area
(setq-default transit-mark-mode t)

;; Set Line Number
(global-linum-mode t)
(setq column-number-mode t)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "brightred" :foreground "white"))))
 '(mouse ((t (:background "brightred")))))

;; go-mode
;; http://tleyden.github.io/blog/2014/05/22/configure-emacs-as-a-go-editor-from-scratch/
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
  (add-hook 'go-mode-hook 'auto-complete-for-go)

;; Godef is essential: it lets you quickly jump around the code
(defun my-go-mode-hook ()
					; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
					; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-/") 'pop-tag-mark)
					; Set indentation
  (setq tab-width 4)
  (setq indent-tabs-mode 1)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)


;; useful to be able to able to pull up 3rd party or standard library docs from within Emacs using the godoc tool
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (replace-regexp-in-string
			  "[ \t\n]*$"
			  ""
			  (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
    (setenv "PATH" path-from-shell)
    (setq eshell-path-env path-from-shell) ; for eshell users
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; auto pair
(electric-pair-mode 1)
(setq electric-pair-preserve-balance nil)


;; Python development Elpy

(require 'package)
(add-to-list 'package-archives
  '("elpy" . "http://jorgenschaefer.github.io/packages/"))


(package-initialize)
(elpy-enable)

(add-hook 'python-mode-hook
          (lambda () (setq python-indent-offset 4)))

(add-hook 'python-mode-hook
          (lambda ()
            (local-set-key (kbd "M-/") 'pop-tag-mark)))

(require 'package)
(add-to-list 'package-archives
             '("MELPA Stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(package-install 'flycheck)

(global-flycheck-mode)
