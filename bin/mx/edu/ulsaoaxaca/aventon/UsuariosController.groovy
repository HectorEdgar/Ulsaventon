package mx.edu.ulsaoaxaca.aventon

import grails.transaction.Transactional
import grails.plugin.springsecurity.annotation.Secured

@Secured(Rol.ADMINISTRADOR)
@Transactional(readOnly = false)
class UsuariosController {
    def springSecurityService

    static allowedMethods = [
        index: "GET",
        guardar: ["GET", "POST"],
        eliminar: "GET",
        perfil: ["GET", "POST"]
    ]

    def index(Rol rol) {
        def tamanoPagina = 10

        if (!params.pag) {
            params.pag = 1
        }

        if (!params.q) {
            params.q = ""
        }

        def paginas = [offset: tamanoPagina * (params.pag.toInteger() - 1), max: tamanoPagina]

        def q = "%" + params.q + "%"

        def query = null

        if (!rol) {
            query = UsuarioRol.where {
                usuario.persona.nombres =~ q ||
                usuario.username =~ q
            }
        } else if (rol.authority == Rol.ADMINISTRADOR) {
            query = UsuarioRol.where {
                (usuario.persona.nombres =~ q ||
                usuario.username =~ q) &&
                rol.authority == Rol.ADMINISTRADOR
            }
        } else if (rol.authority == Rol.BENEFICIARIO) {
            query = UsuarioRol.where {
                (usuario.persona.nombres =~ q ||
                usuario.username =~ q) &&
                rol.authority == Rol.BENEFICIARIO
            }
        }

        def usuariosLista = query.list(paginas)
        paginas = Math.ceil(query.count() / tamanoPagina)

        [
            usuariosLista: usuariosLista,
            pag: params.pag,
            q: params.q,
            paginas: paginas,
            roles: Rol.list(),
            rol: rol
        ]
    }

    @Transactional
    def guardar(Usuario usuario, Rol rol) {
        if (
            usuario?.id == springSecurityService.loadCurrentUser().id
        ) {
            redirect(action: "index", controller: "usuarios", params: [errorAcceso: 1])
            return
        }

        if (!rol && usuario) {
            rol = usuario.authorities[0]
        }

        println params

        def testPost = request.method == "POST"
        def testPassword = usuario?.password == params?.usuario?.passwordC

        if (testPost && testPassword) {
            if (!usuario.id) {
                usuario.chofer = new Chofer()
                usuario.pasajero = new Pasajero()
            }

            def intento = usuario.save()

            if (intento) {
                UsuarioRol.removeAll intento
                UsuarioRol.create intento, rol, true

                redirect action: "index", controller: "usuarios", params: [guardado: 1]
                return
            }
        }

        return [
            usuario: usuario,
            rol: rol,
            roles: Rol.list(),
            contrasena: testPost && !testPassword
        ]
    }

    def eliminar(Usuario usuario) {
        if (
            !usuario ||
            usuario.id == springSecurityService.loadCurrentUser().id
        ) {
            redirect(action: "index", controller: "usuarios", params: [errorAcceso: 1])
            return
        }

        UsuarioRol.removeAll usuario
        usuario.delete()

        redirect action: "index", controller: "usuarios", params: [eliminado: 1]
        return
    }

    @Secured("IS_AUTHENTICATED_FULLY")
    def perfil(Usuario usuario) {
        if (
            !usuario ||
            usuario.authorities[0].authority == Rol.ADMINISTRADOR
        ) {
            usuario = springSecurityService.currentUser
        }

        [
            usuario: usuario
        ]
    }
}
