(require 'popwin)
(setq special-display-function 'popwin:special-display-popup-window)

(push '("*auto-async-byte-compile*") popwin:special-display-config)
