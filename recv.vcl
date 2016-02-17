#if (req.http.host ~ "(www\.|)wordpress\.domain\.ltd") {
#    if ((req.url ~ "^/wp-(login|cron\.php|admin)" || req.url ~ "preview=true" ) && !client.ip ~ internal) {
#         return (synth(404, "Not Found"));
#    } elsif (req.url ~ "^/wp-content/" && (req.http.referer && req.http.referer !~ "^(http|https)://(www\.|)wordpress\.domain\.ltd/")) {
#        return (synth(403, "No hotlinking please"));
#    } elsif (req.url !~ "^/wp-(login|admin)" && req.url !~ "preview=true" && req.url !~ "xmlrpc.php"  && req.http.Cookie !~ "wordpress_logged_in_") {
#        unset req.http.cookie;
#    }
#}