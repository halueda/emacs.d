+++
title = "9.5. savehist"
draft = false
weight = 5
+++
```elisp
;; Don't clear kill-ring when restart emacs
(savehist-additional-variables . '(kill-ring))
```