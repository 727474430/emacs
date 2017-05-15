;; if emacs version >= 24
(when (>= emacs-major-version 24)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			   ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

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
			     window-number
			     reveal-in-osx-finder ;; in the finder open current buffer file location(在当前语句是 ·所在位置· 意思)
			     web-mode
			     js2-refactor
			     expand-region
			     iedit
			     org-pomodoro
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

;; add window-number
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

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


(provide 'init-packages)
