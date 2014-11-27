(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; line wrap
(set-display-table-slot standard-display-table 'wrap ?\ )

;; backup files
(setq make-backup-files nil)

;; Indent - Rainbow delimiters
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'indent-guide)
(indent-guide-global-mode)
(setq indent-guide-delay 0.)

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
(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)

;; xsel and emacs copy/paste hack
;; https://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
;; I prefer using the "clipboard" selection (the one the
;; typically is used by c-c/c-v) before the primary selection
;; (that uses mouse-select/middle-button-click)
(setq x-select-enable-clipboard t)

;; If emacs is run in a terminal, the clipboard- functions have no
;; effect. Instead, we use of xsel, see
;; http://www.vergenet.net/~conrad/software/xsel/ -- "a command-line
;; program for getting and setting the contents of the X selection"
(unless window-system
  (when (getenv "DISPLAY")
    ;; Callback for when user cuts
    (defun xsel-cut-function (text &optional push)
      ;; Insert text to temp-buffer, and "send" content to xsel stdin
      (with-temp-buffer
        (insert text)
        ;; I prefer using the "clipboard" selection (the one the
        ;; typically is used by c-c/c-v) before the primary selection
        ;; (that uses mouse-select/middle-button-click)
        (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
    ;; Call back for when user pastes
    (defun xsel-paste-function()
      ;; Find out what is current selection by xsel. If it is different
      ;; from the top of the kill-ring (car kill-ring), then return
      ;; it. Else, nil is returned, so whatever is in the top of the
      ;; kill-ring will be used.
      (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
        (unless (string= (car kill-ring) xsel-output)
          xsel-output )))
    ;; Attach callbacks to hooks
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)
    ;; Idea from
    ;; http://shreevatsa.wordpress.com/2006/10/22/emacs-copypaste-and-x/
    ;; http://www.mail-archive.com/help-gnu-emacs@gnu.org/msg03577.html
))
;; END xsel copy/paste hack

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes (quote ("9b4110996593f09fe4a32bc66651b1a94b417c01b1f7e55b2a267c60664d2790" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "53c0895f0811f73cc52c88bb09ef9db3810e3adc04c4588cec5159c36968c246" "66e132f01fb644169ae3f25ecf97c05ffe1a351e5b076e108b6d1c8e73017c32" "1f631dcf5095dccde5de018c8fb01304801c8ee432eca55a5800245bddf745e2" "c4d7c7ccedd70654a5632bf2e8070dbb674feb4754930020e0024a844793aa65" "2b51cae3782722ac39dc4c726052fdbd72e67ba22260a9f2618c59cadcaf19e4" "3a71a44eaa4ed1cc334acee1d829e735a2354e92605908fe6f72f32be564fc27" "3f844a81e3cd36ea5f6b12a6974af956629b30376a497fc14d07550ebd82f4ea" "dae5fa48a584571a76c65ee620ede530c097a68d6a1c889a23eea04d6d37c26c" "5f892d2f2e1ffcfde73727e53faf8ca7221bf1fb3df973bedf50e64e81684f6d" "2ab42b60c7ff322b57961608d95e2d977e516176683dd4b43139666c713c7ad6" "c2cfe2f1440d9ef4bfd3ef4cf15bfe35ff40e6d431264b1e24af64f145cffb11" "538c62e9c0d9b10b353895fd59b724db51a57ceb959ed2f9615516320df48cff" "84f4384b989f06f3696c6a1b799d1e672f752335e762fd0c1f22bfff8d6561ef" "20d329b30a646cb611cabe2421cd15ed2673585b4102a2b1f03eac8984556331" "2b8085f209f0159d82f2b4ee3d244595979c5742cf964d545809ccce330934de" "d36a8d53c02a2668a52cd38f23b8da878a30af9a7099d1559017b7cf380347d7" "b09981e36ee99d25168eb4f304d85ad1bcfb6da05a038074b8abba97ba9139b1" "dce83459e4031db3181c08dc5a0542416504c63bd2496fa12b3b81a0a35dc06e" "9e5e86abe457a3810eb335e8de554f46aca682f3e064e862ad8db73cc4e45b2f" "42ac06835f95bc0a734c21c61aeca4286ddd881793364b4e9bc2e7bb8b6cf848" default)))
 '(fci-rule-color "#383838")
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
