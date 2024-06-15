(define (script-fu-export-webp-sizes img drawable directory prefix)
  (let* ((widths (list 1920 1440 960 720 480))
         (filename ""))
    ;; Process each width
    (for-each (lambda (width)
                (let* ((height (* (/ width (car (gimp-image-width img))) (car (gimp-image-height img))))
                       (new-image (car (gimp-image-duplicate img)))
                       (new-drawable (car (gimp-image-get-active-layer new-image))))
                  (gimp-image-scale new-image width height)
                  (set! filename (string-append directory "/" prefix "_" (number->string width) "w.webp"))
               (file-webp-save 1            ; Interactive, non-interactive
                                  new-image
                                  new-drawable
                                  filename
                                  filename
                                  1             ; preset  (Default=0, Picture=1, Photo=2, Drawing=3, Icon=4, Text=5)
                                  0             ; Use lossless encoding (0/1)
                                  85.0          ; Quality of the image (0 <= quality <= 100)
                                  85.0          ; Quality of the image's alpha channel (0 <= alpha-quality <= 100)
                                  0             ; animation (0=no animation)
                                  0             ; animation loop (0=no loop)
                                  0             ; minimize-size (0=no minimize)
                                  0             ; kf-distance (0=default distance)
                                  1             ; exif (0=do not save exif)
                                  0             ; iptc (0=do not save iptc)
                                  0             ; xmp (0=do not save xmp)
                                  0             ; delay (0=default delay)
                                  0)            ; force delay (0=no force)
                  (gimp-image-delete new-image)))
              widths)
    (gimp-displays-flush)
    (gimp-message "All images have been exported successfully.")))

(script-fu-register "script-fu-export-webp-sizes"
                    "Export as WebP in sizes"
                    "Export the image in different sizes as WebP with a filename prefix."
                    "Matthew Blum"
                    "Matthew Blum"
                    "2024"
                    "RGB*, GRAY*"
                    SF-IMAGE    "Image"    0
                    SF-DRAWABLE "Drawable" 0
                    SF-STRING   "Directory" "/home/username/Documents"
                    SF-STRING   "Prefix" "filename_prefix")

(script-fu-menu-register "script-fu-export-webp-sizes" "<Image>/File/Export")

