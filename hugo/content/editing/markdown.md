+++
title = "6.1. markdown-mode"
draft = false
+++
### [markdown-mode.el] markdownモード編集、入力支援
🔗 [jrblevin/markdown-mode: Emacs Markdown Mode.](https://github.com/jrblevin/markdown-mode) 

Markdown形式のテキストを編集するための主要なモードです。

```elisp
(leaf markdown-mode
  :ensure t
  :mode ("\\.md\\'")
  :custom
  `((markdown-italic-underscore . t)
    (markdown-asymmetric-header . t)
	(markdown-fontify-code-blocks-natively . t))
```

markdownファイルのプレビューには、`emacs-livedown`を使っています。
記事を書きながらライブでプレビュー出来るすぐれものです。

🔗 [shime/emacs-livedown: Emacs plugin for Livedown.](https://github.com/shime/emacs-livedown)

```session
$ npm install -g livedown
```
でインストールできます。

`emacs-livedown.elisp` は、`el-get` でインストールします。

```elisp
(leaf emacs-livedown
 :el-get shime/emacs-livedown
 :bind (("C-c C-c p" . livedown-preview)
        ("C-c C-c k" . livedown-kill)))
```
