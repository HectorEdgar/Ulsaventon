<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Aventones</title>
    </head>
<body>
    <br />
    <h1 class="text-center">¿Qu&eacute; deseas hacer?</h1>
    <hr />

    <g:if test="${params.errorCrear}">
        <div class="alert alert-warning">
            <strong>¡Ups!</strong>
            recuerda que primero debes configurar tu veh&iacute;culo y tu ruta
            <i>(pst... haz clic en tu nombre para configurarlos)</i>.
        </div>
    </g:if>

    <g:if test="${params.errorAcceso}">
        <div class="alert alert-danger">
            <strong>Lo sentimos</strong>,
            no puedes acceder a contenido que no es tuyo.
        </div>
    </g:if>

    <div class="row">

        <div class="col-md mb-3">
            <g:link controller="aventones" action="buscar" class="btn btn-light btn-block">
                <br />
                <br />
                <span class="oi oi-magnifying-glass text-warning" style="font-size:4em"></span>
                <br />
                <br />
                <strong style="font-size:1em">Busco un avent&oacute;n</strong>
            </g:link>
        </div>

        <div class="col-md mb-3">
            <g:link controller="aventones" action="crear" class="btn btn-light btn-block">
                <br />
                <br />
                <span class="oi oi-plus text-primary" style="font-size:4em"></span>
                <br />
                <br />
                <strong style="font-size:1em">Quiero dar un avent&oacute;n</strong>
            </g:link>
        </div>

        <div class="col-md mb-3">
            <g:link controller="aventones" action="misAventones" class="btn btn-light btn-block">
                <br />
                <br />
                <span class="oi oi-location text-success" style="font-size:4em"></span>
                <br />
                <br />
                <strong style="font-size:1em">Ver mis aventones</strong>
            </g:link>
        </div>
    </div>
</body>
</html>
