(setq dired-listing-switches "-hFAvilaD");diredでソート順を設定

(autoload 'open-junk-file "open-junk-file");;使い捨てないscratch
(defvar open-junk-file-directory)
(setq open-junk-file-directory "~/Documents/log/%Y_%m/")

(require 'wdired)
