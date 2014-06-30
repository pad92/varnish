vcl 4.0;
include "backend.vcl";

sub vcl_recv {
    if ( req.http.X-Forwarded-Proto !~ "(?i)https") {
        set req.http.X-Forwarded-Proto = "http";
    }

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }
    set req.http.X-Full-Uri = req.http.host + req.url;
    }
    set req.http.Surrogate-Capability = "key=ESI/1.0";
#   if (req.http.Content-Length !~ "[0-9]{7,}") {
#       return (pipe);
#   }
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

sub vcl_pipe {
#   http://www.varnish-cache.org/ticket/451
#   This forces every pipe request to be the first one.
    set bereq.http.connection = "close";
}

sub vcl_backend_response {
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
    if (beresp.http.Content-Type ~ "(image|audio|video|pdf|flash)") { set beresp.do_gzip = false; }
    if (beresp.http.Content-Type ~ "text")                          { set beresp.do_gzip = true; }
}

sub vcl_backend_error {
    include "error.vcl";
    return (deliver);
}
