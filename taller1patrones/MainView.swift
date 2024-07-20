import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Agendamiento de Citas")
                    .font(.largeTitle)
                    .padding()

                NavigationLink(destination: ContentView()) {
                    Text("Agendar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()

                NavigationLink(destination: BuscarCitaView()) {
                    Text("Buscar")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
}
