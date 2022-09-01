;;; 10_custom.el --- User custom functions. -*- lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Code:
;; (setq debug-on-error t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; User custom functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(leaf *user-custom-functions
  :bind	 (("<f3>" . thunar-open)
		  ("<f4>" . terminal-open)
		  ("<f8>" . toggle-menu-bar-mode-from-frame)
		  ("C-x /" . my:delete-this-file)
		  ("<muhenkan>" . minibuffer-keyboard-quit)
		  ("C-c <left>" . winner-undo)
		  ("C-c <right>" . winner-redo)))


(defun thunar-open ()
  "Open thunar with current dir."
  (interactive)
  (shell-command (concat "xdg-open " default-directory)))


(defun terminal-open ()
  "Open termninal with current dir."
  (interactive)
  (let ((dir (directory-file-name default-directory)))
	;; (shell-command (concat "gnome-terminal --maximize --working-directory " dir))))
	(shell-command (concat "gnome-terminal --working-directory " dir))))


(defun my:delete-file-if-no-contents ()
  "If the file is empty, it will be deleted automatically."
  (when (and (buffer-file-name (current-buffer))
			 (= (point-min) (point-max)))
	(delete-file
	 (buffer-file-name (current-buffer)))))
(if (not (memq 'my:delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
		  (cons 'my:delete-file-if-no-contents after-save-hook)))


(defun my:delete-this-file ()
  "Delete the current file, and kill the buffer."
  (interactive)
  (unless (buffer-file-name)
	(error "No file is currently being edited"))
  (when (yes-or-no-p (format "Really delete '%s'?"
							 (file-name-nondirectory buffer-file-name)))
	(delete-file (buffer-file-name))
	(kill-this-buffer)))


;; Automatically open root permission file with sudo
(leaf *sudo-open
  :doc "https://ameblo.jp/grennarthmurmand1976/entry-12151018656.html"
  :config
  (defun file-root-p (filename)
	"Return t if file FILENAME created by root."
	(eq 0 (nth 2 (file-attributes filename))))

  (defadvice find-file (around my:find-file activate)
	"Open FILENAME using tramp's sudo method if it's root permission."
	(if (and (file-root-p (ad-get-arg 0))
			 (not (file-writable-p (ad-get-arg 0)))
			 (y-or-n-p (concat (ad-get-arg 0)
							   " is root permission. Open it as root? ")))
		(my:find-file-sudo (ad-get-arg 0))
	  ad-do-it))

  (defun my:find-file-sudo (file)
	"Opens FILE with root privileges."
	(interactive "F")
	(set-buffer (find-file (concat "/sudo::" file)))))


;; Scroll a deactive window
(leaf *my:scroll-other-window
  :bind (("<next>" . my:scroll-other-window)
		 ("<prior>" . my:scroll-other-window-down))
  :init
  (defun my:scroll-other-window ()
	"If there are two windows, `scroll-other-window'."
	(interactive)
	(when (one-window-p)
	  (scroll-up))
	(scroll-other-window))

  (defun my:scroll-other-window-down ()
	"If there are two windows, `scroll-other-window-down'."
	(interactive)
	(when (one-window-p)
	  (scroll-down))
	(scroll-other-window-down)))


;; PS-printer
(defalias 'ps-mule-header-string-charsets 'ignore)
(setq ps-multibyte-buffer 'non-latin-printer
	  ps-paper-type 'a4
	  ps-font-size 9
	  ;; ps-font-family 'Helvetica
	  ps-font-family 'Courier
	  ps-line-number-font 'Courier
	  ps-printer-name nil
	  ps-print-header nil
	  ps-show-n-of-n t
	  ps-line-number t
	  ps-print-footer nil)


(provide '10_custom)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 10_custom.el ends here
