(menu-bar-mode 0)

;; sml horseshit
(add-to-list 'load-path
             "~/.emacs.d/elisp/sml-mode")
(autoload 'sml-mode "sml-mode" "Major mode for editing SML." t)
(autoload 'run-sml "sml-proc" "Run an inferior SML process." t)
(setq sml-program-name "/usr/bin/sml")
(defun my-sml-mode-hook () "Local defaults for SML mode"
  (setq sml-indent-level 2)             ; conserve on horizontal space
  (setq words-include-escape t)         ; \ loses word break status
  (setq indent-tabs-mode nil))          ; never ever indent with tabs
(add-hook 'sml-mode-hook 'my-sml-mode-hook)
(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))


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
(add-hook 'c-mode-common-hook
  (lambda()
    (require 'dtrt-indent)
    (dtrt-indent-mode t))
)

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
(semantic-mode 1)
