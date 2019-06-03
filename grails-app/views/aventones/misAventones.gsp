<!DOCTYPE html>

<%@ page import="java.text.DecimalFormat" %>
<g:set var="df" value="${new DecimalFormat("#.0")}" />
<g:set var="fechaHoy" value="${(new Date()).format('dd/MM/yyyy')}" />

<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Mis aventones</title>
    </head>

    <body>
        <br />

        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item">
                    <a href="/">Inicio</a>
                </li>
                <li class="breadcrumb-item">
                    <g:link controller="aventones">
                        Aventones
                    </g:link>
                </li>
                <li class="breadcrumb-item active" aria-current="page">
                    Mis aventones
                </li>
            </ol>
        </nav>

        <g:if test="${flash.message}">
            <div class="alert alert-${flash.messageType} alert-dismissable">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <h4><i class="icon fa fa-${flash.icon}"></i>${flash.title}</h4>
                ${flash.message}
            </div>
        </g:if>

        <div class="row">
            <div class="col-md">
                <button type="button" class="btn btn-outline-secondary active btn-block btn-lg"
                    onclick="
                        $('#divDados').collapse('show');
                        $('#divPedidos').collapse('hide');
                        botonActivo.classList.toggle('active', false);
                        botonActivo = this;
                        this.classList.toggle('active', true);
                    " id="btnDados">
                    <span class="oi oi-location text-success rounded p-2 bg-white"></span>&nbsp;
                    Aventones que yo he dado
                </button>
            </div>

            <div class="col-md">
                <button type="button" class="btn btn-outline-secondary btn-block btn-lg"
                    onclick="
                        $('#divDados').collapse('hide');
                        $('#divPedidos').collapse('show');
                        botonActivo.classList.toggle('active', false);
                        botonActivo = this;
                        this.classList.toggle('active', true);
                    " id="btnPedidos">
                    <span class="oi oi-question-mark text-primary rounded py-2 px-2 bg-white"></span>&nbsp;
                    Aventones que he pedido
                </button>
            </div>
        </div>

        <br />


        <div id="divDados" class="collapse show">
            <table class="table" id="aventonesDados">
                <thead class="thead-dark">
                    <tr class="text-center">
                        <th scope="col">M&aacute;x. pasajeros</th>
                        <th scope="col">Fecha y hora de salida</th>
                        <th>Te calificaron</th>
                        <th scope="col">Acciones</th>
                    </tr>
                </thead>

                <tbody class="text-center">
                    <g:each in="${aventonesDados}">
                        <tr>
                            <td>${it.limite}</td>
                            <td>${it.fecha.format('dd/MM/yyyy') + ' a las ' + it.hora}</td>
                            <td>
                                <g:set var="califAventon" value="${it.obtenerPuntuacionAventon()}" />
                                <g:if test="${califAventon}">
                                    <span class="oi oi-star rounded bg-secondary p-1" style="color:yellow"></span>
                                    ${df.format(califAventon)}<small class="text-muted">/5</small>
                                </g:if>
                                <g:else>
                                    <span class="oi oi-star rounded bg-secondary p-1"></span> Sin definir
                                </g:else>
                            </td>
                            <td>
                                <g:link action="ver" controller="aventones" id="${it.id}" class="btn btn-outline-secondary btn-sm">
                                    Ver detalle
                                </g:link>
                                <g:link action="verSolicitudes" id="${it.id}" class="btn btn-outline-success btn-sm">
                                    Ver solicitudes
                                </g:link>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>

        <div id="divPedidos" class="collapse">
            <table class="table" id="aventonesPedidos">
                <thead class="thead-dark">
                    <tr class="text-center">
                        <th scope="col">Estado</th>
                        <th scope="col">Parada</th>
                        <th>Fecha y hora</th>
                        <th>Chofer</th>
                        <th scope="col">Te calificaron</th>
                        <th>Acciones</th>
                    </tr>
                </thead>

                <tbody>
                    <g:each in="${aventonesPedidos}">
                        <tr class="text-center">
                            <td class="${
                                it.estado == 'Aceptada' ?
                                    'text-success' :
                                it.estado == 'Rechazada' ?
                                    'text-danger' : 'text-warning'
                            }">${it.estado}</td>
                            <td><strong>${it.parada.calle}</strong></td>
                            <td>${it.aventon.fecha.format('dd/MM/yyyy') + ' a las ' + it.aventon.hora}</td>
                            <td><g:link class="text-left" action="perfil" controller="usuarios" id="${it.aventon.chofer.usuario.id}" class="">${it.aventon.chofer.usuario.persona.nombres}</g:link></td>
                            <td>
                                <g:if test="${it.puntuacionParaPasajero}">
                                    <span class="oi oi-star rounded bg-secondary p-1" style="color:yellow"></span>
                                    ${it.puntuacionParaPasajero}<small class="text-muted">/5</small>
                                </g:if>
                                <g:else>
                                    <span class="oi oi-star rounded bg-secondary p-1"></span> Sin definir
                                </g:else>
                            </td>
                            <td>
                                <g:link action="ver" controller="aventones" id="${it.aventon.id}" class="btn btn-outline-secondary btn-sm">
                                    Ver avent&oacute;n
                                </g:link>
                                <g:if test="${it.aventon.fecha.format('dd/MM/yyyy') < fechaHoy}">
                                    <g:set var="pp" value="${it.puntuacionParaChofer}" />
                                    <div class="btn-group">
                                        <span id="star1${it.id}"
                                            class="oi oi-star rounded bg-secondary p-1"
                                            ${ pp && pp >= 1 ? 'style=color:yellow activaOriginal=1' : ''}
                                            onmouseover="iluminarEstrellas(1, ${it.id})"
                                            onmouseout="reestablecerEstrellas(${it.id})"
                                            onclick="evaluarSolicitud(1, ${it.id})"></span>
                                        <span id="star2${it.id}"
                                            class="oi oi-star rounded bg-secondary p-1"
                                            ${ pp && pp >= 2 ? 'style=color:yellow activaOriginal=1' : ''}
                                            onmouseover="iluminarEstrellas(2, ${it.id})"
                                            onmouseout="reestablecerEstrellas(${it.id})"
                                            onclick="evaluarSolicitud(2, ${it.id})"></span>
                                        <span id="star3${it.id}"
                                            class="oi oi-star rounded bg-secondary p-1"
                                            ${ pp && pp >= 3 ? 'style=color:yellow activaOriginal=1' : ''}
                                            onmouseover="iluminarEstrellas(3, ${it.id})"
                                            onmouseout="reestablecerEstrellas(${it.id})"
                                            onclick="evaluarSolicitud(3, ${it.id})"></span>
                                        <span id="star4${it.id}"
                                            class="oi oi-star rounded bg-secondary p-1"
                                            ${ pp && pp >= 4 ? 'style=color:yellow activaOriginal=1' : ''}
                                            onmouseover="iluminarEstrellas(4, ${it.id})"
                                            onmouseout="reestablecerEstrellas(${it.id})"
                                            onclick="evaluarSolicitud(4, ${it.id})"></span>
                                        <span id="star5${it.id}"
                                            class="oi oi-star rounded bg-secondary p-1"
                                            ${ pp && pp >= 5 ? 'style=color:yellow activaOriginal=1' : ''}
                                            onmouseover="iluminarEstrellas(5, ${it.id})"
                                            onmouseout="reestablecerEstrellas(${it.id})"
                                            onclick="evaluarSolicitud(5, ${it.id})"></span>
                                    </div>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </tbody>
            </table>
        </div>

        <script type="text/javascript">
            var botonActivo = document.getElementById("btnDados");


            function iluminarEstrellas(cantidad, grupo) {
                var arr = [
                    document.getElementById("star1" + grupo),
                    document.getElementById("star2" + grupo),
                    document.getElementById("star3" + grupo),
                    document.getElementById("star4" + grupo),
                    document.getElementById("star5" + grupo)
                ];

                for (var i = 0; i < arr.length; i++) {
                    arr[i].style.color = i < cantidad ? "yellow" : "black";
                }
            }

            function reestablecerEstrellas(grupo) {
                var arr = [
                    document.getElementById("star1" + grupo),
                    document.getElementById("star2" + grupo),
                    document.getElementById("star3" + grupo),
                    document.getElementById("star4" + grupo),
                    document.getElementById("star5" + grupo)
                ];

                arr.forEach(function(obj){
                    var attr = obj.getAttribute("activaOriginal");
                    obj.style.color = attr == null || attr == "" ? "black" : "yellow";
                });
            }

            function evaluarSolicitud(calificacion, solicitud) {
                $.post(
                    '${createLink(action:'calificarSolicitud', controller: 'aventones')}',
                    {
                        'solicitud.id': solicitud,
                        'valor': calificacion
                    }, function (data, status) {
                        console.log("Calificar solicitud");
                        console.log(data);
                        console.log(status);
                        console.log();
                        console.log();

                        switch (status) {
                            case 'success':
                                console.log("miau");
                                location.reload();
                                break;
                            default:
                                console.log("Algo salió mal");
                        }
                    }
                );
            }
        </script>
    </body>
</html>
