
import Foundation

enum sentenceType: String, CaseIterable, Hashable, Identifiable, Codable{
    case i = "informative"
    case p = "promotional"
    var id: String { self.rawValue }
}

struct Script: Hashable, Identifiable, Codable {
    
    let id: UUID
    var sentence: String
    var type : sentenceType
    var isSelected: Bool

    init(id: UUID = UUID(), sentence: String, type: sentenceType, isSelected: Bool) {
        self.id = id
        self.sentence = sentence
        self.type = type
        self.isSelected = isSelected
    }
}



func generateSentence(product: Product) -> [Script]{
    return(
        [Script(sentence: "\(product.name) 사세요.", type: sentenceType.i, isSelected: true),
         Script(sentence: "\(product.origin)에서온 \(product.name) 맛있습니다.", type: sentenceType.i, isSelected: true),
         Script(sentence: "오늘 \(product.name) 과즙이 풍부합니다. 맛있어요.", type: sentenceType.i, isSelected: true),
         
         Script(sentence: "\(product.name) \(product.unitQuanity)\(product.unitMeasure)에 \(product.discountPrice)원입니다.", type: sentenceType.p, isSelected: true),
         Script(sentence: "\(product.name) \(String(describing: product.initialPrice))원에서 \(product.discountPrice)원 세일입니다.", type: sentenceType.p, isSelected: true),
         Script(sentence: "자아아아.", type: sentenceType.p, isSelected: true)
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
