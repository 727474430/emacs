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
     (format "Appointment in %s minutes" min-to-app)    ;; passed to -title in terminal-notifier call
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

(provide 'init-alert)
