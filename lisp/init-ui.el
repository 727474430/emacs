(tool-bar-mode -1)

;;closed scroll bar
(scroll-bar-mode -1)

;; show linum-mode
(global-linum-mode t)

;; Highligth current line
(global-hl-line-mode t)

;; closed enable view
(setq inhibit-splash-screen t)

;; open with full screen
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;; cursor type
(setq-default cursor-type 'bar)

(setq enable-recursive-minibuffers t)


(provide 'init-ui)
