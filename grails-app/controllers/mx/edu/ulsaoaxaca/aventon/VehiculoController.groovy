package mx.edu.ulsaoaxaca.aventon

import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON

@Secured(Rol.BENEFICIARIO)
@Transactional(readOnly = false)
class VehiculoController {

    def springSecurityService

    def allowedMethods = [
        index: ["GET", "POST"]
    ]

    def index() {
        def u = springSecurityService.currentUser

        def mapa = [
            vehiculo: u.chofer.vehiculo
        ]

        if (request.method == "POST") {
            if (!u.chofer.vehiculo) {
                u.chofer.vehiculo = new Vehiculo()
            }

            u.chofer.vehiculo.properties = params

            if (u.chofer.save()) {
                mapa.vehiculo = u.chofer.vehiculo
                mapa.creado = 1
            }
        }

        mapa
    }
}
