//
//  NextButton.swift
//  HCIProject
//
//  Created by Jeong Yoon Choi on 6/11/21.
//

import SwiftUI

struct NextButton: View {
    
    @Binding var isLast: Bool

    var body: some View {
        HStack(alignment: .bottom, content: {
            Text(isLast ? "완료" : "다음")
                .foregroundColor(.white)
                .font(isLast ? .title : .title2)
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

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(isLast: .constant(false))
    }
}
