<!DOCTYPE html>

<g:set var="fechaManana" value="${new Date() + 1}" />

<html>
    <head>
        <meta charset="utf-8">
        <meta name="layout" content="main">
        <title>Crear avent&oacute;n</title>
    </head>

    <body>
    	<div class="row">
            <div class="col-md-6 mx-auto">
                <br />
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/">Inicio</a></li>
                        <li class="breadcrumb-item" aria-current="page">
                           <g:link class="text-left" action="index" controller="aventones"class="">Aventones</g:link>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">Crear</li>
                    </ol>
                </nav>

                <h2 class="text-center">Crear Avent&oacute;n</h2>
                <hr />

                <g:if test="${request.method != 'GET' && aventon}">
                    <div class="alert alert-danger">
                        <h6 class="alert-header"><strong>Error al crear avent&oacute;n</strong></h6>
                        <ul>
                            <li>Debes crear el avent&oacute;n con al menos un d&iacute;a de anticipaci&oacute;n, y debe ser de lunes a s&aacute;bado.</li>
                            <li>Los pasajeros no pueden ser m&aacute;s de diez.</li>
                            <li>La hora debe ser entre 05:30 y 21:30 horas.</li>
                        </ul>
                    </div>
                </g:if>

                <g:form method="POST" action="crear" controller="aventones">
                    <div class="form-group">
                        <label>Fecha <code>(MES/DIA/A&Ntilde;O)</code></label>
                        <input
                            type="hidden"
                            name="fecha"
                            id="fechaHidden" />

                        <input type="date"
                            id="fechaInput"
                            value="${
                                (aventon?.fecha ?: fechaManana).
                                format('yyyy-MM-dd')
                            }"
                            min="${fechaManana.format('yyyy-MM-dd')}"
                            class="form-control form-control-sm"
                            required />
                    </div>

                    <div class="form-group">
                        <label>Hora de salida:</label>
                        <input type="time" class="form-control form-control-sm"
                            name="hora" value="${aventon?.hora}"
                            min="05:30" max="21:30">
                    </div>


                    <div class="form-group">
                        <label>Limite de pasajeros:</label>
                        <input type="number" class="form-control form-control-sm"
                            name="limite" max="10" min="1"
                            value="${aventon?.limite ?: 3}">
                    </div>

                    <div class="w-50 mx-auto">
                        <button type="submit" class="btn btn-primary btn-block">Agregar</button>
                    </div>
                </g:form>
            </div>
        </div>

        <script type="text/javascript">
            var fechaInput = document.getElementById("fechaInput");
            var fechaHidden = document.getElementById("fechaHidden");

            function crearDates() {
                fechaHidden.value =
                    fechaInput.value + " 00:00:00.0";
            }

            fechaInput.addEventListener("change", crearDates);
            crearDates();
        </script>
    </body>
</html>
