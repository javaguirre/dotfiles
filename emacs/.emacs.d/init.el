(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Helm
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; Yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.d/.cask/24.3.1/elpa/yasnippet-20140821.38/snippets"
        "~/.emacs.d/snippets"))
(yas-global-mode 1)


;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(require 'evil)
(global-evil-leader-mode)
(evil-leader/set-key
    "c" 'delete-trailing-whitespace)
(evil-mode 1)

;; brackets/parentheses autocomplete
(electric-pair-mode 1)

;; like vim surround
(require 'evil-surround)
(global-evil-surround-mode 1)

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

;; col-highlight
(setq column-highlight-mode t)

;; jk for evil
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)

;; android
(add-to-list 'load-path "/home/javaguirre/apps/android-sdk-linux/")
(require 'android-mode)
(custom-set-variables '(android-mode-sdk-dir "/home/javaguirre/apps/android-sdk-linux/tools/android"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-hook 'go-mode-hook
  (lambda ()
  (setq-default)
  (setq tab-width 4)
  (setq standard-indent 4)
  (setq indent-tabs-mode nil)))

;; Org
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; backup files
(setq make-backup-files nil)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig?\\'" . web-mode))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
