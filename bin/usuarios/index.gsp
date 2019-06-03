<!DOCTYPE html>

<%@ page import="mx.edu.ulsaoaxaca.aventon.Rol" %>

<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Usuarios</title>
    </head>
    <body>
        <div class="row mt-3">
            <div class="col-md-9 mx-auto">

                <h3 class="text-center"><span class="oi oi-people"></span> Usuarios</h3>
                <hr />

                <form class="form-inline mb-3">
                    <div class="form-group w-25 pr-1">
                        <select class="form-control w-100" name="rol.id" onchange="submit()">
                            <g:each in="${roles}">
                                <option value="${it.id}" ${rol?.id == it.id ? 'selected' : ''}>
                                    ${it}
                                </option>
                            </g:each>
                        </select>
                    </div>
                    <div class="input-group w-75 pl-1">
                        <input type="text" name="q" class="form-control" placeholder="Nombre de usuario o personal" value="${params.q}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="submit"><span class="oi oi-search"></span> Buscar</button>
                        </div>
                    </div>
                </form>


                <g:if test="${params.guardado}">
                    <div class="alert alert-info">
                        Usuario guardado con &eacute;xito
                    </div>
                </g:if>

                <g:if test="${params.eliminado}">
                    <div class="alert alert-warning">
                        Usuario eliminado con &eacute;xito
                    </div>
                </g:if>

                <g:if test="${params.errorAcceso}">
                    <div class="alert alert-danger">
                        <h5 class="alert-heading">
                            <strong>Error</strong>
                        </h5>
                        No tienes permiso para ver, crear o modificar estos datos.
                    </div>
                </g:if>

                <div class="row">

                    <g:each in="${usuariosLista}">

                        <div class="col-md-6 mx-auto">
                            <div class="card mb-3">
                                <div
                                    class="card-header ${
                                    it.rol.authority == Rol.BENEFICIARIO ?
                                        'bg-info text-white' :
                                        'bg-dark text-white'}">
                                    <strong>${it.rol}</strong> - ${it.usuario.username}
                                </div>
                                <div class="card-body">
                                    <h4 class="card-title mb-0">${it.usuario.persona}</h4>
                                </div>
                                <div class="card-footer btn-group">
                                    <g:link action="guardar" controller="usuarios" params="['usuario.id': it.usuario.id]" class="btn btn-link btn-sm text-dark">
                                        <span class="oi oi-pencil text-primary"></span>
                                        Editar
                                    </g:link>
                                    <a href="#" class="btn btn-link btn-sm text-dark" data-toggle="modal" data-target="#modal${it.usuario.id}">
                                        <span class="oi oi-circle-x text-danger"></span>
                                        Eliminar
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" tabindex="-1" role="dialog" id="modal${it.usuario.id}">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Confirmar eliminaci&oacute;n</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>&iquest;Est&aacute; seguro que desea eliminar al usuario
                                            <strong>&ldquo;${it.usuario.username}&rdquo;, ${it.usuario.persona}</strong>&quest;</p>
                                    </div>
                                    <div class="modal-footer">
                                        <g:link action="eliminar" controller="usuarios" params="[id: it.usuario.id]"
                                            class="btn btn-danger text-white">S&iacute;
                                        </g:link>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </g:each>

                </div>


                <nav>
                    <ul class="pagination justify-content-center">
                        <g:set var="i" value="${1}" />
                        <g:set var="paginas" value="${paginas.toInteger()}" />

                        <g:while test="${i <= paginas}">
                            <li class="page-item ${params.pag.toInteger() == i ? 'active' : ''}">
                                <g:link action="index" controller="${controllerName}"
                                    params="[pag: i, q: params.q, 'rol.id': rol?.id]" class="page-link">
                                    ${i++}
                                </g:link>
                            </li>
                        </g:while>
                    </ul>
                </nav>

            </div>
        </div>
    </body>
</html>
