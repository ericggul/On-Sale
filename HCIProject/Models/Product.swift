import Foundation

enum Measure: String, CaseIterable, Identifiable, Codable{
    case g = "g"
    case qty = "개"
    var id: String { self.rawValue }
}

struct Product: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var initialPrice: String
    var discountPrice: String
    var unitQuanity: String
    var unitMeasure: Measure
    var origin: String
    var sentences: [Script]
    var nowPlaying: Bool
//    var speechVariance: Double = 1.0
//    var speechVolume: Double = 1.0
    
    
    init(id: UUID = UUID(), name: String, initialPrice: String, discountPrice: String, unitQuanity: String, unitMeasure: Measure, origin: String, sentences: [Script] = [], nowPlaying: Bool) {
        self.id = id
        self.name = name
        self.initialPrice = initialPrice
        self.discountPrice = discountPrice
        self.unitQuanity = unitQuanity
        self.unitMeasure = unitMeasure
        self.origin = origin
        self.sentences = sentences
        self.nowPlaying = nowPlaying
//        self.speechVariance = speechVariance
//        self.speechVolume = speechVolume
    }
}


extension Product{
    static var initial: [Product]{
        [
            Product(name: "파인애플", initialPrice: "30000", discountPrice: "24000", unitQuanity: "100", unitMeasure : Measure.g, origin: "캘리포니아",
                    sentences:
                        [Script(sentence: "삼겹살, 항정살, 가브리살, 무한제공.", type: sentenceType.i, isSelected: true),
                         Script(sentence: "삼겹살, 항정살, 가브리살, 제공.", type: sentenceType.p, isSelected: true),
                         Script(sentence: "삼겹살, 항정살, 가브리제공.", type: sentenceType.i, isSelected: true)],
                    nowPlaying: true),
            Product(name: "올림픽", initialPrice: "27000", discountPrice: "20000", unitQuanity: "100", unitMeasure : Measure.qty, origin: "캘리포니아", nowPlaying: false),
            Product(name: "구렛나루", initialPrice: "32000", discountPrice: "24000", unitQuanity: "100", unitMeasure : Measure.qty, origin: "캘리포니아", nowPlaying: false),
            Product(name: "사과", initialPrice: "30000", discountPrice: "24000", unitQuanity: "100", unitMeasure : Measure.g, origin: "캘리포니아", nowPlaying: false)
        ]
    }
}


extension Product {
    
    struct Data {
        var name: String = ""
        var initialPrice: String = ""
        var discountPrice: String = ""
        var unitQuanity: String = "100"
        var unitMeasure: Measure = Measure.g
        var origin: String = "대한민국"
        var sentences: [Script] = []
        var nowPlaying: Bool = false

    }

    var hmmm: Data {
        return Data(name: name, initialPrice: initialPrice, discountPrice: discountPrice, unitQuanity: unitQuanity, unitMeasure: unitMeasure, origin: origin, sentences: sentences, nowPlaying: nowPlaying)
    }

    mutating func update(from data: Data) {
        name = data.name
        initialPrice = data.initialPrice
        discountPrice = data.discountPrice
        unitQuanity = data.unitQuanity
        unitMeasure = data.unitMeasure
        origin = data.origin
        sentences = data.sentences
        nowPlaying = data.nowPlaying
    }
}


