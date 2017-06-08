;; Last-Updated: Thu Jun 08 12:55:11 JST 2017
;;     Update #: 649
;;   `gited--hide-details-set', `gited--last-remote-prune',
;;   `gited--op', `gited--revert-commit',
;;   `gited--running-async-op', `gited-actual-switches',
;;   `gited-after-change-hook', `gited-author-face',
;;   `gited-author-idx', `gited-bisect-buf-name',
;;   `gited-bisect-buffer', `gited-bisect-buffer',
;;   `gited-bisect-output-name', `gited-branch-after-op',
;;   `gited-branch-alist', `gited-branch-idx',
;;   `gited-branch-name-face', `gited-buffer',
;;   `gited-buffer-name', `gited-commit-idx',
;;   `gited-commit-msg-face', `gited-current-branch',
;;   `gited-date-idx', `gited-date-regexp',
;;   `gited-date-time-face', `gited-del-char',
;;   `gited-deletion-branch-face', `gited-deletion-face',
;;   `gited-edit-commit-mode-map', `gited-flag-mark-face',
;;   `gited-flag-mark-line-face', `gited-header',
;;   `gited-list-format', `gited-list-refs-format-command',
;;   `gited-log-buffer', `gited-mark-col-size',
;;   `gited-mark-face', `gited-mark-idx',
;;   `gited-marker-char', `gited-mode',
;;   `gited-mode-map', `gited-modified-branch',
;;   `gited-new-or-deleted-files-re', `gited-op-string',
;;   `gited-original-buffer', `gited-output-buffer',
;;   `gited-output-buffer-name', `gited-re-mark',
;;   `gited-ref-kind', `gited-section-highlight-face',
;;   `gited-toplevel-dir'.
;;   `gited-prune-remotes', `gited-reset-mode',
;;   `gited-short-log-cmd', `gited-show-commit-hash',
;;   `gited-switches', `gited-use-header-line',
;;   `gited-verbose'.
;;   `gited-remote-prune', `gited-remote-repository-p',
;;   `gited-repeat-over-lines', `gited-stashes',
;;   `gited-tabulated-list-entries', `gited-trunk-branches',
;;   `gited-untracked-files'.
(defvar-local gited--last-remote-prune nil "Time when was run `gited-remote-prune'.")
(put 'gited--last-remote-prune 'permanent-local t)  

(defcustom gited-prune-remotes 'daily
  "Whether if remove references to deleted remote branches."
  :type '(choice
          (const :tag "Never" nil)
          (const :tag "Always" t)
          (const :tag "daily" daily))
  :group 'gited)

  "List modified or untracked files according with REGEXP."
  (let ((regexp "^remote\."))
            (user-error "Cannot delete unmerged branches.  Try C-u %s"
                        (substitute-command-keys (this-command-keys)))))))))
      (user-error "Cannot run 2 Gited async process in parallel")
    (user-error "Not a Gited buffer"))
    (user-error "Cannot enable Gited mode in this buffer"))
    (user-error "Cannot rename a protected branch"))
             ("tags" (user-error "Rename tags not implemented!"))
             (_ (user-error "Unsupported gited-ref-kind: must be \
(defun gited-remote-prune ()
  "Remove references to deleted remote branches."
  (setq gited--last-remote-prune (current-time))
  (message "Prunning remote branches ...")
  (gited-git-command '("fetch" "--all" "--prune")))

      (user-error "Cannot delete the current branch"))
      (user-error "Cannot delete a protected branch"))
        ("tags" (user-error "Delete tags not implemented!"))
           (user-error "Cannot delete unmerged branch '%s'.  Try C-u %s"
        (_ (user-error "Unsupported gited-ref-kind: must be \
    (user-error "Cannot checkout a new branch: there are modified files"))
        (message "OK, canceled")
    (user-error "Cannot checkout a new branch: there are modified files"))
          (user-error "Only creation/deletion of files is implemented: %s"
   (let ((_files (or (gited-modified-files) (user-error "No changes to commit")))
  (or (gited-modified-files) (user-error "No changes to commit"))
  (user-error "This mode can be enabled only by `gited-edit-commit'"))
    (_ (user-error "Unsupported gited-ref-kind: must be local, remote or tags"))))
    (user-error "Gited should be listing local branches"))
    (user-error "Not listing local branches"))
    (user-error "Not a remote repository.  Try '%s' or '%s'"
          (user-error "No new patches")
    (user-error "This command only works for repositories \
      (user-error "No new patches to apply")
            (t (user-error "I don't know what is your master branch"))))
      (user-error "File '%s' not executable" file))))
                         (t (user-error "Commit should be either bad, \
         (user-error "Empty stash list"))
         (user-error "Commit your local changes before you switch branches"))
      (message "OK, canceled"))))
          (user-error "No next marked branch"))
      (user-error "No branch at point"))))
              (user-error "No Git repository in current directory"))
           "Collecting branch info..."
          (user-error "Can only kill branch lines")
    (user-error "Wrong input values: start, end, <"))
  (when gited-branch-alist
    (gited--move-to-column (1+ gited-branch-idx))))
       (user-error "No Git repository in current directory"))
      (user-error "No Git repository in current directory"))
      ;; Check if we must prune remotes.
      (when (and (not (equal gited-ref-kind "local"))
                 (or (eq t gited-prune-remotes)
                     (and (eq 'daily gited-prune-remotes)
                          (or (not gited--last-remote-prune)
                              (time-less-p (seconds-to-time (* 24 60 60))
                                           (time-subtract (current-time) gited--last-remote-prune))))))
        (gited-remote-prune))
    (user-error "Gited mode cannot be enabled in this buffer"))