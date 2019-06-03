package mx.edu.ulsaoaxaca.aventon

class Aventon {
    static belongsTo = [chofer: Chofer]

    String estado
    Integer limite
    String hora
    Date fecha

    static hasMany = [solicitudes: Solicitud]

    Double obtenerPuntuacionAventon() {
        if (
            (new Date()).format("dd/MM/yyyy") <=
            fecha.format("dd/MM/yyyy")
        ) {
            return null
        }

        def total = 0
        def contador = 0

        for (solicitud in solicitudes) {
            if (solicitud.estado == "Aceptada" && solicitud.puntuacionParaChofer) {
                total += solicitud.puntuacionParaChofer
                contador++
            }
        }

        if (contador > 0) {
            return total / contador
        }

        return null
    }

    static constraints = {
        limite min: 1, max: 10
        hora min: "05:30", max: "21:30"
        fecha min: new Date(), validator: { val, obj ->
            return val[Calendar.DAY_OF_WEEK] != Calendar.SUNDAY
        }
    }
}
