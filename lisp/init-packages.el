;; if emacs version >=24
(when (>= emacs-major-version 24)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;;(when (>= emacs-major-version 24)
;;  (setq package-archives '("popkit" . "http://elpa.popkit.org/packages"))
;;  )

(require 'cl)

;; add whatever packages you want here
(defvar wangliang/packages '(
			     company
			     monokai-theme
			     hungry-delete
			     swiper
			     counsel
			     smartparens
			     js2-mode
			     nodejs-repl
			     exec-path-from-shell ;; 如果想让命令行可见需要配置
			     popwin
			     kotlin-mode
			     org-alert
			     reveal-in-osx-finder ;; in the finder open current buffer file location(在当前语句是 ·所在位置· 意思)
			     web-mode
			     js2-refactor
			     expand-region
			     iedit
			     org-pomodoro
			     helm-ag
			     flycheck
			     auto-yasnippet
			     evil
			     evil-leader
			     window-numbering
			     evil-nerd-commenter
			     which-key
			     ) "Default packages")

(setq package-selected-packages wangliang/packages)

(defun wangliang/packages-installed-p ()
  (loop for pkg in wangliang/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (wangliang/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg wangliang/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; let emacs could find the execute (让emacs可以找到这个可执行程序)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; hungry config
(global-hungry-delete-mode)

;; config smartparens 符号补全 () "" ...
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)
;; in the emacs-lisp-mode input 单引号 no-auto complate
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)

;; config swiper dependces counsel
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; config js2-mode for js files, all .js files for js2-mode
(setq auto-mode-alist 
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode)
	 )
       auto-mode-alist))

;; global-company-mode 全局补全
(global-company-mode)

;; auto load theme
(load-theme 'monokai t)

(require 'popwin)
(popwin-mode t)


;; config for web mode, default modify 2 缩进
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 4) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 4)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 4)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

;; config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-m")

;; org-pomodoro
(require 'org-pomodoro)

;; flycheck
(add-hook 'js2-mode-hook 'flycheck-mode)
(add-hook 'web-mode-hook 'flycheck-mode)

;;
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

;; open evil
(evil-mode 1)
(setcdr evil-insert-state-map nil)
;; default normal-state
(define-key evil-insert-state-map [escape] 'evil-normal-state)
;; evil-leader config
(global-evil-leader-mode)
(evil-leader/set-key
 "ff" 'find-file
 "xb" 'switch-to-buffer
 "fr" 'recentf-open-files
 "bk" 'kill-buffer
 "pf" 'counsel-git
 "ps" 'helm-do-ag-project-root
 "1" 'select-window-1
 "2" 'select-window-2
 "3" 'select-window-3
 "4" 'select-window-4
 "w/" 'split-window-right
 "w-" 'split-window-below
 ":" 'counsel-M-x
 "M-RET" 'toggle-frame-maximized
 "x1" 'delete-other-windows
 "qq" 'save-buffers-kill-terminal)
(window-numbering-mode 1)

;; evil-surround    `vim C-S '\"\(...   cs`
(require 'evil-surround)
(global-evil-surround-mode 1)
;; evil-nerd-commenter
(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd "M-/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd "M-/") 'evilnc-comment-or-uncomment-lines)

;; occur-mode evil-leader config
(add-hook 'occur-mode-hook
	  (lambda()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd "/") 'evil-search-forward
	      (kbd "n") 'evil-search-next
	      (kbd "N") 'evil-search-previous
	      (kbd "C-d") 'evil-scroll-down
	      (kbd "C-u") 'evil-scroll-up
	      )))

;; which-key start
(which-key-mode 1)
(which-key-setup-side-window-bottom)


(provide 'init-packages)
