(require 'cl)
(require 'package)


(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)


(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

(ensure-package-installed   'evil
			    'evil-leader
			    'evil-org
			    'evil-surround
			    'company
			    'web-mode
			    'helm
			    'magit
			    'solarized-theme
			    'rainbow-delimiters
			    'flymake-ruby
			    'projectile
			    'helm-projectile
			    'powerline
			    'ruby-end
			    'emmet-mode
			    'better-defaults
			    )



(require 'evil)
(require 'evil-leader)
(require 'evil-org)
(require 'evil-surround)

(evil-leader/set-leader "\\")
(evil-leader/set-key "q" 'kill-this-buffer)
(evil-leader/set-key "p" 'fill-paragraph)
(evil-leader/set-key "a" 'align)
(evil-leader/set-key "<tab>" 'indent-region)
(evil-leader/set-key ";" 'comment-dwim)
(evil-leader/set-key "g" 'magit-status)
(evil-leader/set-key "u" 'undo-tree-visualize)
(evil-leader/set-key "e" 'helm-projectile)
(global-evil-leader-mode)               ;
(global-evil-surround-mode)

(evil-mode 1)


(load-theme 'solarized-dark t)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode -1)
(global-linum-mode 1) ; display line numbers
(column-number-mode 1) ; display column/row of cursor in mode-line
(show-paren-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'text-mode-hook
          (lambda ()
            ;; Hard-wrap text when in plaintext mode
            (turn-on-auto-fill)))

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; Stop littering everywhere with save files, put them somewhere
(setq backup-directory-alist '(("." . "~/.emacs-backups")))

;; Really nice completion for commands and whatnot
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Use company-mode in all buffers (more completion)
(add-hook 'after-init-hook 'global-company-mode)

;; Tabs are evil
(setq-default indent-tabs-mode nil)


;; Web mode stuff
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web_mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web_mode))
(add-to-list 'auto-mode-alist '("\\.scss?\\'" . web_mode))

(defun custom-web-mode-hook ()
  "Hooks for Web Mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(add-hook 'web-mode-hook 'custom-web-mode-hook)

(setq inhibit-startup-screen t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#073642")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (emmet-mode ruby-end helm-projectile solarized-theme web-mode rainbow-delimiters projectile magit flymake-ruby evil-surround evil-org company)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c85d17")
     (60 . "#be730b")
     (80 . "#b58900")
     (100 . "#a58e00")
     (120 . "#9d9100")
     (140 . "#959300")
     (160 . "#8d9600")
     (180 . "#859900")
     (200 . "#669b32")
     (220 . "#579d4c")
     (240 . "#489e65")
     (260 . "#399f7e")
     (280 . "#2aa198")
     (300 . "#2898af")
     (320 . "#2793ba")
     (340 . "#268fc6")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'projectile)
(projectile-global-mode)


(require 'helm-config)

(require 'powerline)
(powerline-default-theme)

(require 'ruby-end)

(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)

(electric-pair-mode)
