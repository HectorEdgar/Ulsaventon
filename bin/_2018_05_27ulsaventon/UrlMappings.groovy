package _2018_05_27ulsaventon

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "/acerca"(view:"/acerca")
        "/politicas"(view:"/politicas")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
