#if  (bereq.http.host ~ "^static.domain.ltd$") {
#    unset beresp.http.set-cookie;
#}
