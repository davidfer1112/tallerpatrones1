import Foundation

struct Cita: Identifiable, Codable {
    var id: UUID
    var cedula: String
    var nombres: String
    var apellidos: String
    var edad: Int
    var fecha: Date
    var hora: String
    var barberia: Barberia
    
    init(cedula: String, nombres: String, apellidos: String, edad: Int, fecha: Date, hora: String, barberia: Barberia) {
        self.id = UUID()
        self.cedula = cedula
        self.nombres = nombres
        self.apellidos = apellidos
        self.edad = edad
        self.fecha = fecha
        self.hora = hora
        self.barberia = barberia
    }
}

struct Barberia: Identifiable, Codable {
    var id: UUID
    var nombre: String
    var direccion: String
    
    init(nombre: String, direccion: String) {
        self.id = UUID()
        self.nombre = nombre
        self.direccion = direccion
    }
}
