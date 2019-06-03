package mx.edu.ulsaoaxaca.aventon

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
import grails.compiler.GrailsCompileStatic

@GrailsCompileStatic
@EqualsAndHashCode(includes='authority')
@ToString(includes='authority', includeNames=true, includePackage=false)
class Rol implements Serializable {
    public static final String ADMINISTRADOR = 'ROLE_ADMINISTRADOR'
    public static final String BENEFICIARIO = 'ROLE_BENEFICIARIO'

	private static final long serialVersionUID = 1

	String authority

	static constraints = {
		authority nullable: false, blank: false, unique: true
	}

	static mapping = {
		cache true
	}

    String toString() {
        switch(authority) {
            case ADMINISTRADOR:
                return "Administrador"
            case BENEFICIARIO:
                return "Beneficiario"
            default:
                return "Desconocido"
        }
    }
}
