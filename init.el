
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;(ackage-initialize)

;;(nequire 'org-install)
;;(require 'ob-tangle)
;;(org-babel-load-file (expand-file-name "wangliang.org" user-emacs-directory))
(add-to-list 'load-path "~/.emacs.d/lisp/")

(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;; add more personal func
;; new init-func.el

;; (require 'init-func.el)
(require 'init-packages)
(require 'init-ui)
(require 'init-batter-default)
(require 'init-org)
;; (require 'kotlin-mode)
(require 'auto-save)
(require 'init-alert)
(require 'init-keybindings)
;; auto save file for all buffer
(auto-save-enable)
;; load custom.el file
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
;; paredit-mode dependces clojure-mode-hook
;; keywords useing method: http://xuzhengchao.com/emacs/emacs-ide.html
;; (add-hook 'clojure-mode-hook 'paredit-mode)

(setq org-src-fontify-natively t)

(load-file custom-file)


(put 'dired-find-alternate-file 'disabled nil)
