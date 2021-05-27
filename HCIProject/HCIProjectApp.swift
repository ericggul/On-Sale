import SwiftUI

@main
struct HCIProjectApp: App {
    
    @ObservedObject private var data = ProductData()
    @State private var products = Product.initial
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(products: $data.products){
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
