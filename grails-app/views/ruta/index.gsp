<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Mi ruta</title>
    </head>
    <body>
        <div class="row mt-3">
            <div class="col-md-9 mx-auto">

                <h3 class="text-center"><span class="oi oi-map-marker"></span> Configurar mi ruta</h3>
                <div class="text-center">
                    <small class="text-muted">S&oacute;lo agrega las caracter&iacute;sticas de tu ruta si vas a dar aventones</small>
                </div>
                <hr />

                <div class="row">
                    <div class="col-md">
                        <div class="row">
                            <div class="col-md">
                                <h4>Paradas</h4>
                            </div>
                            <div class="col-md">
                                <div class="d-flex justify-content-between">


                                    <div class="btn-group">
                                        <button class="btn btn-light btn-sm"
                                            data-toggle="tooltip" data-placement="bottom"
                                            title="Subir" onclick="cambiarPosicion(-1)">
                                            <span class="oi oi-chevron-top"></span>
                                        </button>
                                        <button class="btn btn-light btn-sm"
                                            data-toggle="tooltip" data-placement="bottom"
                                            title="Bajar" onclick="cambiarPosicion(1)">
                                            <span class="oi oi-chevron-bottom"></span>
                                        </button>
                                    </div>

                                    <div class="btn-group">
                                        <button class="btn btn-danger btn-sm"
                                            data-toggle="tooltip" data-placement="bottom"
                                            title="Quitar" onclick="quitarParadaRuta()">
                                            <span class="oi oi-minus"></span>
                                        </button>
                                    </div>

                                    <div class="btn-group">
                                        <button class="btn btn-info btn-sm"
                                            data-toggle="modal"
                                            data-target="#modalBuscar">
                                            <span class="oi oi-magnifying-glass"></span>
                                        </button>
                                        <button class="btn btn-primary btn-sm"
                                            data-toggle="modal"
                                            data-target="#modalCrear">
                                            <span class="oi oi-plus"></span>
                                        </button>
                                    </div>


                                </div>
                            </div>
                        </div>

                        <hr />

                        <div class="list-group">
                            <g:set var="i" value="${0}" />
                            <g:each in="${ruta.paradas}">
                                <button class="list-group-item list-group-item-action"
                                    idParada="${it.id}" onclick="activarBoton(this)" pos="${i++}">
                                    <strong>${it.calle}</strong>,
                                    Col. ${it.colonia}
                                    <small>
                                        (${it.descripcion})
                                    </small>
                                </button>
                            </g:each>

                            <g:if test="${ruta.paradas.size() == 0}">
                                <button class="list-group-item list-group-item-action" disabled>
                                    Sin paradas
                                </button>
                            </g:if>
                            <br />
                            <br />
                        </div>
                    </div>

                    <div class="col-md">
                        <h4 class="text-center">Informaci&oacute;n de la ruta</h4>
                        <p class="text-center">
                            <small class="text-muted">Esto ayudar&aacute; a que otros
                                usuarios puedan encontrar tus aventones f&aacute;cilmente
                            </small>
                        </p>

                        <hr />

                        <div id="divAlertas">

                        </div>

                        <div class="form-group">
                            <label>Nombre</label>
                            <input type="text" id="txtNombre" value="${ruta.nombre}" class="form-control form-control-sm">
                        </div>

                        <div class="form-group">
                            <label>Descripci&oacute;n</label>
                            <textarea class="form-control" id="txtDescripcion" rows="3">${ruta.descripcion}</textarea>
                        </div>

                        <div class="w-50 mx-auto">
                            <button type="button" class="btn btn-sm btn-primary btn-block"
                                onclick="guardarRuta()">
                                Guardar
                            </button>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md">

                    </div>

                    <div class="col-md">

                    </div>
                </div>
            </div>
        </div>




        <div class="modal fade" id="modalCrear" tabindex="-1" role="dialog" aria-labelledby="Crear" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Crea una nueva parada</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="divAlertasCrear">

                        </div>
                        <div class="form-group">
                            <label>Lugar o calle(s)</label>
                            <input type="text" id="txtCalles" class="form-control form-control-sm">
                        </div>

                        <div class="form-group">
                            <label>Colonia</label>
                            <input type="text" id="txtColonia" class="form-control form-control-sm">
                        </div>

                        <div class="form-group">
                            <label>Referencias</label>
                            <input type="text" id="txtReferencias" class="form-control form-control-sm">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary"
                            onclick="crearAgregarParada();">
                            Crear y agregar
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalBuscar" tabindex="-1" role="dialog" aria-labelledby="Crear" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Busca una parada existente</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="divAlertasCrear">

                        </div>
                        <div class="form-group">
                            <label>Calle, colonia o referencia</label>
                            <div class="input-group mb-3">
                                <input type="text" id="txtQ" class="form-control form-control-sm" placeholder="Lo que gustes">
                                <div class="input-group-append">
                                    <button class="btn btn-sm btn-outline-secondary" type="button" onclick="buscarParadas()">
                                        <span class="oi oi-magnifying-glass"></span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="list-group" id="divCoincidencias">

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-primary"
                            onclick="agregarParada();">
                            Agregar seleccionada
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            var alertaSuccess = `
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <strong>&Eacute;xito</strong>. Se guard&oacute; tu ruta.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>`;

            var alertaNoContent = `
                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                    <strong>Error</strong>. Recuerda no usar caracteres especiales o dejar campos vac&iacute;os.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>`;

            var plantillaParadaBuscar =
                `<button class="list-group-item list-group-item-action"
                    idParada="@id" onclick="activarBotonBusqueda(this)" pos="@i">
                    <strong>@calle</strong>,
                    Col. @colonia
                    <small>
                        (@descripcion)
                    </small>
                </button>`;


            // Ruta
            var txtNombre = document.getElementById("txtNombre");
            var txtDescripcion = document.getElementById("txtDescripcion");

            // Parada
            var txtCalles = document.getElementById("txtCalles");
            var txtColonia = document.getElementById("txtColonia");
            var txtReferencias = document.getElementById("txtReferencias");

            // Alertas
            var divAlertas = document.getElementById("divAlertas");
            var divAlertasCrear = document.getElementById("divAlertasCrear");

            function guardarRuta() {
                $.post(
                    '${createLink(action:'guardarRuta', controller: 'ruta')}',
                    {id: ${ruta.id}, nombre: txtNombre.value, descripcion: txtDescripcion.value},
                    function (data, status) {
                        console.log(data);
                        console.log(status);

                        switch (status) {
                            case 'success':
                                divAlertas.innerHTML = alertaSuccess;
                                break;
                            default:
                                divAlertas.innerHTML = alertaNoContent;
                        }
                    }
                );
            }

            function crearAgregarParada() {
                $.post(
                    '${createLink(action:'crearParada', controller: 'ruta')}',
                    {calle: txtCalles.value, colonia: txtColonia.value, descripcion: txtReferencias.value},
                    function (data, status) {
                        console.log("Crear parada");
                        console.log(data);
                        console.log(status);
                        console.log();
                        console.log();


                        switch (status) {
                            case 'success':
                                $.post(
                                    '${createLink(action:'agregarParadaRuta', controller: 'ruta')}',
                                    {'parada.id': data.id, 'ruta.id': ${ruta.id}},
                                    function (data, status) {
                                        console.log("Agregar parada");
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
                                                divAlertasCrear.innerHTML = alertaNoContent;
                                        }
                                    }
                                );
                                break;
                            default:
                                divAlertasCrear.innerHTML = alertaNoContent;
                        }
                    }
                );
            }


            var botonActivo = null;
            function activarBoton(btn) {
                console.log(btn)
                if (botonActivo) {
                    botonActivo.classList.toggle("active");
                }
                btn.classList.toggle("active");
                botonActivo = btn;
            }

            function quitarParadaRuta() {
                if (botonActivo) {
                    $.post(
                        '${createLink(action:'quitarParadaRuta', controller: 'ruta')}',
                        {'parada.id': botonActivo.getAttribute("idParada"), 'ruta.id': ${ruta.id}},
                        function (data, status) {
                            console.log("Quitar parada");
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
            }

            function cambiarPosicion(val) {
                if (botonActivo) {
                    $.post(
                        '${createLink(action:'agregarParadaRuta', controller: 'ruta')}',
                        {
                            'parada.id': botonActivo.getAttribute("idParada"),
                            'ruta.id': ${ruta.id},
                            'i': parseInt(botonActivo.getAttribute("pos")) + val
                        }, function (data, status) {
                            console.log("Cambiar posición parada");
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
            }

            var txtQ = document.getElementById("txtQ");
            var divCoincidencias = document.getElementById("divCoincidencias");
            function buscarParadas() {
                $.get(
                    '${createLink(action: 'buscarParadas', controller: 'ruta')}',
                    {
                        'q': txtQ.value
                    }, function (data, status) {
                        console.log("Buscar paradas");
                        console.log(data);
                        console.log(status);
                        console.log();
                        console.log();

                        switch (status) {
                            case 'success':
                                console.log("miau");
                                divCoincidencias.innerHTML = "";

                                var i = 0;

                                data.forEach(function(obj) {
                                    divCoincidencias.innerHTML +=
                                        plantillaParadaBuscar.
                                            replace("@id", obj.id).
                                            replace("@i", i++).
                                            replace("@calle", obj.calle).
                                            replace("@colonia", obj.colonia).
                                            replace("@descripcion", obj.descripcion);
                                });
                                break;
                            default:
                                console.log("Algo salió mal");
                        }
                    }
                );
            }

            var botonActivoBusqueda = null;
            function activarBotonBusqueda(btn) {
                console.log(btn)
                if (botonActivoBusqueda) {
                    botonActivoBusqueda.classList.toggle("active");
                }
                btn.classList.toggle("active");
                botonActivoBusqueda = btn;
            }

            function agregarParada() {
                if (botonActivoBusqueda) {
                    $.post(
                        '${createLink(action:'agregarParadaRuta', controller: 'ruta')}',
                        {
                            'parada.id': botonActivoBusqueda.getAttribute("idParada"),
                            'ruta.id': ${ruta.id}
                        }, function (data, status) {
                            console.log("Agregar parada de búsqueda");
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
            }
        </script>
    </body>
</html>
