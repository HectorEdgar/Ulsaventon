package mx.edu.ulsaoaxaca.aventon

class Ruta {
    String nombre
    String descripcion

    List paradas
    static hasMany = [paradas: Parada]
    static belongsTo = [chofer: Chofer]

    static constraints = {
        nombre nullable: true, size: 1..100, matches: "^[a-zA-Z#1234567890àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$"
        descripcion nullable: true, size: 1..250, matches: "^[a-zA-Z#1234567890àáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.'-]+\$"
    }
}
