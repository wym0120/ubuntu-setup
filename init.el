;;(when (>= emacs-major-version 24)
;;     (require 'package)
;;     (package-initialize)
;;     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;;		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;; MELPA packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Proof general
(load "~/PG/generic/proof-site")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company-coq))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq proof-three-window-mode-policy 'hybrid)

 ;; cl - Common Lisp Extension
 (require 'cl)

 ;; Add Packages
 (defvar my/packages '(
		;; --- Auto-completion ---
		company
		;; --- Better Editor ---
		hungry-delete
		swiper
		counsel
		smartparens
		;; --- Major Mode ---
		js2-mode
		;; --- Minor Mode ---
		nodejs-repl
		exec-path-from-shell
		;; --- Themes ---
		monokai-theme
		company-coq
		;; solarized-theme
		) "Default packages")
 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
        (loop for pkg in my/packages
                   when (not (package-installed-p pkg)) do (return nil)
                        finally (return t)))

 (unless (my/packages-installed-p)
        (message "%s" "Refreshing package database...")
             (package-refresh-contents)
                  (dolist (pkg my/packages)
                           (when (not (package-installed-p pkg))
                                (package-install pkg))))

(setq initial-frame-alist (quote ((fullscreen . maximized))))

(global-hl-line-mode 1)

(electric-indent-mode 1)

(load-theme 'monokai 1)
(require 'hungry-delete)
(global-hungry-delete-mode)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)

(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
;(require 'smartparens)
;(smartparens-global-mode t)
;; (add-hook 'js-mode-hook #'smartparens-mode)
;;
;; 关闭工具栏，tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)

;; 关闭文件滑动控件
(scroll-bar-mode -1)

;; 显示行号
(global-linum-mode 1)

;; 更改光标的样式（不能生效，解决方案见第二集）
(setq cursor-type 'bar)

;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)

;; 关闭缩进 (第二天中被去除)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

;; 快速打开配置文件
(defun open-init-file()
  (interactive)
    (find-file "~/.emacs.d/init.el"))

    ;; 这一行代码，将函数 open-init-file 绑定到 <f2> 键上
    (global-set-key (kbd "<f2>") 'open-init-file)

    ;; 开启全局 Company 补全
    (global-company-mode 1)

    (setq mac-command-modifier 'meta) ; make cmd key do Meta
    (setq mac-option-modifier 'super) ; make opt key do Super

    ;; 关闭自动生成备份文件
    (setq make-backup-files nil)

    ;; 打开最近编辑过的文件
    (require 'recentf)
    (recentf-mode 1)
    (setq recentf-max-menu-item 10)

    ;; 这个快捷键绑定可以用之后的插件 counsel 代替 
    ;;

(add-hook 'text-mode-hook 'my-custom-settings-fn)

(delete-selection-mode 1)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)
(global-set-key (kbd "C-h C-k") 'find-function-on-key)

(show-paren-mode 1)
(setq show-paren-delay 0)
;(load "~/.emacs.d/lisp/PG/generic/proof-site")
;; Load company-coq when opening Coq files
(add-hook 'coq-mode-hook #'company-coq-mode)
;; ocaml
;; (load "/Users/lost/.opam/4.04.0/share/emacs/site-lisp/tuareg-site-file")

(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var"      "share")))))
      (when (and opam-share (file-directory-p opam-share))
             ;; Register Merlin
                    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
                           (autoload 'merlin-mode "merlin" nil t nil)
                                  ;; Automatically start it in OCaml buffers
                                         (add-hook 'tuareg-mode-hook 'merlin-mode t)
                                                (add-hook 'caml-mode-hook 'merlin-mode t)
                                                       ;; Use opam switch to lookup ocamlmerlin binary
                                                              (setq merlin-command 'opam)))
(define-key ctl-x-map "l" 'goto-line)
(custom-set-variables
 '(company-coq-features/prettify-symbols-in-terminals nil)
  '(company-idle-delay 0.1)
   '(company-minimum-prefix-length 1)
'(coq-prog-args (quote ("-R" "/Users/lost/Desktop/cpdt/src" "Cpdt")))
;; '(coq-prog-name "/usr/local/bin/coqtop")
;; '(coq-prog-name "/Users/lost/env/coqenv/bin/coqtop")
 '(coq-script-indent t)
  '(cursor-type (quote box))
   '(custom-safe-themes
      (quote
          ("f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c"         default)))
           '(electric-indent-mode t)
            '(indent-tabs-mode t)
             '(package-selected-packages (quote (company-coq org company)))
              '(proof-multiple-frames-enable nil)
               '(proof-script-fly-past-comments t)
                '(proof-three-window-enable t)
                 '(proof-three-window-mode-policy (quote hybrid))
                  '(show-paren-mode t)
                   '(tool-bar-mode nil))

(custom-set-faces
   ;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
   '(default ((t (:inherit nil :stipple nil :background "#272822" :foreground     "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :       underline nil :slant normal :weight normal :height 140 :width normal :foundry   "nil" :family "Menlo")))))
   (defun customize-company-coq ()
     (show-paren-mode -1)
       (prettify-symbols-mode -1))
       (add-hook 'coq-mode-hook #'customize-company-coq t)    

;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
