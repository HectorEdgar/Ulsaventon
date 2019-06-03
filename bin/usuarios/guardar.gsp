<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Guardar usuario</title>
    </head>
    <body>
        <div class="row mt-3">
            <div class="col-md-6 mx-auto">

                <h3 class="text-center">
                    <span class="oi oi-people"></span>
                    Guardar usuario
                </h3>

                <g:if test="${usuario?.id}">
                    <small class="text-muted d-block text-center">
                        ${usuario.persona} - <strong>${usuario?.username}</strong>
                    </small>
                </g:if>

                <hr />


                <g:if test="${request.method != 'GET' && (usuario || usuario.persona)}">
                    <div class="alert alert-danger">
                        <h6 class="alert-header"><strong>Error al crear usuario</strong></h6>
                        No utilice caracteres especiales, ni deje campos vac&iacute;os
                        <g:if test="${contrasena}">
                            <ul class="mb-0">
                                <li>Contrase&ntilde;a incorrecta.</li>
                            </ul>
                        </g:if>
                    </div>
                </g:if>


                <g:form action="guardar"
                    controller="usuarios"
                    method="POST">

                    <g:if test="${usuario?.id}">
                        <input type="hidden"
                            name="usuario.id"
                            value="${usuario?.id}">
                    </g:if>

                    <div class="row">
                        <div class="form-group col-md">
                            <label>Usuario o matr&iacute;cula</label>
                            <input type="text"
                                name="usuario.username"
                                value="${usuario?.username}"
                                class="form-control form-control-sm"
                                placeholder="Nombre de usuario o matr&iacute;cula"
                                required>
                        </div>

                        <div class="form-group col-md">
                            <label>Rol</label>
                            <select class="form-control form-control-sm"
                                name="rol.id">
                                <g:each in="${roles}">
                                    <option
                                        value="${it.id}"
                                        ${it.id == rol?.id ? 'selected' : ''}>
                                        ${it}
                                    </option>
                                </g:each>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-group col-md">
                            <label>Contrase&ntilde;a</label>
                            <input type="password"
                                name="usuario.password"
                                class="form-control form-control-sm"
                                placeholder="Contrase&ntilde;a"
                                required>
                        </div>

                        <div class="form-group col-md">
                            <label>Confirma contrase&ntilde;a</label>
                            <input type="password"
                                name="usuario.passwordC"
                                class="form-control form-control-sm"
                                placeholder="Repite la contrase&ntilde;a"
                                required>
                        </div>
                    </div>

                    <br />

                    <div class="form-group">
                        <label>Nombres</label>
                        <input type="text"
                            name="usuario.persona.nombres"
                            value="${usuario?.persona?.nombres}"
                            class="form-control form-control-sm"
                            placeholder="Nombres personales"
                            required>
                    </div>

                    <div class="row">
                        <div class="form-group col-md">
                            <label>Apellido paterno</label>
                            <input type="text"
                                name="usuario.persona.apellidoPaterno"
                                value="${usuario?.persona?.apellidoPaterno}"
                                class="form-control form-control-sm"
                                placeholder="Apellido paterno"
                                required>
                        </div>

                        <div class="form-group col-md">
                            <label>Apellido materno</label>
                            <input type="text"
                                name="usuario.persona.apellidoMaterno"
                                value="${usuario?.persona?.apellidoMaterno}"
                                class="form-control form-control-sm"
                                placeholder="Apellido materno"
                                required>
                        </div>
                    </div>

                    <br />

                    <div class="text-center">
                        <button type="submit" class="btn w-50 btn-outline-primary">Guardar</button>
                    </div>
                </g:form>

            </div>
        </div>
    </body>
</html>
