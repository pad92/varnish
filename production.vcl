vcl 4.0;
include "backend.vcl";
#include "acl.vcl";

sub vcl_recv {
    if ( req.url ~ "^/w00tw00t")                    { return (synth(404, "Not Found")); }
    if ( req.http.X-Forwarded-Proto !~ "(?i)https") { set req.http.X-Forwarded-Proto = "http"; }

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }
    set req.http.X-Full-Uri = req.http.host + req.url;
    set req.http.Surrogate-Capability = "key=ESI/1.0";
}

sub vcl_deliver {
    unset resp.http.Link;
    unset resp.http.Server;
    unset resp.http.Via;
    unset resp.http.X-Drupal-Cache;
    unset resp.http.X-Powered-By;
    unset resp.http.X-Varnish;
    unset resp.http.Composed-By;
    unset resp.http.X-CF-Powered-By;
}

sub vcl_hash {
    if (req.http.X-Forwarded-Proto) {
        hash_data(req.http.X-Forwarded-Proto);
    }
}

sub vcl_backend_response {
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
}

sub vcl_backend_error {
    include "error.vcl";
    return (deliver);
}
