package mx.edu.ulsaoaxaca.aventon

import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured
import grails.converters.JSON

@Secured(Rol.BENEFICIARIO)
@Transactional(readOnly = false)
class RutaController {

    def springSecurityService

    static allowedMethods = [
        index: "GET",
        seleccionarParada: "GET",
        buscarParadas: "GET",
        crearParada: "POST",
        agregarParadaRuta: "POST",
        quitarParadaRuta: "POST",
        guardarRuta: "POST"
    ]

    def index() {
        def usuario = springSecurityService.currentUser

        if (!usuario.chofer.ruta) {
            usuario.chofer.ruta = new Ruta()
            usuario.chofer.save()

            redirect action: "index", controller: "ruta"
            return
        }

        [
            ruta: usuario.chofer.ruta
        ]
    }

    def seleccionarParada(Integer id) {
        println "Seleccionar parada"
        println id
        println id.class
        println params
        println ""
        println ""

        def parada = Parada.get(id)

        response.status = 200
        render parada as JSON
    }

    def buscarParadas(String q) {
        println "Buscar parada"
        println q
        println q.class
        println params
        println ""
        println ""

        q = "%" + q + "%"

        def paradas = Parada.where {
            calle =~ q ||
            colonia =~ q ||
            descripcion =~ q
        }.list()

        println paradas
        println Parada.list()

        response.status = 200
        render paradas as JSON
    }

    def crearParada(Parada parada) {
        println "Crear parada"
        println parada
        println parada.errors
        println params
        println ""
        println ""

        if (parada.save()) {
            println "Guardado!"
            println ""
            println ""
            response.status = 200
        } else {
            response.status = 204
        }

        render parada as JSON
        return
    }

    def agregarParadaRuta(Parada parada, Ruta ruta) {
        println "Agregar parada"
        println parada
        println ruta
        println params
        println ""
        println ""

        println params.i
        println params.i?.class
        println ""
        println ""

        ruta.removeFromParadas(parada)

        def posicion = (params.i ?: ruta.paradas.size()).toInteger()

        ruta.paradas.add(posicion, parada)
        if (ruta.save()) {
            println "Guardado!"
            println ""
            println ""
            response.status = 200
        } else {
            response.status = 204
        }

        render ruta.paradas as JSON
        return
    }

    def quitarParadaRuta(Parada parada, Ruta ruta) {
        println "Quitar parada"
        println parada
        println ruta
        println params
        println ""
        println ""

        ruta.removeFromParadas(parada)
        if (ruta.save()) {
            println "Guardado!"
            println ""
            println ""
            response.status = 200
        } else {
            response.status = 204
        }

        render ruta.paradas as JSON
        return
    }

    def guardarRuta(Ruta ruta) {
        println "Guardar ruta"
        println ruta
        println params
        println ruta.validate()
        println ruta.errors
        println ""
        println ""

        if (ruta.save()) {
            println "Guardado!"
            println ""
            println ""
            response.status = 200
        } else {
            response.status = 204
        }

        render ruta as JSON
        return
    }
}
