;;; modtime-skip-mode.el --- Minor mode for disabling modtime and supersession checks on files.
;;
;; Filename: modtime-skip-mode.el
;; Description: Minor mode for disabling modtime and supersession checks on files.
;; Author: Jordon Biondo <biondoj@mail.gvsu.edu>
;; Maintainer: Jordon Biondo
;; Created: Tue Jul 23 21:05:04 2013 (-0400)
;; Version: .1
;; Last-Updated: Tue Jul 23 21:08:12 2013 (-0400)
;;           By: Jordon Biondo
;;     Update #: 1
;; URL: www.github.com/jordonbiondo/modtime-skip-mode
;; Doc URL:
;; Keywords:
;; Compatibility: Tested on 24.3
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; modtime-skip-mode will disable the checking of modification times on files
;; when saving etc.  It will also disable the warning when a file has been changed on disc
;; since you're last save.
;;
;; Usage: M-x modtime-skip-mode to toggle modtime checking on and off
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;; 
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:
(defadvice ask-user-about-supersession-threat (around modtime/turn-it-off-ask)
  "Disable the supersession threat prompt."
  t)

(defadvice verify-visited-file-modtime (after modtime/turn-it-off-verify)
  "Always return t."
  (setq ad-return-value t))

(defun modtime/disable-checking()
  "Enable the checking whether a file has changed since your last save when modifing a buffer."
  (ad-disable-regexp "\\<modtime/turn-it-off-.*")
  (ad-update-regexp "\\<modtime/turn-it-off-.*"))

(defun modtime/enable-checking()
  "Disable the checking whether a file has changed since your last save when modifing a buffer."
  (ad-enable-regexp "\\<modtime/turn-it-off-.*")
  (ad-activate-regexp "\\<modtime/turn-it-off-.*")
  (ad-update-regexp "\\<modtime/turn-it-off-.*"))

(define-minor-mode modtime-skip-mode
  "Emacs will never think a file has been modified somewhere else."
  :init-value nil
  :lighter ""
  :global t
  (if modtime-skip-mode
      (modtime/enable-checking)
    (modtime/disable-checking)))

(provide 'modtime-skip-mode)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; modtime-skip-mode.el ends here
