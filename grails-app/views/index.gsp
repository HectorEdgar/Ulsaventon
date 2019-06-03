<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Bienvenido</title>
</head>
<body>

    <br />

    <div class="row">
        <sec:ifAnyGranted roles="ROLE_BENEFICIARIO">
            <div class="col-md">
                <h4>Acceso r&aacute;pido</h4>
                <hr />

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <g:link controller="aventones" action="misAventones" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-location text-success" style="font-size:4em"></span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Mis aventones</strong>
                        </g:link>
                    </div>

                    <div class="col-md-6 mb-3">
                        <g:link controller="usuarios" action="perfil" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-person text-info" style="font-size:4em"></span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Mi perfil</strong>
                        </g:link>
                    </div>

                    <div class="col-md-6 mb-3">
                        <g:link controller="vehiculo" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-key p-2 rounded ml-2"
                                style="font-size:3em; color:goldenrod;">
                            </span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Mi veh&iacute;culo</strong>
                        </g:link>
                    </div>

                    <div class="col-md-6 mb-3">
                        <g:link controller="ruta" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-map-marker p-2 rounded ml-2"
                                style="font-size:3.2em; color:rgb(230, 50, 0);">
                            </span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Mi ruta</strong>
                        </g:link>
                    </div>
                </div>
            </div>

            <div class="col-md">
                <h4 class="text-center">Los mejores <strong>choferes</strong></h4>
                <hr />
            </div>

            <div class="col-md">
                <h4 class="text-center">Los mejores <strong>pasajeros</strong></h4>
                <hr />
            </div>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR">
            <div class="col-md-4 mx-auto">
                <h4>Acceso r&aacute;pido</h4>
                <hr />

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <g:link controller="usuarios" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-people text-info" style="font-size:4em"></span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Usuarios</strong>
                        </g:link>
                    </div>

                    <div class="col-md-6 mb-3">
                        <g:link controller="usuarios" action="guardar" class="btn btn-light btn-block">
                            <br />
                            <br />
                            <span class="oi oi-person text-success" style="font-size:4em"></span>
                            <br />
                            <br />
                            <strong style="font-size:1em">Crear usuario</strong>
                        </g:link>
                    </div>
                </div>
            </div>
        </sec:ifAnyGranted>
        <sec:ifNotLoggedIn>
            <div class="col-md-8 mx-auto">
                <h1>Bienvenido</h1>
                <hr />

                <div class="row text-justify">
                    <div class="col-md">
                        <h4>¿Qu&eacute; es <strong>ULSA</strong>vent&oacute;n?</h4>
                        <br />

                        <p>
                            Es una plataforma desarrollada para la Universidad La Salle
                            Oaxaca, con el fin de que, administrativos, docentes y alumnos,
                            puedan compartir sus rutas de ida o regreso a la universidad.
                        </p>

                        <p>
                            Colaborar en este aspecto act&uacute;a en pro de los valores
                            LaSallistas, pero no es el &uacute;nico beneficio. Otro de los
                            objetivos principales planteados por este proyecto es
                            apoyar la reducci&oacute;n de gases contaminantes del medio ambiente.
                        </p>

                        <p>
                            Entre menos veh&iacute;culos haya circulando en la calle, las
                            emisiones ir&aacute;n declinando poco a poco; es por eso que
                            este proyecto forma parte de una iniciativa de desarrollo
                            sustentable.
                        </p>

                    </div>

                    <div class="col-md">
                        <h4>¿Quieres formar parte?</h4>
                        <br />

                        <p>
                            Puedes unirte a esta plataforma si haces tu solicitud
                            al encargado de tu escuela (si eres alumno o docente),
                            o a tu superior, que tenga contacto con un administrador
                            de <strong>ULSA</strong>vent&oacute;n.
                        </p>

                        <p>
                            Descarga el formato, requis&iacute;talo debidamente y entregalo
                            a quien corresponda. <a href="#">Descarga</a>.
                        </p>

                        <hr />

                        <h4 class="text-center"><span class="oi oi-fork"></span> Repositorio de GitHub</h4>

                        <p class="text-justify">
                            Esto s&oacute;lo est&aacute; disponible en la
                            versi&oacute;n dee pruebas.

                            <a href="https://github.com/Andelous/_2018_05_27Ulsaventon">
                                Ver repositorio.
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </sec:ifNotLoggedIn>
    </div>



</body>
</html>
