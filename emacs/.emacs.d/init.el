(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(require 'evil)
(evil-mode 1)

(load-theme 'zenburn t)
(global-linum-mode 1) (ido-mode 1)

(setq-default indent-tabs-mode nil)
(global-hl-line-mode 1)
(setq tab-width 4)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq inhibit-startup-message t
 inhibit-startup-echo-area-message t)
(setq-default show-trailing-whitespace t)
(define-key global-map (kbd "RET") 'newline-and-indent)
(global-font-lock-mode 1)
(global-git-gutter-mode +1)

;; git gutter
(setq git-gutter:modified-sign "~")
(set-face-foreground 'git-gutter:modified "orange")

;; line number space
(setq linum-format "%3d ")

;; jk for vim
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'go-mode-hook
  (lambda ()
  (setq-default)
  (setq tab-width 4)
  (setq standard-indent 4)
  (setq indent-tabs-mode nil)))

;; Go
(add-to-list 'load-path "~/Proyectos/go/src/github.com/dougm/goflymake")
(require 'go-flymake)

;; Org
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; backup files
(setq make-backup-files nil)
