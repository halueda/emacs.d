+++
title = "5.4. tempbuf"
draft = false
+++
## [tempbuf.el] 不要なバッファを自動的に kill
🔗 [emacswiki.org/emacs/tempbuf.el: Automatically deleted in the background](https://www.emacswiki.org/emacs/tempbuf.el)

`tempbuf.el` は不要になったと思われるバッファを自動的に kill してくれます。

使っていた時間が長い程、裏に回った時には長い時間保持してくれる。

つまり、一瞬開いただけのファイルは明示的に kill しなくても勝手にやってくれるのでファイルを開いてそのまま放置みたいなズボラな自分には便利です。

* `my:tembuf-ignore-files` は、勝手に kill させないファイルの指定
* `find-file-hook` は、`find-file` で開いたファイルが削除対象
* `dired buffer` /`magit-buffer` は、無条件に削除

```elisp
(leaf tempbuf
  :el-get (tempbuf :url "http://www.emacswiki.org/emacs/download/tempbuf.el")
  :hook ((find-file-hook . my:find-file-tempbuf-hook)
		 (dired-mode-hook . turn-on-tempbuf-mode)
		 (magit-mode-hook . turn-on-tempbuf-mode) )
  :custom `((tempbuf-kill-message . nil)
			(my:tempbuf-ignore-files . "~/Dropbox/org/task.org"))
  :init
  (defun my:find-file-tempbuf-hook ()
	(let ((ignore-file-names (mapcar 'expand-file-name my:tempbuf-ignore-files)))
      (unless (member (buffer-file-name) ignore-file-names)
		(turn-on-tempbuf-mode)))))
```
