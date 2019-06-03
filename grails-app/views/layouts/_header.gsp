<nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">

        <a href="/" class="navbar-brand">
            <asset:image src="favicon.png" style="background-color: white; width:35px;" class="img-thumbnail" />
            <strong>ULSA</strong>vent&oacute;n
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#nav-principal" aria-controls="nav-principal" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="nav-principal">
            <ul class="navbar-nav mr-auto">

                <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR">

                    <li class="nav-item rounded dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#"
                            id="menuUsuarios" data-toggle="dropdown"
                            aria-haspopup="true" aria-expanded="false">

                            <span class="oi oi-people text-white"></span> &nbsp;Usuarios

                        </a>
                        <div class="dropdown-menu" aria-labelledby="menuUsuarios">
                            <g:link action="index" controller="usuarios" class="dropdown-item">Listado</g:link>
                            <g:link action="guardar" controller="usuarios" class="dropdown-item">Nuevo</g:link>
                        </div>
                    </li>

                </sec:ifAnyGranted>


                <sec:ifAnyGranted roles="ROLE_BENEFICIARIO">

                    <li class="nav-item rounded">
                        <g:link class="nav-link text-white" controller="aventones">
                            <span class="oi oi-location" style="color:yellow;">
                            </span> &nbsp;Aventones
                        </g:link>
                    </li>

                </sec:ifAnyGranted>


            </ul>


            <form class="form-inline my-2 my-md-0">
                <sec:ifLoggedIn>
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <button class="btn btn-light btn-sm dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Bienvenido, <strong>${usuarioLog.persona.nombres}</strong></button>
                            <div class="dropdown-menu w-100">
                                <a class="dropdown-item text-center disabled" href="#"><strong>${rolLog}</strong></a>
                                <a class="dropdown-item text-center disabled bg-dark text-light" href="#">${usuarioLog.username}</a>
                                <div role="separator" class="dropdown-divider"></div>
                                <sec:ifAnyGranted roles="ROLE_BENEFICIARIO">
                                    <g:link class="dropdown-item" controller="vehiculo">
                                        Mi veh&iacute;culo
                                        <span class="oi oi-key float-right" style="color:darkblue"></span>
                                    </g:link>
                                    <g:link class="dropdown-item" controller="ruta">
                                        Configurar ruta
                                        <span class="oi oi-map-marker float-right" style="color:darkblue"></span>
                                    </g:link>
                                </sec:ifAnyGranted>
                                <g:link class="dropdown-item" action="perfil" controller="usuarios">
                                    Mi perfil
                                    <span class="oi oi-person float-right" style="color:darkblue"></span>
                                </g:link>
                            </div>
                        </div>

                        <a href="/logoff" class="btn btn-sm btn-danger">Cerrar sesi&oacute;n <span class="oi oi-account-logout"></span></a>
                    </div>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <g:link class="btn btn-primary btn-sm" action="auth" controller="login">
                        Iniciar sesi&oacute;n <span class="oi oi-account-login"></span>
                    </g:link>
                </sec:ifNotLoggedIn>
            </form>
        </div>
    </div>
</nav>
