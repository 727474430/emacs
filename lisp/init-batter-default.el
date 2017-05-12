;; closed move music
(setq ring-bell-function 'ignore)

;; external(外部) modification(修改) after auto revert
(global-auto-revert-mode t)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;; signatrue
					    ("8wl" "wangliang")
					    ;; emacs regex

					    ))

;; 禁止生成备份文件，最好通过GitHub或git来管理
(setq make-backup-files nil)

;; prohibit(禁止) auto-save-default
(setq auto-save-default nil)

(setq recentf-max-menu-items 25)
;; enable recentf-mode
(recentf-mode 1)

;; 选中输入可替换
(delete-selection-mode t)

;; auto 缩进
(defun indent-buffer()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-region-or-buffer()
  (interactive)
  (save-excursion
    (if (region-active-p)
	(progn
	  (indent-region (region-beginning) (region-end))
	  (message "Indent selected region."))
      (progn
	(indent-buffer)
	(message "Indent buffer.")))))


(provide 'init-batter-defaults)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

;; hippie-expand
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
					 try-expand-all-abbrevs
					 try-expand-dabbrev-from-kill
					 try-complete-file-name
					 try-complete-file-name-partially
					 try-expand-dabbrev-all-buffers
					 try-expand-list
					 try-expand-line
					 try-complete-lisp-symbol
					 try-complete-lisp-symbol-partially
					 ))

(fset 'yes-or-no-p 'y-or-n-p)

;; auto save files for all buffer
(setq auto-save-slient t)


(provide 'init-batter-default)
