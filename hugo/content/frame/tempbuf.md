+++
title = "5.5. tempbuf"
draft = false
+++
### [tempbuf.el] 不要になったと思われるバッファを自動的に kill
🔗 [emacswiki.org/emacs/tempbuf.el: Automatically deleted in the background](https://www.emacswiki.org/emacs/tempbuf.el)

`tempbuf.el` は不要になったと思われるバッファを自動的に kill してくれます。

使っていた時間が長い程、裏に回った時には長い時間保持してくれる。

つまり、一瞬開いただけのファイルは明示的に kill しなくても勝手にやってくれるのでファイルを開いてそのまま放置みたいなズボラな自分には便利です。

* `my:tembuf-ignore-files` は、勝手に kill させないファイルの指定
* `find-file-hook` は、`find-file` や `dired` で開いたファイルが削除対象
* `dired buffer` /`magit-buffer` は、無条件に削除

```elisp
(leaf tempbuf
  :el-get minorugh/tempbuf
  :hook ((find-file-hook . my:find-file-tempbuf-hook)
		 (dired-mode-hook . turn-on-tempbuf-mode)
		 (magit-mode-hook . turn-on-tempbuf-mode) )
  :init
  (setq my:tempbuf-ignore-files
		'("~/Dropbox/org/task.org"
          "~/Dropbox/org/capture.org"))

  (defun my:find-file-tempbuf-hook ()
	(let ((ignore-file-names (mapcar 'expand-file-name my:tempbuf-ignore-files)))
      (unless (member (buffer-file-name) ignore-file-names)
		(turn-on-tempbuf-mode)))))
```
