//
//  ProductCard.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 5/21/21.
//

import SwiftUI

struct ProductCard: View {
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            
            Text("25분전")
                .foregroundColor(.secondary)
            Image(product.name)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (UIScreen.main.bounds.width - 70)/2, height: 180, alignment: .center)
                .cornerRadius(5)
                .clipped()
            Text(product.name)
                .font(.title)
                .foregroundColor(.primary)
            Text("\(product.unitQuanity)\(product.unitMeasure.rawValue) \(product.discountPrice)원")
                .foregroundColor(.secondary)
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var product = Product.initial[0]
    static var previews: some View {
        ProductCard(product: product)
    }
}
