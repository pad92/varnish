if (req.http.host == "wordpress.domain.ltd") {
    set req.http.Cookie = regsuball(req.http.Cookie, "(^|;\s*)(_[_a-z]+|has_js)=[^;]*", "");
    set req.http.Cookie = regsub(req.http.Cookie, "^;\s*", "");
    if (req.url ~ "^/wp-content/uploads/" && (req.http.referer && (req.http.referer !~ "^http://wordpress.domain.ltd/") )) {
        return (synth(403, "No hotlinking please"));
    }
    if (!(req.http.cookie ~ "wordpress_logged_in")) {
        unset req.http.cookie;
    }
    if (!req.http.cookie) {
        unset req.http.cookie;
    }
}
