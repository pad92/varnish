#if (req.http.host ~ "(www\.|)wordpress\.domain\.ltd") {
#    if (req.url ~ "^/wp-(login|cron\.php|admin)" && !client.ip ~ internal) {
#        return (synth(403, "File is missing ;)"));
#    } elsif (req.url ~ "^/wp-content/" && (req.http.referer && req.http.referer !~ "^(http|https)://(www\.|)wordpress\.domain\.ltd/")) {
#        return (synth(403, "No hotlinking please"));
#    } elsif ( !(req.url ~ "wp-(login|admin)") && !(req.url ~ "&preview=true")  ) {
#        unset req.http.cookie;
#    }
#}