vcl 4.0;
import std;

include "acl.vcl";
include "backend.vcl";

sub vcl_recv {
    if ( req.url ~ "^/w00tw00t")                    { return (synth(404, "Not Found")); }
    if ( req.http.X-Forwarded-Proto !~ "(?i)https") { set req.http.X-Forwarded-Proto = "http"; }

    if (req.method == "PURGE") {
        if (!client.ip ~ purge) {
            return(synth(404, "Not Found"));
        }
        return (purge);
    }

    if (req.restarts == 0) {
        if (req.http.x-forwarded-for) {
            set req.http.X-Forwarded-For = req.http.X-Forwarded-For + ", " + client.ip;
        } else {
            set req.http.X-Forwarded-For = client.ip;
        }
    }
    set req.http.X-Full-Uri = req.http.host + req.url;
    include "recv_clean.vcl";
    set req.http.Surrogate-Capability = "key=ESI/1.0";

    include "recv.vcl";
}

sub vcl_backend_response {
    set beresp.do_stream = true;
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
    include "backend_response.vcl";
}


sub vcl_hit {
    if (!std.healthy(req.backend_hint)) {
#       backend is sick - use full grace
        if (obj.ttl + obj.grace > 0s) {
            set req.http.grace = "full";
            return (deliver);
        }
    }
}


sub vcl_deliver {
    unset resp.http.Composed-By;
    unset resp.http.Link;
    unset resp.http.Server;
    unset resp.http.Via;
    unset resp.http.X-CF-Powered-By;
    unset resp.http.X-Drupal-Cache;
    unset resp.http.X-Generator;
    unset resp.http.X-Powered-By;
    unset resp.http.X-Varnish;
}

sub vcl_hash {
    if (req.http.X-Forwarded-Proto) {
        hash_data(req.http.X-Forwarded-Proto);
    }
}

sub vcl_pipe {
    if (req.http.upgrade) {
        set bereq.http.upgrade = req.http.upgrade;
    }
    set bereq.http.connection = "close";
}


sub vcl_backend_response {
    if (beresp.http.Surrogate-Control ~ "ESI/1.0") {
        unset beresp.http.Surrogate-Control;
        set beresp.do_esi = true;
    }
}

sub vcl_pipe {
    if (req.http.upgrade) {
        set bereq.http.upgrade = req.http.upgrade;
    }

#   http://www.varnish-cache.org/ticket/451
#   This forces every pipe request to be the first one.
    set bereq.http.connection = "close";
}


sub vcl_synth {
    set resp.http.Content-Type = "text/html; charset=utf-8";
    set resp.http.Retry-After = "5";
    include "error.vcl";
    return (deliver);
}

sub vcl_backend_error {
    set beresp.http.Content-Type = "text/html; charset=utf-8";
    set beresp.http.Retry-After = "5";
    include "error_backend.vcl";
    return (deliver);
}
