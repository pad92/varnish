## Protection hot linking
#if ((req.http.host ~ "(www\.|)site1\.com" ||
#     req.http.host ~ "(www\.|)site2\.fr" ||
#     req.http.host ~ "(www\.|)site3\.com") &&
#     req.url ~ "^/(wp-content|static)/$" &&
#        (req.http.referer &&
#            (req.http.referer !~ "^http(|s)://([a-z-]+\.|)(site1|site2|site3)\.(com|fr)/"))
#        )
#{
#    return (synth(403, "Hot linking deny"));
#}


## Exemple wordpress
#if (req.http.host ~ "(www\.|)wordpress1\.com") {
#        if ((req.url ~ "^/(wp-login|cron\.php|wp-admin|xmlrpc.php)" || req.url ~ "preview=true" ) && !client.ip ~ internal) {
#                return (synth(404, "Not Found"));
#        } elsif (req.url !~ "^/wp-(login|admin)" && req.url !~ "preview=true" && req.url !~ "xmlrpc.php" && req.http.Cookie !~ "wordpress_logged_in_") {
#                unset req.http.cookie;
#        }
#        set req.backend_hint = default;
#}