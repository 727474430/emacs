(package-initialize)

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
(require 'init-keybindings)
(require 'init-org)
;; (require 'kotlin-mode)
(require 'auto-save)
(require 'init-alert)
;; auto save file for all buffer
(auto-save-enable)
;; load custom.el file
(setq custom-file (expand-file-name "lisp/custom.el" user-emacs-directory))
;; paredit-mode dependces clojure-mode-hook
;; keywords useing method: http://xuzhengchao.com/emacs/emacs-ide.html
;; (add-hook 'clojure-mode-hook 'paredit-mode)


(load-file custom-file)    
(put 'dired-find-alternate-file 'disabled nil)
