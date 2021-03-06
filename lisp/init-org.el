;; 语法高亮
(with-eval-after-load 'org
  ;; org-mode config
  (setq org-agenda-files '("/Users/wangliang/.emacs.d/org"))
  ;; org-capture-templates config
  (setq org-capture-templates
      '(("t" "TODO" entry (file+headline "~/.emacs.d/org/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)
	("c" "Chrome" entry (file+headline "~/.emacs.d/org/gtd.org" "Quick notes")
	 "* TODO [#C] %?\n %(wangliang/retrieve-chrome-current-tab-url)\n %i\n %U"
	 :empty-lines 1)
	))
  )
(setq org-src-fontify-natively t)


;; The Table, English and Chinese Alignment
(setq fonts
      (cond ((eq system-type 'darwin)     '("Monaco"    "STHeiti"))
            ((eq system-type 'gnu/linux)  '("Menlo"     "WenQuanYi Zen Hei"))
            ((eq system-type 'windows-nt) '("Consolas"  "Microsoft Yahei"))))
(set-face-attribute 'default nil :font
                    (format "%s:pixelsize=%d" (car fonts) 12))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family (car (cdr fonts)))))
;; Fix chinese font width and rescale
(setq face-font-rescale-alist '(("Microsoft Yahei" . 1.2) ("WenQuanYi Micro Hei Mono" . 1.2) ("STHeiti". 1.2)))


(provide 'init-org)
