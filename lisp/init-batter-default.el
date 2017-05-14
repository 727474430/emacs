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


;; 类似aop, in functions execute process(过程中), useing following code
(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn));; 如果有(则执行  show-paren-function cond 类似于switch
        (t (save-excursion ;; 当调用完下列函数后，光标回到起始位置
             (ignore-errors (backward-up-list));; 如果在中间先调用(backward-up-list 函数，找到上一个括号后 调用show-paren-function
             (funcall fn)))))
 
;; show pair ()
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

;; hidden dos in enter(^m)
;;(defun hidden-dos-eol ()
;;  "Do not show ^M in files containing mixed UNIX and DOS line endings."
;;  (interactive)
;;  (unless buffer-display-table
;;    (setq buffer-display-table (make-display-table)))
;;  (aset buffer-display-table ?\^M []))
;; delete dos in enter(\r[^m]) `M-x remove-dos-eol`
(defun remove-dos-eol ()
  "Replace DOS eolns CR LF with Unix eolns CR"
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "")))


;; 下面的代码用于配置 Occur Mode 使其默认搜索当前被选中的或者在光标下的字符串：
(defun occur-dwim ()
  "Call `occur' with a sane default."
  (interactive)
  (push (if (region-active-p)
            (buffer-substring-no-properties
             (region-beginning)
             (region-end))
          (let ((sym (thing-at-point 'symbol)))
            (when (stringp sym)
              (regexp-quote sym))))
        regexp-history)
  (call-interactively 'occur))
(global-set-key (kbd "M-s o") 'occur-dwim)


;; strong imenu power, use regex find all match info
(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
        ;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
        (imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
                                   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
                                   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
                                   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
              (lambda ()
                (setq imenu-create-index-function 'js2-imenu-make-index)))

(global-set-key (kbd "M-s i") 'counsel-imenu)

(provide 'init-batter-default)
