<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <meta charset="utf-8">
        <title>Buscar un avent&oacute;n</title>
    </head>
    <body>

        <br />

        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="/">Inicio</a></li>
            <li class="breadcrumb-item" aria-current="page">
                <g:link class="text-left" action="index" controller="aventones"class="">Aventones</g:link>
            </li>
            <li class="breadcrumb-item active" aria-current="page">Buscar</li>
          </ol>
        </nav>

        <div class="row">
            <div class="col-md">
                <h4>Busca un avent&oacute;n por donde quieres subir</h4>
            </div>

            <div class="col-md">
                <g:form action="buscar" controller="aventones" method="GET">
                <div class="input-group">
                    <input type="text" name="q" class="form-control" placeholder="Calle, colonia, lugar, referencia, etc." value="${params.q}">
                    <div class="input-group-append">
                        <button class="btn btn-outline-secondary" type="submit"><span class="oi oi-search"></span> Buscar</button>
                    </div>
                </div>
                </g:form>
            </div>
        </div>

        <br />

        <table class="table" id="aventonesBuscados">
            <thead class="thead-dark">
                <tr class="text-center">
                    <th scope="col">Chofer</th>
                    <th scope="col">M&aacute;x. pasajeros</th>
                    <th scope="col">Fecha y hora de salida</th>
                    <th scope="col">Acciones</th>
                </tr>
            </thead>

            <tbody class="text-center">
                <g:each in="${aventones}">
                    <tr>
                        <td><g:link class="text-left" action="perfil" controller="usuarios" id="${it.chofer.usuario.id}" class="">${it.chofer.usuario.persona.nombres}, ${it.chofer.usuario.username}</g:link></td>
                        <td>${it.limite}</td>
                        <td>${it.fecha.format('dd/MM/yyyy') + ' a las ' + it.hora}</td>
                        <td>
                            <div class="btn-group">
                                <g:link action="ver" controller="aventones" id="${it.id}" class="btn btn-outline-secondary btn-sm">
                                    Ver detalle
                                </g:link>
                                <button class="btn btn-outline-success btn-sm"
                                    data-toggle="modal"
                                    data-target="#modalParadas${it.id}">
                                    Ver paradas
                                </button>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <g:each in="${aventones}" var="av">
            <div class="modal fade" id="modalParadas${av.id}" tabindex="-1" role="dialog" aria-labelledby="Crear" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Paradas</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p><strong>${av.chofer.ruta.nombre}</strong></p>
                            <small class="text-muted">${av.chofer.ruta.descripcion}</small>
                            <br />
                            <br />

                            <div class="list-group">
                                <g:each in="${av.chofer.ruta.paradas}">
                                    <button class="list-group-item list-group-item-action"
                                        onclick="
                                            document.getElementById('parada${av.id}').value = ${it.id};
                                            document.getElementById('btn${av.id}').removeAttribute('disabled');
                                            activarBoton(this);
                                        ">
                                        <strong>${it.calle}</strong>,
                                        Col. ${it.colonia}
                                        <small>
                                            (${it.descripcion})
                                        </small>
                                    </button>
                                </g:each>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            <g:form action="solicitar">
                                <input type="hidden" name="aventon.id" value="${av.id}">
                                <input type="hidden" name="parada.id" value="" id="parada${av.id}">
                                <input type="hidden" name="q" value="${params.q}">
                                <button type="submit" class="btn btn-primary" disabled id="btn${av.id}">
                                    Solicitar
                                </button>
                            </g:form>
                        </div>
                    </div>
                </div>
            </div>
        </g:each>

        <script type="text/javascript">
            var btnActivo = null;

            function activarBoton(btn) {
                if (btnActivo) {
                    btnActivo.classList.toggle("active", false);
                }

                btnActivo = btn;
                btnActivo.classList.toggle("active", true);
            }
        </script>
    </body>
</html>
