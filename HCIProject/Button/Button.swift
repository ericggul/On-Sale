//
//  Button.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 6/11/21.
//

import SwiftUI

struct Button: View {
    var body: some View {
        HStack(alignment: .bottom, content: {
            Text("다음")
                .foregroundColor(.white)
                .font(.title2)
                .bold()
        })
        .frame(width: UIScreen.main.bounds.width)
        .padding(.vertical)
        .padding(.horizontal)
        .background(
            Color(red: 21/255, green: 53/255, blue: 30/255)
        )
        .ignoresSafeArea()
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        Button()
    }
}
