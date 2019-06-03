<!DOCTYPE html>

<g:set var="fechaHoy" value="${new Date()}" />

<html>
    <head>
        <meta name="layout" content="main">
        <meta charset="utf-8">
        <title>Solicitudes de tu avent&oacute;n</title>
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
                <li class="breadcrumb-item">
                    <g:link controller="aventones" action="misAventones">
                        Mis aventones
                    </g:link>
                </li>
                <li class="breadcrumb-item active">
                    Ver solicitudes
                </li>
            </ol>
        </nav>

        <br />
        <h3>Aprueba las solicitudes de tu avent&oacute;n</h3>
        <hr />

        <div class="row">
            <g:each in="${solicitudes}">
                    <div class="col-md-6 mx-auto">
                        <div class="card mb-3">
                            <div class="card-header">
                                <g:link action="perfil" controller="usuarios" id="${it.pasajero.usuario.id}">
                                    <strong>${it.pasajero.usuario.username}</strong> - ${it.pasajero.usuario.persona}

                                    <span class="float-right">
                                        <span class="badge badge-pill badge-${
                                            it.estado == 'Aceptada' ?
                                                'success' :
                                            it.estado == 'Rechazada' ?
                                                'danger' : 'warning'
                                        }">${it.estado}</span>
                                    </span>
                                </g:link>
                            </div>
                            <div class="card-body">
                                <h4 class="card-title mb-0">${it.parada.calle}</h4>
                                <p class="mb-0">${it.parada.colonia}, ${it.parada.descripcion}</p>
                            </div>
                            <div class="card-footer">
                                <g:if test="${
                                    it.aventon.fecha.format('dd/MM/yyyy') >
                                    fechaHoy.format('dd/MM/yyyy')
                                }">
                                    <div class="btn-group">
                                        <g:link action="cambiarEstadoSolicitud" controller="aventones" params="[id: it.id, estado: 'Aceptada']" class="btn btn-link btn-sm text-dark">
                                            <span class="oi oi-check text-success"></span>
                                            Aprobar
                                        </g:link>

                                        <g:link action="cambiarEstadoSolicitud" controller="aventones" params="[id: it.id, estado: 'Rechazada']" class="btn btn-link btn-sm text-dark">
                                            <span class="oi oi-circle-x text-danger"></span>
                                            Rechazar
                                        </g:link>
                                    </div>
                                </g:if>
                                <g:else>
                                    <g:if test="${it.estado == 'Aceptada'}">
                                        <g:if test="${
                                            it.aventon.fecha.format('dd/MM/yyyy') <
                                            fechaHoy.format('dd/MM/yyyy')
                                        }">
                                            <g:set var="pp" value="${it.puntuacionParaPasajero}" />
                                            <div class="text-right">
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
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <strong>Mañana podr&aacute;s calificar al pasajero</strong>
                                        </g:else>
                                    </g:if>
                                    <g:else>
                                        <span class="text-muted">Sin acciones</span>
                                    </g:else>
                                </g:else>
                            </div>
                        </div>
                    </div>
            </g:each>
        </div>


        <script type="text/javascript">
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
