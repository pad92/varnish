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
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootswatch/3.3.7/simplex/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
                text-align: center;
            }
            img {
                max-width: 100%;
                height: auto;
            }
        </style>
        <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
        <script src="//html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->
    </head>
    <body>
        <div class="container">
            <div class="jumbotron">
                <div class="body-content">
                    <div class="row">
                        <div class="col">
                            <h2>We couldn't find what you're looking for</h2>
                            <p class="lead">Error "} + beresp.status + " " + beresp.reason + {"</p>
                            <p>This should be fixed very soon, and we apologize for any inconvenience.</p>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>
</html>
"} );
