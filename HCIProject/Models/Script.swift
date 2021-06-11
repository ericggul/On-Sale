
import Foundation

enum sentenceType: String, CaseIterable, Hashable, Identifiable, Codable{
    case i = "informative"
    case p = "promotional"
    case f = "filler"
    var id: String { self.rawValue }
}

struct Script: Hashable, Identifiable, Codable {
    
    let id: UUID
    var sentence: String
    var type : sentenceType
    var isSelected: Bool
    var isShown: Bool

    init(id: UUID = UUID(), sentence: String, type: sentenceType, isSelected: Bool, isShown: Bool) {
        self.id = id
        self.sentence = sentence
        self.type = type
        self.isSelected = isSelected
        self.isShown = isShown
    }
}



func generateSentence(product: Product) -> [Script]{
    
    
    return(
        [
         Script(sentence: "\(product.origin)에서온 \(product.name) 맛있습니다.", type: sentenceType.i, isSelected: true, isShown: true),
         Script(sentence: "오늘 \(product.name) 과즙이 풍부합니다. 맛있어요.", type: sentenceType.i, isSelected: true, isShown: true),
         
         Script(sentence: "\(product.name) \(product.unitQuanity)\(product.unitMeasure)에 \(product.discountPrice)원입니다.", type: sentenceType.p, isSelected: true, isShown: true),
         Script(sentence: "\(product.name) \((product.initialPrice))원에서 \(product.discountPrice)원 세일입니다.", type: sentenceType.p, isSelected: true, isShown: true),
            
        Script(sentence: "한번만 드셔보세요.", type: sentenceType.f,isSelected: true, isShown: true),
        Script(sentence: "여기서 더 싸게는 안되는거에요.", type: sentenceType.f,isSelected: true, isShown: true),
        Script(sentence: "하나만 팔고 집에 갑시다!", type: sentenceType.f,isSelected: true, isShown: true),
        Script(sentence: "저는 기계여서 못먹어보는게 한이네요.", type: sentenceType.f,isSelected: true, isShown: true),
        Script(sentence: "이걸 안사면 흑우 아니여?.", type: sentenceType.f,isSelected: true, isShown: true),
            
            
            
        
            
        Script(sentence: "\(product.name) 사세요.", type: sentenceType.i, isSelected: true, isShown: false),
        Script(sentence: "\(product.name) \(product.origin) 세일", type: sentenceType.i, isSelected: true, isShown: false),
            
         Script(sentence: "\(product.origin)에서온 \(product.name) 있습니다. 얼른 사가세요.", type: sentenceType.i, isSelected: true, isShown: false),
         
         Script(sentence: "\(product.name) \(product.unitQuanity)\(product.unitMeasure)에 \(product.discountPrice)원 세일", type: sentenceType.p, isSelected: true, isShown: false),
         Script(sentence: "\(product.name) \(product.discountPrice)원입니다 세일합니다", type: sentenceType.p, isSelected: true, isShown: false),
         Script(sentence: "맛있는 \(product.name) \(product.discountPrice)원이에요", type: sentenceType.p, isSelected: true, isShown: false),
         
        Script(sentence: "둘이 먹다가 하나 죽어도 모르는 이맛", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "집에가서 드세요.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "집가서 잡수세요.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "싸다 싸.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "이걸 이렇게 싸게 해줬는데 안사면 안되지.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "물건 파는게 이렇게 힘든 줄 몰랐어요.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "다 먹고 살자고 하는일 아니겠습니까.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "이거 하나 팔아주면, 누이 좋고, 그 다음이 기억 안나네. 어쨋든.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "이거 먹을려고 다음 생에는 인간으로 태어날려고요.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "후, 저도 한번 먹고 싶네요.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "기계는 불공평합니다. 이 맛있는걸 앞에 두고 하루종일 노동이나 해야된다니.", type: sentenceType.f,isSelected: true, isShown: false),
        Script(sentence: "무야호! 이거 하나 드세요.", type: sentenceType.f,isSelected: true, isShown: false),
            
        ]
    )
}



func advancedGenerateSentence(script: Script) -> [String]{
    return(
        [
            "자, 아주머니 한번 잡수고 가세요."
        ]
    )
}

