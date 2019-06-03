package _2018_05_27ulsaventon

import mx.edu.ulsaoaxaca.aventon.*

class BootStrap {

    def init = { servletContext ->

        // -----------------
        // CÓDIGO ESENCIAL
        // -----------------

        // Roles
        def rolAdministrador = Rol.find { authority == Rol.ADMINISTRADOR }
        def rolBeneficiario = Rol.find { authority == Rol.BENEFICIARIO }

        if (!rolAdministrador) {
            rolAdministrador = new Rol(authority: Rol.ADMINISTRADOR).save()
        }

        if (!rolBeneficiario) {
            rolBeneficiario = new Rol(authority: Rol.BENEFICIARIO).save()
        }

        // Usuarios

        if (!Usuario.find { username == "root" }) {
            def personaAdministrador =
                new Persona(
                    nombres: "José Adrián",
                    apellidoPaterno: "Villanueva",
                    apellidoMaterno: "Ortiz")

            def usuarioAdministrador =
                new Usuario(
                    username: "root",
                    password: "Mexico.2018",
                    persona: personaAdministrador,
                    chofer: new Chofer(),
                    pasajero: new Pasajero()).save()

            println personaAdministrador
            println usuarioAdministrador

            UsuarioRol.create usuarioAdministrador, rolAdministrador
        }







        // -----------------
        // CÓDIGO de pruebas
        // -----------------

        if (!Usuario.find { username == "014230035" }) {
            def personaBeneficiario1 =
                new Persona(
                    nombres: "Ángel Daniel",
                    apellidoPaterno: "Alonso",
                    apellidoMaterno: "Tovar")

            def usuarioBeneficiario1 =
                new Usuario(
                    username: "014230035",
                    password: "123",
                    persona: personaBeneficiario1,
                    chofer: new Chofer(),
                    pasajero: new Pasajero()).save()

            def rutaBeneficiario1 = new Ruta(
                nombre: "Estadio Vasconcelos a La Salle",
                descripcion: "Paso por los siguientes puntos...")

            usuarioBeneficiario1.chofer.ruta = rutaBeneficiario1
            usuarioBeneficiario1.chofer.save()

            def parada1 = new Parada(
                calle: "Estadio de baseball",
                colonia: "Reforma",
                descripcion: "Frente al estadio")

            def parada2 = new Parada(
                calle: "Clínica del ISSSTE",
                colonia: "Cinco Señores",
                descripcion: "Frente a la secundaria técnica 1")

            def parada3 = new Parada(
                calle: "Agencia Toyota",
                colonia: "Centro",
                descripcion: "Frente a Chedraui de Candiani")

            usuarioBeneficiario1.chofer.ruta.addToParadas(parada1)
            usuarioBeneficiario1.chofer.ruta.addToParadas(parada2)
            usuarioBeneficiario1.chofer.ruta.addToParadas(parada3)

            usuarioBeneficiario1.chofer.ruta.save()

            usuarioBeneficiario1.chofer.vehiculo = new Vehiculo(
                placas: "123 AB CDE",
                modelo: "Chevrolet Sonic",
                color: "Plateado",
                ano: 2015
            )
            usuarioBeneficiario1.chofer.save()


            println personaBeneficiario1
            println usuarioBeneficiario1

            UsuarioRol.create usuarioBeneficiario1, rolBeneficiario
        }

        if (!Usuario.find { username == "014230001" }) {
            def personaBeneficiario2 =
                new Persona(
                    nombres: "Lino Alejandro",
                    apellidoPaterno: "Arango",
                    apellidoMaterno: "Cruz")

            def usuarioBeneficiario2 =
                new Usuario(
                    username: "014230001",
                    password: "123",
                    persona: personaBeneficiario2,
                    chofer: new Chofer(),
                    pasajero: new Pasajero()).save()

            println personaBeneficiario2
            println usuarioBeneficiario2

            UsuarioRol.create usuarioBeneficiario2, rolBeneficiario
        }

        if (!Usuario.find { username == "014230027" }) {
            def personaBeneficiario3 =
                new Persona(
                    nombres: "Roberto Javier",
                    apellidoPaterno: "Zúñiga",
                    apellidoMaterno: "Cruz")

            def usuarioBeneficiario3 =
                new Usuario(
                    username: "014230027",
                    password: "123",
                    persona: personaBeneficiario3,
                    chofer: new Chofer(),
                    pasajero: new Pasajero()).save()

            println personaBeneficiario3
            println usuarioBeneficiario3

            UsuarioRol.create usuarioBeneficiario3, rolBeneficiario
        }

    }
    def destroy = {
    }
}
