package mx.edu.ulsaoaxaca.aventon

import grails.validation.ValidationException
import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON


@Secured(Rol.BENEFICIARIO)
@Transactional(readOnly = false)
class AventonesController {
    def springSecurityService

    // Preguntar qué desea hacer...
    def index() {

    }

    // Ver todos los aventones que he dado y he pedido
    def misAventones() {
        def u = springSecurityService.loadCurrentUser()

        def aventonesDados = Aventon.where {
            chofer.usuario.id == u.id
        }.list()

        def aventonesPedidos = Solicitud.where {
            pasajero.usuario.id == u.id
        }.list()

        [
            aventonesDados: aventonesDados,
            aventonesPedidos: aventonesPedidos
        ]
    }

    // Para solicitar un aventón
    def buscar(String q) {
        q = (q ?: '').toLowerCase()
        def u = springSecurityService.loadCurrentUser()
        def fechaHoy = new Date()

        def aventonesPosibles = Aventon.where {
            fecha > fechaHoy
        }.list()

        def aventones = []

        for (aventon in aventonesPosibles) {
            def ruta = aventon.chofer.ruta
            def paradas = ruta.paradas

            def solicitudesUsuario = []
            def solicitudesAceptadas = []

            for (solicitud in aventon.solicitudes) {
                if (solicitud.estado == "Aceptada") {
                    solicitudesAceptadas.add(solicitud)
                }

                if (solicitud.pasajero.usuario.id == u.id) {
                    solicitudesUsuario.add(solicitud)
                }
            }

            if (
                aventon.chofer.usuario.id == u.id ||
                solicitudesAceptadas.size() == aventon.limite ||
                solicitudesUsuario.size() > 0
            ) {
                continue
            }

            if (
                ruta.nombre.toLowerCase().contains(q) ||
                ruta.descripcion.toLowerCase().contains(q)
            ) {
                aventones.add(aventon)
                continue
            }

            for (parada in paradas) {
                if (
                    parada.calle.toLowerCase().contains(q) ||
                    parada.colonia.toLowerCase().contains(q) ||
                    parada.descripcion.toLowerCase().contains(q)
                ) {
                    aventones.add(aventon)
                    break
                }
            }
        }

        [
            aventones: aventones
        ]
    }

    def ver(Aventon aventon) {
        def solicitudesAceptadas = []

        for (solicitud in aventon.solicitudes) {
            if (solicitud.estado == "Aceptada") {
                solicitudesAceptadas.add(solicitud)
            }
        }

        [
            aventon: aventon,
            solicitudesAceptadas: solicitudesAceptadas
        ]
    }

    def solicitar(Aventon aventon, Parada parada, String q) {
        def u = springSecurityService.currentUser

        if (
            !aventon ||
            aventon.chofer.usuario.id == u.id
        ) {
            redirect(action: "index", params: [errorAcceso: 1])
            return
        }

        def solicitud = new Solicitud()
        solicitud.pasajero = u.pasajero
        solicitud.aventon = aventon
        solicitud.parada = parada

        solicitud.estado = "En revisión"
        solicitud.fechaRealizacion = new Date()

        if (solicitud.save()) {
            redirect action:"misAventones", params: [solicitudCorrecta: 1]
            return
        }

        redirect action: "buscar", params: [q: q]
    }

    // Para crear un aventón
    def crear() {
        def u = springSecurityService.currentUser

        if (
            !u.chofer.vehiculo ||
            !u.chofer.ruta ||
            u.chofer.ruta.paradas.size() == 0
        ) {
            redirect controller: "aventones", params: [errorCrear: 1]
        }

        def aventon = new Aventon()

        if (request.method == "POST") {
            aventon.properties = params
            aventon.estado = "En espera"
            aventon.chofer = u.chofer

            def intento = aventon.save()

            println intento

            if (intento) {
                flash.icon = "check"
                flash.messageType = "success"
                flash.title = "¡Aventón registrado!"
                flash.message = "El aventón ha sido registrado correctamente."

                redirect(action: "misAventones")
                return
            }
        }

        [
            aventon: aventon
        ]
    }

    // Para ver y aprobar una solicitud
    def verSolicitudes(Aventon aventon) {
        def u = springSecurityService.loadCurrentUser()

        if (
            !aventon ||
            aventon.chofer.usuario.id != u.id
        ) {
            redirect(action: "index", params: [errorAcceso: 1])
            return
        }

        def solicitudes = aventon.solicitudes.sort { a, b ->
            a.estado <=> b.estado
        }

        [
            aventon: aventon,
            solicitudes: solicitudes
        ]
    }

    def cambiarEstadoSolicitud(Solicitud solicitud, String estado) {
        def u = springSecurityService.loadCurrentUser()

        if (
            !solicitud ||
            solicitud.aventon.chofer.usuario.id != u.id
        ) {
            redirect(action: "index", params: [errorAcceso: 1])
            return
        }

        println "Cambiar estado"
        println ""
        println params
        println estado
        println solicitud
        println ""

        solicitud.estado = estado
        def intento = solicitud.save()

        println intento
        println ""
        println ""
        println ""

        redirect action: "verSolicitudes", params: [estado: estado, intento: intento, 'aventon.id': solicitud.aventon.id]
    }

    def calificarSolicitud(Solicitud solicitud, Integer valor) {
        def u = springSecurityService.loadCurrentUser()

        if (solicitud.pasajero.usuario.id == u.id) {
            solicitud.puntuacionParaChofer = valor
        } else if (solicitud.aventon.chofer.usuario.id == u.id) {
            solicitud.puntuacionParaPasajero = valor
        } else {
            response.status = 204
        }

        if (response.status != 204 && solicitud.save()) {
            println "Guardado!"
            println ""
            println ""
            response.status = 200
        } else {
            response.status = 204
        }

        def mapa = [solicitud: solicitud, valor: valor]

        render mapa as JSON
    }
}
