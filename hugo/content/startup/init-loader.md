+++
date = "2022-08-29T05:45:20+09:00"
title = "1.4. init-loader.el"
+++

## [init-loader.el] 設定ファイルのローダー 
🔗 [emacs-jp/init-loader: Loader of configuration files.](https://github.com/emacs-jp/init-loader/) 

起動時間が犠牲になるということで敬遠される向きもあるが微々たるもので、恩恵のほうが遥かに大きい。

`init-loader` には、エラーが出た設定ファイルは読み込まれない...という特徴があり原因究明がしやすくなるというメリットがある。またログの出力機能を備えていることもメリットとして挙げられる。

```elisp
(leaf init-loader
  :ensure t
  :init
  (load-file "~/.emacs.d/template/my:dired.el")
  (load-file "~/.emacs.d/template/my:template.el")
  :config
  (custom-set-variables
   '(init-loader-show-log-after-init 'error-only))
  (init-loader-load))
```

デフォルトで `~/.emacs.d/inits` デレクトリ以下のファイルを読み込みます。

## ユーザー設定ファイルのロード
ごく個人的なtemplateファイル群を `~/.emacs.d/template` フォルダーに置くようにしているので `init-loader` を起動する前にこれらを読み込むようにしている。

