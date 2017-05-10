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
			     google-translate
			     swiper
			     counsel
			     smartparens
			     js2-mode
			     nodejs-repl
			     exec-path-from-shell ;; 如果想让命令行可见需要配置
			     popwin
			     kotlin-mode
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

(require 'hungry-delete)
(global-hungry-delete-mode)

;; config smartparens 符号补全 () "" ...
;; (add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
(smartparens-global-mode t)

;; config swiper dependces counsel
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;; config js2-mode for js files, all .js files for js2-mode
(setq auto-mode-alist 
      (append
       '(("\\.js\\'" . js2-mode))
       auto-mode-alist))

;; global-company-mode 全局补全
(global-company-mode)

;; auto load theme
(load-theme 'monokai t)

(require 'popwin)
(popwin-mode t)

(provide 'init-packages)
