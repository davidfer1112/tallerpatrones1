import SwiftUI

struct ContentView: View {
    @State private var cedula: String = ""
    @State private var nombres: String = ""
    @State private var apellidos: String = ""
    @State private var edad: String = ""
    @State private var fecha: Date = Date()
    @State private var hora: Date = Date()
    @State private var barberia = Barberia(nombre: "Barbería Central", direccion: "Calle 123")
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Agendar Cita")
                .font(.largeTitle)
                .padding()
            
            TextField("Cédula", text: $cedula)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Nombres", text: $nombres)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Apellidos", text: $apellidos)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Edad", text: $edad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                .padding()
            
            DatePicker("Hora", selection: $hora, displayedComponents: .hourAndMinute)
                .padding()
            
            Button(action: agendarCita) {
                Text("Registrar")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Agendamiento de Citas"), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                // Limpiar campos del formulario
                cedula = ""
                nombres = ""
                apellidos = ""
                edad = ""
                fecha = Date()
                hora = Date()
            }))
        }
    }
    
    func agendarCita() {
        guard let edadInt = Int(edad) else {
            alertMessage = "Edad no válida"
            showingAlert = true
            return
        }
        
        // Formatear la hora seleccionada
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let horaString = dateFormatter.string(from: hora)
        
        let nuevaCita = Cita(cedula: cedula, nombres: nombres, apellidos: apellidos, edad: edadInt, fecha: fecha, hora: horaString, barberia: barberia)
        
        do {
            try guardarCita(cita: nuevaCita)
            alertMessage = "Cita agendada con éxito"
        } catch {
            alertMessage = "Error al guardar la cita: \(error.localizedDescription)"
        }
        showingAlert = true
    }
    
    func guardarCita(cita: Cita) throws {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let folderName = formatter.string(from: cita.fecha)
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else {
            throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No se pudo encontrar el directorio de documentos"])
        }
        
        let folderURL = documentDirectory.appendingPathComponent("semestre_8/Patrones/citas").appendingPathComponent(folderName)
        
        if !fileManager.fileExists(atPath: folderURL.path) {
            try fileManager.createDirectory(at: folderURL, withIntermediateDirectories: true, attributes: nil)
        }
        
        let fileURL = folderURL.appendingPathComponent("\(cita.cedula).json")
        let data = try JSONEncoder().encode(cita)
        try data.write(to: fileURL)
        print("Cita guardada exitosamente en \(fileURL.path)")
    }
}

#Preview {
    ContentView()
}
