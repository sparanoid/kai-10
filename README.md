Twenty Ten Kai
==============

A WordPress theme mod of Twenty Ten, originally used for nio2.com


Setup Guide
-----------

1. Add `<link rel=stylesheet media=all href="//github.com/sparanoid/twentyten-kai/raw/master/twentyten-kai.css">` right after default styles in `header.php`.
2. Open `functions.php` and search `twentyten_header_image_width`, then change to width value to `980`.
3. Reupload your header image in backend then it will be exactly 980px width (without streching).


Alternative Styles
------------------

* Add `<link rel=stylesheet media=all href="//github.com/sparanoid/twentyten-kai/raw/master/twentyten-kai-narrow.css">` right after `twentyten-kai.css` in `header.php` will enable a narrow version of Twenty Ten.
    * Note if you use the narrow css, change `twentyten_header_image_width` to `500` in `functions.php`.
* Add `<link rel=stylesheet media=all href="//github.com/sparanoid/twentyten-kai/raw/master/twentyten-kai-small-header.css">` will enable a smaller font size in blog header.
* Add `<link rel=stylesheet media=all href="//github.com/sparanoid/twentyten-kai/raw/master/twentyten-kai-sans-serif.css">` will change default serif font family in Twenty Ten to sans-serif ones. Better for some asian characters.


License
-------

The license under which the Twenty Ten Kai is released is the GPLv2 from the [Free Software Foundation][fsf].

[fsf]: http://www.fsf.org
