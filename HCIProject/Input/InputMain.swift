//
//  InputMain.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI

struct InputMain: View {
    @Binding var product: Product
    @State private var datatoinherit: Product.Data = Product.Data()
    @State private var thisProduct: Product = Product.initial[0]
    @State private var updated = false
    @Binding var isActive: Bool
    
    var body: some View {
            VStack{
                InputTabs(productData: $datatoinherit)
                

                NavigationLink(destination:
                                SentenceList(product: $product
                                             , isActive: $isActive)
                                .onAppear{product.update(from: datatoinherit)}, isActive: $updated
                ){
                        HStack(alignment: .bottom, content: {
                            Text("다음")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        })
                        .frame(width: UIScreen.main.bounds.width)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color(red: 21/255, green: 53/255, blue: 30/255))
                        .ignoresSafeArea()
                        .onTapGesture {
                            product.update(from: datatoinherit)
                            updated = true
                        }
                }
            }
            .navigationTitle("품목 정보 수정")
            .onAppear{
                datatoinherit = product.hmmm
            }
        }
}



struct InputMain_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            InputMain(product: .constant(Product.initial[0]),isActive: .constant(false))
        }
    }
}
