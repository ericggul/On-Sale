//
//  ContentView.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 5/18/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @Namespace var animation
    
    @Binding var products: [Product]
    @Environment(\.scenePhase) private var scenePhase
    @State private var expand: Bool = false
    @State private var isActive: Bool = false
    @State private var scrolled: Bool = false
    @State var search = ""
    @State private var newProduct = Product(name: "", initialPrice: "", discountPrice: "", unitQuanity: "", unitMeasure: Measure.g, origin: "", nowPlaying: false, volume: 1.0, adjustable: 0.5, speed: 3, pitch: 3)
        
    var filteredProduct: [Product]{products.filter{
        product in product.nowPlaying
        }
    }
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    
    let saveAction: () -> Void
  
    var body: some View {
        ZStack{
            ScrollView{
                VStack(spacing: 18){
                    HStack(spacing: 15){
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.primary)
                        
                        TextField("Search", text: $search)
                    }
                    .padding(.vertical)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(15)
                    
                    LazyVGrid(columns: columns,spacing: 30){
                        
                        NavigationLink(destination: InputMain(product: $newProduct, isActive: $isActive)
                            .onAppear{
                                products.append(newProduct)},
                            isActive: $isActive){
                            Main()
                        }
                            .isDetailLink(false)
                        
                        

                        ForEach(products){product in
                            NavigationLink(
                                destination: ProductPlayer(
                                    product: binding(for: product), fromMain: .constant(true), isActive: $isActive), isActive: $isActive
                                        ){
                                ProductCard(product: product)
                                    }.isDetailLink(false)
                        }
                    }
                    .padding(.bottom, 70)
                }.padding(10)
            }

//                Main(products: $products, isActive: $isActive)
            
            VStack{
                ForEach(filteredProduct){product in
                    MiniPlayer(animation: animation, expand: $expand, product: binding(for: product), isActive: $isActive)
                }
            }

            
        }
        .navigationTitle("홈")
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .gesture(DragGesture().onChanged(onchanged(value:)))
    }
    
    
    
    func onchanged(value: DragGesture.Value){
        if value.translation.height > 0 {
            print("scrolled")
            scrolled = true
        } else {
            print("Top")
            scrolled = false
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
        NavigationView{
            ContentView(products: .constant(Product.initial), saveAction: {})
                .navigationBarHidden(true)
        }
    }
}
