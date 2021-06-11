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
    @State private var datatoinherit: Product.Data = Product.Data()
    @State private var updated = false
    @Binding var isActive: Bool
    
    @State private var filler = true
    @State private var accentColor = Color(red: 13/255, green: 71/255, blue: 34/255)
    
    private var shownScripts: [Script]{scripts.filter{
        script in script.isShown
    }
    }

    private var selectedScripts: [Script]{shownScripts.filter{
        script in script.isSelected
    }
    }
    
    
    var body: some View {
            VStack{
                
                List{
                    Section(header:
                                HStack{
                                    Text("상품관련 문구")
                                    .font(.headline)
                                    Image(systemName: "questionmark.circle.fill")
                                        .font(.headline)
                                }
                                ){
                        ForEach(shownScripts.filter{script in
                            script.type == sentenceType.i
                        }){script in
                            SentenceEditRow(script: binding(for: script))
                        }
                    }
                    
                    Section(header: HStack{
                        Text("가격관련 문구")
                            .font(.headline)
                        Image(systemName: "questionmark.circle.fill")
                            .font(.headline)
                        
                    }){
                        ForEach(shownScripts.filter{script in
                            script.type == sentenceType.p
                        }){script in
                            SentenceEditRow(script: binding(for: script))
                        }
                    }
                    
                    Section(header:
                            HStack{
                                Text("추임새")
                                .font(.headline)
                                Image(systemName: "questionmark.circle.fill")
                                    .font(.headline)
                            }
                    ){
                        ForEach(shownScripts.filter{script in
                            script.type == sentenceType.f                        }){script in
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
                
                Text("\(selectedScripts.count)/\(shownScripts.count) 종류 선택됨")
                
                NavigationLink(
                    destination:
                        SoundPage(product: $product
                                  , shouldPopToRootView: $isActive)
                        .onAppear{product.sentences = scripts})
                    {
                    NextButton(isLast: .constant(false))
                }
            }
        .navigationTitle("2. 문장 선택 및 수정")
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
            SentenceList(product: .constant(Product.initial[0])
                         ,isActive: .constant(false))
        }
    }
}
