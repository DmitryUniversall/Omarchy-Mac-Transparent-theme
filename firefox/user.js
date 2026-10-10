// Mac Transparent for Firefox. Read at every Firefox start.

// Load chrome/userChrome.css and chrome/userContent.css.
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Give the window an alpha channel and don't declare it opaque to the
// compositor, so the translucent toolbar shows the blurred desktop.
user_pref("widget.transparent-windows", true);
user_pref("widget.wayland.opaque-region.enabled", false);
