+++
date = "2022-08-29T05:53:26+09:00"
title = "6.4. yatex"
draft = false
weight = 4
+++

## [yatex.el] LaTex編集
🔗 [emacsmirror/yatex: Yet Another tex-mode for emacs. //野鳥//](https://github.com/emacsmirror/yatex)

Emacsの上で動作する LaTeX の入力支援環境です。

ごく一般的な設定例ですが、参考になるとしたら `YateX.lpr` コマンドでPDF作成からプレビューまでの手順を自動化している点でしょうか。

```elisp
(leaf yatex
  :ensure t
  :mode ("\\.tex\\'" "\\.sty\\'" "\\.cls\\'")
  :hook (yatex-mode-hook . (lambda ()(interactive)(view-mode -1)))
  :custom
  `((tex-command . "platex")
	(dviprint-command-format . "dvpd.sh %s")
	(YaTeX-kanji-code . nil)
	(YaTeX-latex-message-code . 'utf-8)
	(YaTeX-default-pop-window-height . 15)))
(leaf yatexprc
  :after yatex
  :bind (("M-c" . YaTeX-typeset-buffer)
		 ("M-v" . YaTeX-lpr)))
```
`YaTeX-lpr` は、`dviprint-command-format` を呼び出すコマンドです。

`dvipdfmx` で PDF作成したあと、ビューアーを起動させて表示させるところまでをバッチファイル `dvpd.sh` に書き、
```shellsession
$ chmod +x dvpd.sh
```
として実行権限を付与してからPATHの通ったところに置きます。

私は `/usr/loca/bin` に置いています。

```shellsession
#!/bin/sh
name=$1
dvipdfmx $1 && evince ${name%.*}.pdf
# Delete unnecessary files
rm *.au* *.dv* *.lo*
```
上記の例では、ビューアーに Linuxの `evince` を設定していますが、Macの場合は、下記のようになるかと思います。

```shellsession
dvipdfmx $1 && open -a Preview.app ${name%.*}.pdf
```
