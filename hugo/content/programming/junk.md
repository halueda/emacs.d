+++
title = "10.8. open-junk-file"
draft = false
+++
### [open-junk-file.el] 使い捨てファイルを書く、開く
🔗 [rubikitch/open-junk-file: Write a disposable file.](https://github.com/rubikitch/open-junk-file) 

ファイルを howmフォルダーに保存すると、`howm-list` からの検索機能が利用できます。
`howm`は、ローマ字での日本語検索も可能なのでとても便利です。

```elisp
(leaf open-junk-file :ensure t
  :config
  (setq open-junk-file-format "~/Dropbox/howm/junk/%Y%m%d.")
  (setq open-junk-file-find-file-function 'find-file))
```

直近の junkファイルを即開けるように `open-last-junk-file` を定義しました。

```elisp
(leaf em-glob
 :require t
 :config
 (defvar junk-file-dir "~/Dropbox/howm/junk/")
 (defun open-last-junk-file ()
   "Open last created junk-file."
   (interactive)
   (find-file
    (car
	    (last (eelisp-extended-glob
	   	   (concat
   			(file-name-as-directory junk-file-dir)
			"*.*.*")))))))
```

