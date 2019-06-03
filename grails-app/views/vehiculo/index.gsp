<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Mi veh&iacute;culo</title>
    </head>
    <body>
        <div class="row mt-3">
            <div class="col-md-9 mx-auto">

                <h3 class="text-center"><span class="oi oi-key"></span> Mi veh&iacute;culo</h3>
                <div class="text-center">
                    <small class="text-muted">S&oacute;lo agrega las caracter&iacute;sticas de tu veh&iacute;culo si vas a dar aventones</small>
                </div>
                <hr />

                <g:if test="${creado}">
                <div class="alert alert-success alert-dismissible fade show">
                    <strong>&Eacute;xito</strong>. Se guard&oacute; el veh&iacute;culo.
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                </g:if>

                <g:form action="index" controller="vehiculo" method="POST">
                    <div class="row">
                        <div class="col-md">
                            <div class="form-group">
                                <label>Placas</label>
                                <input type="text" name="placas" value="${vehiculo?.placas}" class="form-control form-control-sm" required>
                            </div>
                        </div>

                        <div class="col-md">
                            <div class="form-group">
                                <label>Marca y modelo</label>
                                <input type="text" name="modelo" value="${vehiculo?.modelo}" class="form-control form-control-sm" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md">
                            <div class="form-group">
                                <label>Color</label>
                                <input type="text" name="color" value="${vehiculo?.color}" class="form-control form-control-sm" required>
                            </div>
                        </div>

                        <div class="col-md">
                            <div class="form-group">
                                <label>A&ntilde;o</label>
                                <input type="number" min="1900" name="ano" value="${vehiculo?.ano ?: 2005}" class="form-control form-control-sm" required>
                            </div>
                        </div>
                    </div>

                    <div class="w-25 mx-auto">
                        <button type="submit" class="btn btn-primary btn-block">
                            Guardar
                        </button>
                    </div>
                </g:form>
            </div>
        </div>
    </body>
</html>
