include "backend.vcl";

sub vcl_recv {
    set client.identity = req.http.cookie;
    if ( req.http.X-Forwarded-Proto !~ "(?i)https") {
        set req.http.X-Forwarded-Proto = "http";
    }
    if (!req.backend.healthy) {
        set req.grace = 1h;
    }
    if (req.http.x-forwarded-for) {
        set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
    } else {
        set req.http.X-Forwarded-For = client.ip;
    }
}

sub vcl_deliver {
    unset resp.http.Link;
    unset resp.http.Server;
    unset resp.http.Via;
    unset resp.http.X-Drupal-Cache;
    unset resp.http.X-Powered-By;
    unset resp.http.X-Varnish;
}

sub vcl_hash {
    if (req.http.X-Forwarded-Proto) {
        hash_data(req.http.X-Forwarded-Proto);
    }
}

sub vcl_error {
    include "error.vcl";
    return (deliver);
}
