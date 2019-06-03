<!doctype html>

<sec:ifLoggedIn>
    <%@ page import="mx.edu.ulsaoaxaca.aventon.Usuario" %>

    <g:set var="idUsuario">
        <sec:loggedInUserInfo field="id" />
    </g:set>

    <g:set var="usuarioLog" value="${Usuario.get(idUsuario.trim())}" />
    <g:set var="rolLog" value="${usuarioLog.authorities[0]}" />
</sec:ifLoggedIn>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>
            <g:layoutTitle default="Desconocido"/> - ULSAVent&oacute;n
        </title>

        <asset:link rel="icon" href="favicon.png" type="image/x-ico" />
        <asset:stylesheet src="application.css"/>

        <style media="screen">
            html {
                position: relative;
                min-height: 100%;
            }

            body {
                margin-bottom: 60px; /* Margin bottom by footer height */
            }

            .footer {
                position: absolute;
                bottom: 0;
                width: 100%;
                height: 60px; /* Set the fixed height of the footer here */
                line-height: 60px; /* Vertically center the text there */
                background-color: #f5f5f5;
            }
        </style>

        <g:layoutHead/>
    </head>

    <body>
        <g:render template="/layouts/header" />

        <div class="container">
            <g:layoutBody />
        </div>

        <br />
        <br />

        <g:render template="/layouts/footer" />

        <asset:javascript src="application.js"/>

        <script type="text/javascript">
            $(function () {
                $('[data-toggle="tooltip"]').tooltip()
            });

            $(document).ready(function() {
                $('#aventonesDados').DataTable({
                    "order": [1, 'desc']
                });
                $('#aventonesPedidos').DataTable({
                    "order": [2, 'desc']
                });
                $('#aventonesBuscados').DataTable({
                    "searching": false,
                    "order": [2, 'asc']
                });
            } );
        </script>
    </body>
</html>
