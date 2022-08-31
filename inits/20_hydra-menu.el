;;; 20_hydra-menu.el --- Hydra configuration for work menu. -*- lexical-binding: t; no-byte-compile: t -*-
;;; Commentary:
;;; Code:
;; (setq debug-on-error t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hydra configuration for quick menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(leaf *hydra-quick-menu
  :bind ("M-." . hydra-quick/body)
  :hydra
  (hydra-quick
   (:hint nil :exit t)
   "
   Quick Menu
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------------------
  _d_ropbox  _e_macs.d^^  _i_nits  _x_srv.jp^^^^  GH:_h_  root:_/_  _s_rcgith_u_b  _._files   howm:_@__,_   _m_d:_p_view   _f_ileZilla
  _r_estart  magit_[__]_  _t_ramp  _y_as:_n_:_v_  _j_unk  _b_rowse  _o_rg:_C_apture  _<home>_   _c_ompile^^   make:_k_._g_   _j_ournal._;_
"
   ("j" org-journal-new-entry)
   ;; ("l" org-journal-schedule-view)
   ("l" hydra-journal/body)
   (";" org-journal-new-scheduled-entry)
   ("o" my:org-dir)
   ("t" counsel-tramp)
   ("q" my:tramp-quit)
   ("<home>" my:home-dir)
   ("d" my:dropbox)
   ("." my:dotfiles-dir)
   ("i" my:inits-dir)
   ("e" my:emacs-dir)
   ("h" my:gh-dir)
   ("x" my:xsrv-dir)
   ("y" company-yasnippet)
   ("n" yas/new-snippet)
   ("v" yas/visit-snippet-file)
   ("r" restart-emacs)
   ("m" hydra-markdown/body)
   ("p" livedown-preview)
   ("w" livedown-kill)
   ("b" hydra-browse/body)
   ("c" hydra-make/body)
   ("-" my:github-show)
   ("@" howm-list-all)
   ("," howm-create-memo)
   ("J" open-junk-file)
   ("L" open-last-junk-file)
   ("k" my:make-k)
   ("g" my:make-git)
   ("/" my:root-dir)
   ("_" my:delete-other-windows)
   ("[" git-timemachine-toggle)
   ("]" magit-status)
   ("s" my:scr-dir)
   ("u" my:github-dir)
   ("C" my:open-capture)
   (":" view-mode)
   ("f" filezilla)
   ("M-." hydra-work/body)
   ("<muhenkan>" nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Hydra configuration for my work menu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(leaf *hydra-work-menu
  :bind ("<henkan>" . hydra-work/body)
  :hydra
  (hydra-work
   (:hint nil :exit t)
   "
   Work Menu
  ------^^^^^^^^^^^^^^^^^^^^^^^^^^-----------------------------------------------------------------------------------------
  _d_:日記   _m_:毎日   _w_:毎週   _k_:兼題^^   _t_:定例   _s_:吟行^^   近詠:_n_   創作:_[_._]_   keep_;_   delete-this_/_
  _a_:合評   _e_:hugo   _b_ackup   _g_ist:_L_   pass_x_c   _@_:my^^   view:_:_   _p_rint:_r_e   _h_   minorugh_._com
"
   ("p" ps-print-buffer)
   ("r" ps-print-region)
   ("a" my:apvoice)
   ("A" my:apvoice-new-post)
   ("P" ps-print-buffer)
   ("b" my:backup-all)
   ("@" browse-at-remote)
   ("e" easy-hugo)
   ("d" my:diary)
   ("D" my:diary-new-post)
   ("g" gist-region-or-buffer)
   ("L" lepton)
   ("j" org-journal-new-entry)
   ("h" chromium-tegaki)
   ("l" open-last-junk-file)
   ("t" my:teirei)
   ("T" my:teirei-new-post)
   ("s" my:swan)
   ("S" my:swan-new-post)
   ("N" my:kinnei)
   ("n" my:kinnei-draft)
   ("c" my:make-draft)
   ("m" my:d_kukai)
   ("w" my:w_kukai)
   ("k" my:m_kukai)
   ("/" my:delete-this-file)
   ("v" markdown-preview)
   ("f" flymake-show-diagnostics-buffer)
   ("x" keepassxc)
   ("+" text-scale-adjust)
   ("_" my:delete-other-windows)
   ("]" my:haiku-note)
   ("[" my:haiku-note-post)
   ("." my:minorugh-dir)
   (";" (browse-url "https://keep.google.com/u/0/"))
   (":" view-mode)
   ("z" select-mozc-tool)
   ("<henkan>" hydra-quick/body)
   ("<muhenkan>" nil))
  :init
  (defun my:backup-all ()
	"Backup all."
	(interactive)
	(let* ((default-directory (expand-file-name "~/Dropbox/backup")))
	  (compile "make -k")))

  (defun filezilla ()
	"Open filezilla."
	(interactive)
	(compile "filezilla -s")
	(delete-other-windows))

  (defun lepton ()
	"Open lepton."
	(interactive)
	(compile "~/Appimage/Lepton-1.10.0.AppImage")
	(delete-other-windows))

  (defun keepassxc ()
	"Open keepassxc with auto passwd input."
	(interactive)
	(compile "secret-tool lookup type kdb | keepassxc --pw-stdin ~/Dropbox/backup/passwd/keypassX/20191105.kdbx")
	(delete-other-windows)))


(provide '20_hydra-menu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 20_hydra-menu.el ends here
