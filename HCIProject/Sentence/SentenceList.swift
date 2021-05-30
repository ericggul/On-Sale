//
//  SentenceList.swift
//  MusicClone
//
//  Created by Jeong Yoon Choi on 5/17/21.
//

import SwiftUI

struct SentenceList: View {
    @Binding var product: Product
    @State private var scripts: [Script] = []
    
    private var selectedScripts: [Script]{scripts.filter{
        script in script.isSelected
    }
    }
    
    var body: some View {
            VStack{
                List{
                    Section(header:
                                Text("상품관련 문구")
                                .font(.headline)){
                        ForEach(scripts.filter{script in
                            script.type == sentenceType.i
                        }){script in
                            SentenceEditRow(script: binding(for: script))
                        }
//                        .onMove(perform: move)
                    }
                    
                    Section(header: Text("가격관련 문구")
                                .font(.headline)){
                        ForEach(scripts.filter{script in
                            script.type == sentenceType.p
                        }){script in
                            SentenceEditRow(script: binding(for: script))
                        }
//                        .onMove(perform: move)
                    }
                    HStack{
                        Image(systemName: "plus")
                        Text("문장 추가하기")
                    }
                }
                .listStyle(GroupedListStyle())
                
                Text("\(selectedScripts.count)개 문장 선택됨")
                //To Fix: How to go back to main using navigation?
                NavigationLink(
                    destination:
                        ContentView(products: .constant(Product.initial), saveAction: {})
                        .onAppear{product.sentences = scripts}){
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
                }
            }
        .navigationTitle("문장 수정")
        .listRowInsets(EdgeInsets())
        .onAppear{
            scripts = generateSentence(product: product)
        }
    }

    private func binding(for script: Script) -> Binding<Script> {
        guard let scriptIndex = scripts.firstIndex(where: { $0.id == script.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $scripts[scriptIndex]
    }
    
}

struct SentenceList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SentenceList(product: .constant(Product.initial[0]))
        }
    }
}
