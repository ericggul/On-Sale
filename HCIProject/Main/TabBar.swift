//
//  TabBar.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI

struct TabBar: View {
    @Binding var expand: Bool
    @Namespace var animation
    @Binding var product: Product
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            MiniPlayer(animation: animation, expand: $expand, product: $product)
        })
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(expand: .constant(false), product: .constant(Product.initial[0]))
    }
}
