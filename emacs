(menu-bar-mode 0)

;; Arduino + emacs https://www.emacswiki.org/emacs-test/ArduinoSupport
(setq auto-mode-alist (cons '("\\.\\(pde\\|ino\\)$" . arduino-mode) auto-mode-alist))
(autoload 'arduino-mode "arduino-mode" "Arduino editing mode." t)

(menu-bar-mode 0)


;; Turns on syntax highlighting for all files for which emacs knows how to
;; highlight.
(global-font-lock-mode t)

;; Makes the space between the "mark" and the "point" be highlighted -
;; essentially, emacs' notion of the "currently selected text". This is
;; probably what you expect if you're coming from another text editor.
(transient-mark-mode t)

;; Removes trailing whitespace from your lines before saving
;; files. Trailing whitespace is the devil.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Makes sure your files end in a newline before saving them. Terminating
;; newlines are a Good Idea.
(setq require-final-newline t)

;; Put backups somewhere not obnoxious.
(setq backup-directory-alist `(("." . "~/.saves")))

;; Diable hard tabs
(setq-default indent-tabs-mode nil)

;; 4 space indent
;;(setq standard-indent 4)
(setq-default tab-width 4)

;; cycle windows in reverse order
(defun prev-window ()
  (interactive)
  (other-window -1)
)
(global-set-key (kbd "C-x p") 'prev-window)

;;(global-set-key (kbd "") 'scroll-down-command)

;; Enable column numbers as well
(column-number-mode 1)

;; Load some files
(add-to-list 'load-path "~/.emacs.d/elisp")

;; Auto detect indent style for c
;;(add-hook 'c-mode-common-hook
;;  (lambda()
;;    (require 'dtrt-indent)
;;    (dtrt-indent-mode t))
;;)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
(semantic-mode 1)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
              (url (concat (if no-ssl "http" "https") "://stable.melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa-stable" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (haskell-mode company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; HERE BE ATG STUFF

;-----------------------------;
;        C++ Indentation, Thanks to Joe Lisee
;-----------------------------;

(c-add-style "uatc-c-style"
  '((c-auto-newline                 . nil)
    (c-basic-offset                 . 4)
    (c-comment-only-line-offset     . 0)
    (c-hanging-braces-alist         . ((substatement-open after)
                                       (brace-list-open)))
    (c-offsets-alist                . ((arglist-close . c-lineup-arglist)
                                       (case-label . 4)
                                       (substatement-open . 0)
                                       (block-open . 0) ; no space before {
                                       (inline-open . 0) ; no space before {
                                       (knr-argdecl-intro . -)
                                       (innamespace . 0)))
    (c-hanging-colons-alist         . ((member-init-intro before)
                                       (inher-intro)
                                       (case-label after)
                                       (label after)
                                       (access-label after)))
    (c-cleanup-list                 . (scope-operator
                                       empty-defun-braces
                                       defun-close-semi))))

(setq-default indent-tabs-mode nil)
(c-set-offset 'comment-intro 0)
(setq c-default-style "uatc-c-style")

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/rtags")

(require 'company)
(require 'rtags)

(setq rtags-autostart-diagnostics t)

(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)

(rtags-enable-standard-keybindings nil "\C-t")
(define-key c-mode-base-map (kbd "M-=") (function rtags-symbol-type))
(define-key c-mode-base-map (kbd "M-.") (function rtags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function rtags-find-references-current-file))
(define-key c-mode-base-map (kbd "M-/") (function rtags-find-all-references-at-point))
(define-key c-mode-base-map (kbd "M-i") (function rtags-imenu))
(define-key c-mode-base-map (kbd "<C-tab>") (function company-complete))
