;; d-mode
(add-hook 'd-mode-hook
	  (lambda ()
	    (disable-indent-tabs-mode)
	    (setup-flycheck-d-unittest)
	    (flycheck-dmd-dub-set-variables)))

;; Copy buffer to submit
(defun d-copy-for-submit ()
  (interactive)
  (let ((old-buf (current-buffer)))
    (cl-flet* ((delete-line () (delete-region (line-beginning-position) (+ (line-end-position) 1)))
               (search-and-remove (x) (if (search-forward x nil t) (delete-line))))
      (with-temp-buffer
        (insert-buffer-substring old-buf)
        (goto-char (point-min))
        (while (re-search-forward "^\\(version(unittest)\\|// \\(path\\|url\\):\\)" nil t)
          (delete-line)
          (delete-blank-lines)
          (goto-char (point-min)))
        (search-forward "void main()")
        (let ((readv (count-matches "readV("))
              (reada (count-matches "readA("))
              (readm (count-matches "readM("))
              (readc (count-matches "readC("))
              (reads (count-matches "readS(")))
          (goto-char (point-min))
          (if (eq readv 0) (search-and-remove "readV("))
          (if (and (eq reada 0) (eq readm 0)) (search-and-remove "readA("))
          (if (eq readm 0) (search-and-remove "readM("))
          (if (eq readc 0) (search-and-remove "readC("))
          (if (eq reads 0) (search-and-remove "readS(")))
        (clipboard-kill-ring-save (point-min) (point-max))))))

;; yasnippet
(require 'yasnippet)
(setq yas-snippet-dirs (append yas-snippet-dirs
			       '("~/projects/procon2/emacs/snippets")))
(yas-global-mode 1)
