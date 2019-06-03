<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>
            Iniciar sesi&oacute;n - ULSAVent&oacute;n
        </title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
        <asset:stylesheet src="application.css"/>

        <asset:stylesheet src="login.css" />
    </head>

    <body class="text-center">
        <g:form class="form-signin" action="authenticate" controller="login">
            <asset:image src="lasalle.png" style="width:100%;background-color: white;" class="p-3 img-thumbnail" />

            <br />
            <br />

            <h1 class="h3 mb-3 font-weight-normal"><strong>ULSA</strong>vent&oacute;n</h1>

            <label for="inputEmail" class="sr-only">Usuario o matr&iacute;cula</label>
            <input type="text" name="username" class="form-control" placeholder="Usuario o matr&iacute;cula" required autofocus>

            <label for="inputPassword" class="sr-only">Contrase&ntilde;a</label>
            <input type="password" name="password" class="form-control" placeholder="Contrase&ntilde;a" required>

            <button class="btn btn-primary btn-block" type="submit">Entrar</button>

            <p class="mt-5 mb-3 text-muted">&copy; Universidad La Salle Oaxaca, 2018</p>
        </g:form>
    </body>
</html>
