set beresp.http.Content-Type = "text/html; charset=utf-8";
set beresp.http.Retry-After = "5";
synthetic( {"
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>"} + beresp.status + " " + beresp.reason + {"</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Backend Error page">
        <meta name="author" content="Pascal A.">
        <meta name="generator" content="vim">
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8" >
        <!-- Le styles -->
        <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
        <link href="http://maxcdn.bootstrapcdn.com/bootswatch/3.3.5/simplex/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
            }
        </style>
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container">
            <div class="page-header">
                <h1 class="pagination-centered">Error "} + beresp.status + " " + beresp.reason + {"</h1>
            </div>
            <div class="alert alert-error pagination-centered">
                <i class="icon-warning-sign"></i>
                We're very sorry, but the page could not be loaded properly.
                <i class="icon-warning-sign"></i>
            </div>
            <blockquote>This should be fixed very soon, and we apologize for any inconvenience.</blockquote>
        </div>
        <footer class="container pagination-centered">
        </footer>
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    </body>
</html>
"} );
