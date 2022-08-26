+++
title = "10.5. magit"
draft = false
+++
### [magit.el] Gitクライアント
🔗 [magit/magit.el: Git user interface.](https://github.com/magit/magit/tree/master/lisp) 

`magit status` は、デフォルトでは `other-window` に表示されますが、フルフレームで表示されるようにしました。

```elisp
(leaf magit
  :ensure t
  :bind (("M-g s" . magit-status)
		 ("M-g b" . magit-blame)
		 ("M-g t" . git-timemachine-toggle))
  :hook (magit-post-refresh-hook . diff-hl-magit-post-refresh)
  :custom (transient-history-file . "~/.emacs.d/tmp/transient-history")
  :init
  (leaf diff-hl	:ensure t
	:hook ((after-init-hook . global-diff-hl-mode)
		   (after-init-hook . diff-hl-margin-mode)))

  (leaf git-timemachine	:ensure t)

  (leaf browse-at-remote :ensure t
	:custom (browse-at-remote-prefer-symbolic . nil)))
(setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1)
```

### [git-timemachine.el]
🔗 [emacsmirror/git-timemachine: Walk through git revisions of a file.](https://github.com/emacsmirror/git-timemachine) 

次のキーを使用して、ファイルの履歴バージョンをナビゲートしてくれます。
* `p` 以前の履歴バージョンにアクセスする
* `n` 次の履歴バージョンにアクセス
* `w` 現在の履歴バージョンの省略されたハッシュをコピーします
* `W` 現在の履歴バージョンの完全なハッシュをコピーします
* `g` n 番目のリビジョンに移動
* `t` 選択したコミットメッセージでリビジョンに移動
* `q` タイムマシンを終了します。
* `b` 現在アクセスしているリビジョンで実行magit-blameします (magit が利用可能な場合)。
* `c` magit を使用して現在のコミットを表示します (magit が利用可能な場合)。

### [browse-at-remote.el]
🔗 [rmuslimov/browse-at-remote: Browse target page on github/bitbucket from emacs buffers](https://github.com/rmuslimov/browse-at-remote) 

`browse-at-remote.el` は、Git管理しているEmacsバッファーからgithubの特定リンクを瞬時に開くことができる優れものです。

