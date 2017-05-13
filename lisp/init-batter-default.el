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

;; dired config: let dired-mode on delete or copy directory time no longer ask y or n
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
;; dired-mode useing Ret enter directory time no more generate new buffer
(put 'dired-find-alternate-file 'disable nil)

;; open current dired-buffer (C-x C-j)
(require 'dired-x)
;; from a dired copy file to other a dired
(setq dired-dwim-target t)


;; auto save files for all buffer
(setq auto-save-slient t)


;; bookmark keywords: bookmark-set input bookmark name (C-x r m)
;; View bookmark-list bookmark-bmenu-list (C-x r l)
;; Use bookmark-jump function, can be jump once appoint bookmark(C-x r b) input baokmark name

(require 'appt)
  (setq appt-time-msg-list nil)    ;; clear existing appt list
  (setq appt-display-interval '5)  ;; warn every 5 minutes from t - appt-message-warning-time
  (setq
   appt-message-warning-time '15  ;; send first warning 15 minutes before appointment
   appt-display-mode-line nil     ;; don't show in the modeline
   appt-display-format 'window)   ;; pass warnings to the designated window function
  (appt-activate 1)                ;; activate appointment notification
  (display-time)                   ;; activate time display

  (org-agenda-to-appt)             ;; generate the appt list from org agenda files on emacs launch
  (run-at-time "24:01" 3600 'org-agenda-to-appt)           ;; update appt list hourly
  (add-hook 'org-finalize-agenda-hook 'org-agenda-to-appt) ;; update appt list on agenda view

  (defun my-appt-display (min-to-app new-time msg)
    (notify-osx
     (format "Appointment in %s minutes after start task" min-to-app)    ;; passed to -title in terminal-notifier call
     (format "%s" msg)))                                ;; passed to -message in terminal-notifier call
(setq appt-disp-window-function (function my-appt-display))

(defun notify-osx (title message)
    (call-process "terminal-notifier"
                  nil 0 nil
                  "-group" "Emacs"
                  "-title" title
                  "-sender" "org.gnu.Emacs"
                  "-message" message
                  "-activate" "oeg.gnu.Emacs"))


(provide 'init-batter-default)
