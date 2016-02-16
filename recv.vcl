#if (req.http.host ~ "(www\.|)wordpress\.domain\.ltd") {
#    if (req.url ~ "^/wp-(login|cron\.php|admin)" && !client.ip ~ internal) {
#        return (synth(403, "File is missing ;)"));
#    } elsif (req.url ~ "^/wp-content/" && (req.http.referer && req.http.referer !~ "^(http|https)://(www\.|)wordpress\.domain\.ltd/")) {
#        return (synth(403, "No hotlinking please"));
#    } elsif (!(req.http.cookie ~ "wordpress_logged_in" || req.url !~ "^/wp-(login|admin)" || req.http.cookie ~ "wordfence_verifiedHuman")) {
#        unset req.http.cookie;
#    } else {
#        set req.http.Cookie = regsuball(req.http.Cookie, "(^|;\s*)(_[_a-z]+|has_js)=[^;]*", "");
#        set req.http.Cookie = regsub(req.http.Cookie, "^;\s*", "");
#    }
#}