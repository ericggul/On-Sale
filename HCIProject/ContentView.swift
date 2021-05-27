//
//  ContentView.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 5/18/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @Binding var products: [Product]
    @Environment(\.scenePhase) private var scenePhase
    @State private var expand: Bool = false
        
    var filteredProduct: [Product]{products.filter{
        product in product.nowPlaying
    }
    }
    
    let saveAction: () -> Void
  
    var body: some View {
            ZStack{
                Main(products: $products)
                    .navigationTitle(expand ? "":"홈")
                ForEach(filteredProduct){product in
                    TabBar(expand: $expand, product: binding(for: product))
                }
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
        }
    }
    

    
    private func binding(for product: Product) -> Binding<Product> {
        guard let productIndex = products.firstIndex(where: { $0.id == product.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $products[productIndex]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(products: .constant(Product.initial), saveAction: {})
    }
}
