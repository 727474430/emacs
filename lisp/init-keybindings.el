(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-h f") 'counsel-describe-function)
(global-set-key (kbd "C-h v") 'counsel-describe-variable)
(global-set-key (kbd "<f2>") 'open-my-init-file)

;; always useing keyword
(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; bound nodejs key (nodejs-repl-send-buffer)
(global-set-key (kbd "C-x <f10>") 'nodejs-repl-send-buffer)

;; users custom key general(一般) on Ctrl-c beging
;; (global-set-key (kbd "C-c p f") 'counsel-git)

;; auto 缩进
(global-set-key (kbd "C-M-\\") 'indent-region-or-buff)

;; hippie-expand
(global-set-key (kbd "s-/") 'hippie-expand)

;; config expand-region
(global-set-key (kbd "C-=") 'er/expand-region)

;; config iedit keywords
(global-set-key (kbd "M-s e") 'iedit-mode)

;; occur-dwim
(global-set-key (kbd "M-s o") 'occur-dwim)

;; counsel-imenu, search current buffer all functions
(global-set-key (kbd "M-s i") 'counsel-imenu)

;; open the org in org-agenda
(global-set-key (kbd "C-c a") 'org-agenda)

;; r aka remember
(global-set-key (kbd "C-c r") 'org-capture)

;; config helm-ag -> C-c p(roject) s(earch)
;; (global-set-key (kbd "C-c p s") 'helm-do-ag-project-root)

;; M-n M-p change C-n C-p
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-P") #'company-select-previous))

;; because use require very Waste of performance(浪费性能), so use following
;; statement play a(起到) lazy load effect(懒加载效果)
(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))


(global-set-key (kbd "C-w") 'backward-kill-word)

;; config auto-yasnippet
(global-set-key (kbd "H-w") #'aya-create)
(global-set-key (kbd "H-y") #'aya-expand)

(provide 'init-keybindings)
