package mx.edu.ulsaoaxaca.aventon

class Pasajero {
    static belongsTo = [usuario: Usuario]
    static hasMany = [solicitudes: Solicitud]

    Double obtenerPuntuacion() {
        def total = 0
        def contador = 0

        for (solicitud in solicitudes) {
            if (solicitud.estado == "Aceptada" && solicitud.puntuacionParaPasajero) {
                total += solicitud.puntuacionParaPasajero
                contador++
            }
        }

        if (contador > 0) {
            return total / contador
        }

        return null
    }

    static constraints = {
    }
}
