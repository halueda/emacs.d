+++
title = "10.4. quickrun"
draft = false
+++
### [quickrun.el] お手軽ビルド
🔗 [emacsorphanage/quickrun: Run command quickly.](https://github.com/emacsorphanage/quickrun) 

カレントバッファで編集中のソースコードをビルド・実行して別バッファに結果を得ます。
`open-junk-file` でショートプログラムを書きながら、その都度 `quickrun` させて…という具合に便利に使えて重宝です。

```elisp
(leaf quickrun
  :ensure t
  :bind ("<f5>" . quickrun))
```
