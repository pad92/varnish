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

sub vcl_backend_response {
#   stream if size > 9Mb
#   From http://stackoverflow.com/a/23065861
    if (beresp.http.Content-Length ~ "[0-9]{7,}" ) {
        set beresp.do_stream = true;
    }
}

sub vcl_pipe {
#   http://www.varnish-cache.org/ticket/451
#   This forces every pipe request to be the first one.
    set bereq.http.connection = "close";
}

sub vcl_backend_error {
    include "error.vcl";
    return (deliver);
}
