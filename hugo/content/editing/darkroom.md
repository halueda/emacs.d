+++
date = "2022-08-29T05:53:26+09:00"
title = "6.5. darkroom"
draft = false
weight = 5
+++

## [darkroom-mode.el] 執筆モード
🔗 [joaotavora/darkroom: Simple distraction-free editing.](https://github.com/joaotavora/darkroom)

画面の余計な項目を最小限にして、文章の執筆に集中できるようにするパッケージです。

[F12] キーで IN/OUT をトグルしています。

`darkroom-mode` から抜けるときは、`revert-buffer` でもとに戻します。

`yes/no`確認を聞かれるのが煩わしいので `(revert-buffer t t)` としています。

```elisp
(leaf darkroom
  :ensure t
  :bind (("<f12>" . my:darkroom-in)
		 (:darkroom-mode-map
		  ("<f12>" . my:darkroom-out)))
  :config
  (defun my:darkroom-in ()
	"Enter to the `darkroom-mode'."
	(interactive)
	(diff-hl-mode 0)
	(display-line-numbers-mode 0)
	(darkroom-mode 1)
	(setq-local line-spacing 0.5))

  (defun my:darkroom-out ()
	"Returns from `darkroom-mode' to the previous state."
	(interactive)
	(darkroom-mode 0)
	(display-line-numbers-mode 1)
	(revert-buffer t t))
```
