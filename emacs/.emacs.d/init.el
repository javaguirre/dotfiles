(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; line wrap
(set-display-table-slot standard-display-table 'wrap ?\ )

;;  TRAMP
(setq tramp-default-method "sshx")

;; Smart mode
(setq sml/no-confirm-load-theme t)
(require 'smart-mode-line)
(setq sml/theme 'automatic)
(sml/setup)
;; (sml/apply-theme 'dark)

;; backup files
(setq make-backup-files nil)

(projectile-global-mode)

;; Indent - Rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

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
(load-theme 'ample-flat t)
(enable-theme 'ample-flat t)
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
