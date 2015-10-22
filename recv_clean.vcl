# Some generic URL manipulation, useful for all templates that follow
# First remove the Google Analytics added parameters, useless for our backend
if (req.url ~ "(\?|&)(utm_source|utm_medium|utm_campaign|utm_content|gclid|cx|ie|cof|siteurl)=") {
    set req.url = regsuball(req.url, "&(utm_source|utm_medium|utm_campaign|utm_content|gclid|cx|ie|cof|siteurl)=([A-z0-9_\-\.%25]+)", "");
    set req.url = regsuball(req.url, "\?(utm_source|utm_medium|utm_campaign|utm_content|gclid|cx|ie|cof|siteurl)=([A-z0-9_\-\.%25]+)", "?");
    set req.url = regsub(req.url, "\?&", "?");
    set req.url = regsub(req.url, "\?$", "");
}

# Strip hash, server doesn't need it.
if (req.url ~ "\#") {
    set req.url = regsub(req.url, "\#.*$", "");
}

# Strip a trailing ? if it exists
if (req.url ~ "\?$") {
    set req.url = regsub(req.url, "\?$", "");
}

# Some generic cookie manipulation, useful for all templates that follow
# Remove the "has_js" cookie
set req.http.Cookie = regsuball(req.http.Cookie, "has_js=[^;]+(; )?", "");

# Remove any Google Analytics based cookies
set req.http.Cookie = regsuball(req.http.Cookie, "__utm.=[^;]+(; )?", "");
set req.http.Cookie = regsuball(req.http.Cookie, "_ga=[^;]+(; )?", "");
set req.http.Cookie = regsuball(req.http.Cookie, "_gat=[^;]+(; )?", "");
set req.http.Cookie = regsuball(req.http.Cookie, "utmctr=[^;]+(; )?", "");
set req.http.Cookie = regsuball(req.http.Cookie, "utmcmd.=[^;]+(; )?", "");
set req.http.Cookie = regsuball(req.http.Cookie, "utmccn.=[^;]+(; )?", "");

# Remove DoubleClick offensive cookies
set req.http.Cookie = regsuball(req.http.Cookie, "__gads=[^;]+(; )?", "");

# Remove the Quant Capital cookies (added by some plugin, all __qca)
set req.http.Cookie = regsuball(req.http.Cookie, "__qc.=[^;]+(; )?", "");

# Remove the AddThis cookies
set req.http.Cookie = regsuball(req.http.Cookie, "__atuv.=[^;]+(; )?", "");

# Remove a ";" prefix in the cookie if present
set req.http.Cookie = regsuball(req.http.Cookie, "^;\s*", "");

# Are there cookies left with only spaces or that are empty?
if (req.http.cookie ~ "^\s*$") {
    unset req.http.cookie;
}
