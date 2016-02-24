#if  (bereq.http.host ~ "^static.domain.ltd$") {
#    unset beresp.http.set-cookie;
#}

#if ((beresp.http.host ~ "(www\.|)wordpress1\.com" ||
#     beresp.http.host ~ "(www\.|)wordpress2\.fr" ||
#     beresp.http.host ~ "(www\.|)wordpress3\.com") && (beresp.http.Set-Cookie && bereq.url !~ "^/wp-(login|admin)")) {
#        unset beresp.http.Set-Cookie;
#}