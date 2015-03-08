(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; line wrap
(set-display-table-slot standard-display-table 'wrap ?\ )

;;  TRAMP
(setq tramp-default-method "sshx")

;; backup files
(setq make-backup-files nil)

(projectile-global-mode)

;; Indent - Rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;; (require 'indent-guide)
;; (indent-guide-global-mode)
;; (setq indent-guide-delay 0.)

;; Helm
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

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
(evil-leader/set-key
    "b" 'helm-buffers-list)

;; ORG mode
(setq org-time-clocksum-format (quote (:hours "%d" :require-hours t :minutes ":%02d" :require-minutes t)))
(setq org-pretty-entities t)

(evil-leader/set-key
    "d" 'org-time-stamp)
(evil-leader/set-key
    "t" 'org-time-stamp)
(evil-leader/set-key
    "i" 'org-clock-in)
(evil-leader/set-key
    "o" 'org-clock-out)
(evil-leader/set-key
    "r" 'org-ctrl-c-ctrl-c)
(evil-leader/set-key
    "a" 'org-table-align)
(evil-mode 1)

;; brackets/parentheses autocomplete
(electric-pair-mode 1)

;; like vim surround
(require 'evil-surround)
(global-evil-surround-mode 1)

(load-theme 'ample t)
(load-theme 'ample-light t)
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

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\.twig?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js-mode))
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("764e3a6472a3a4821d929cdbd786e759fab6ef6c2081884fca45f1e1e3077d1d" "8d6fb24169d94df45422617a1dfabf15ca42a97d594d28b3584dc6db711e0e0b" "895c6c225c84cc7a2485072a10ff251e24ba71fd5662f8f0fed2a2e4a56349ef" "1da471d12ceb1f6f06dc4666a3b6f063890927446535bebe75e8a3273e153414" "30e60749e77fc58bea4ace21feecb59d6a1f921845cd0fdd89f5c28de5e9574e" "520a785e4d67c323ac3dd26971a22bb4ec1b045543371b156ff3a577b2f844c3" "3ba8ee2890f53672f5b8baba841f79dcf983f2ae1537cd4209e5f0f6ea014941" "e6d5726c8db524411c35237d321b3d39555e5768fa02097c72806a297ef567ab" "08efabe5a8f3827508634a3ceed33fa06b9daeef9c70a24218b70494acdf7855" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "0f6e58d1814b4138c5a88241f96547d35883cbb3df6cf9ec8ef44856ece04c13" "9dae95cdbed1505d45322ef8b5aa90ccb6cb59e0ff26fef0b8f411dfc416c552" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
