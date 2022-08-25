+++
title = "1.1. eary-init.el"
draft = false
+++
### 早期初期化ファイル
🔗 [minorugh/.emacs.d/early-init.el](https://github.com/minorugh/.emacs.d/blob/main/early-init.el)

Emacs27から導入されたeary-init.el は、パッケージシステムやGUIの初期化が init.el で実行される前にロードされるので、UI関係や `package-enable-at-startup` のようなパッケージ初期化プロセスに影響を与える変数をカスタマイズできます。

### GCを減らす
GC の閾値を最大にしておくことで GC を実質止めることができます。とりあえず書いておけば速くなる系なのでおすすめです。

```elisp
;; Defer garbage collection further back in the startup process
(setq gc-cons-threshold most-positive-fixnum)
```
eary-init.el の先頭に書くことが重要です。

### パッケージの初期化を抑制する 
Emacs27では、(package-initialize) が 2回実行されます。
(1回は init ファイルの評価中に、もう 1回は Emacs が initファイルの読み取りを終了した後に)。

1回目を抑制するために以下を eary-init.el に記述することで初期化が少し早くなります。

```elisp
;; For slightly faster startup
(setq package-enable-at-startup nil)
```

### 常に最新のバイトコードをロードする

```elisp
;; Always load newest byte code
(setq load-prefer-newer t)

```

### フレームのサイズ変更を禁止する

```elisp
;; Inhibit resizing frame
(setq frame-inhibit-implied-resize t)
```

### これらを無効にする方が速い (初期化される前)

```elisp
;; Faster to disable these here (before they've been initialized)
(push '(fullscreen . maximized) default-frame-alist)
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
```

### 起動時の点滅を抑える
Emacsが設定ファイルを読み込むプロセスで画面がちらつくのを抑制します。

```elisp
;; Suppress flashing at startup
(setq inhibit-redisplay t)
(setq inhibit-message t)
(add-hook 'window-setup-hook
		  (lambda ()
			(setq inhibit-redisplay nil)
			(setq inhibit-message nil)
			(toggle-fullscreen)
			(redisplay)))
```
### 起動直後の背景色をテーマのそれと合わせる
Emacsが設定を読み込む色段階の背景色は白です。
自分は、タークテーマを使っているので、起動時から即黒背景になるようにここで設定しています。

```elisp
;; Startup setting
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)
(setq byte-compile-warnings '(cl-functions))
(custom-set-faces '(default ((t (:background "#282a36")))))
```

### Emacsのを常駐環境を考えてみた 
GUIのEmacsをシステム的に常駐化させるのは、自分にはハードルが高いので疑似環境ということでご紹介します。

* 最小化で自動起動させる
* `C-x C-c` で閉じれないようにする→他の用途に置き換えます
* フレームの閉じるボタンを隠す→常にフルスクリーンで使う

Emacsは、起動オプションに `--iconic` を付すことで最小化起動します。

Linuxの場合、「セッションと起動」を立ち上げて「自動開始アプリケーション」に下記の設定を追加するといいです。
```sell
emacs --iconic
```
