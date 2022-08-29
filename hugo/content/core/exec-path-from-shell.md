+++
date = "2022-08-29T05:48:41+09:00"
title = "2.5. exec-path-from-shell"
+++
## [exec-path-from-shell.el] 設定をシェルから継承する

🔗 [purcell/exec-path-from-shell: Make Emacs use the $PATH set up by the user's shell](https://github.com/purcell/exec-path-from-shell) 

シェルに設定した `PATH`情報をEmacsにも継承して設定してくれます。

```elisp
(leaf exec-path-from-shell
  :ensure t
  :when (memq window-system '(mac ns x))
  :hook (after-init-hook . exec-path-from-shell-initialize)
  :custom (exec-path-from-shell-check-startup-files . nil))
```
  
