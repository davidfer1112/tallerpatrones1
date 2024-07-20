import SwiftUI

struct BuscarCitaView: View {
    @State private var fecha: Date = Date()
    @State private var citas: [Cita] = []
    
    var body: some View {
        VStack {
            Text("Buscar Cita")
                .font(.largeTitle)
                .padding()
            
            DatePicker("Citas por:", selection: $fecha, displayedComponents: .date)
                .padding()
            
            Button(action: buscarCitas) {
                Text("Buscar")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            List(citas) { cita in
                VStack(alignment: .leading) {
                    Text("Cédula: \(cita.cedula)")
                    Text("Nombres: \(cita.nombres) \(cita.apellidos)")
                    Text("Hora: \(cita.hora)")
                }
            }
        }
        .padding()
    }
    
    func buscarCitas() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let folderName = formatter.string(from: fecha)
        
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentDirectory = urls.first else {
            print("No se pudo encontrar el directorio de documentos")
            return
        }
        
        let folderURL = documentDirectory.appendingPathComponent("semestre_8/Patrones/citas").appendingPathComponent(folderName)
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: folderURL.path)
            citas = files.compactMap { file in
                let fileURL = folderURL.appendingPathComponent(file)
                guard let data = try? Data(contentsOf: fileURL) else { return nil }
                return try? JSONDecoder().decode(Cita.self, from: data)
            }
        } catch {
            print("Error al buscar citas: \(error.localizedDescription)")
        }
    }
}

#Preview {
    BuscarCitaView()
}
