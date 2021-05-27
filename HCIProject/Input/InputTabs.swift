import SwiftUI

struct InputTabs: View {
    
    @Binding var productData: Product.Data
    
    var body: some View {
        List{
            VStack{
                HStack{
                    Text("품목").font(.title2).bold()
                        .frame(width: 70, alignment: .leading)
                    TextField("사과", text: $productData.name).font(.title).padding(7)
                }
                Divider()
                
                //Origin
                HStack{
                    Text("원산지").font(.title2).bold()
                        .frame(width: 70, alignment: .leading)
                    TextField("나주",
                              text: $productData.origin)
                        .keyboardType(.numberPad)
                        .font(.title).padding(7)
                }
                Divider()
                
 
                
                
                    HStack{
                        Text("정가").font(.title2).bold()
                            .frame(width: 70, alignment: .leading)
                        TextField("30000", text:$productData.initialPrice)
                            .keyboardType(.numberPad)
                            .font(.title).padding(7)
                        Spacer()
                        Text("원").font(.title2).foregroundColor(.secondary)
                    }
                
                
           
                Divider()
                //DiscountedPrice
                HStack{
                    Text("할인가").font(.title2).bold()
                        .frame(width: 70, alignment: .leading)
                    TextField("24000",
                              text: $productData.discountPrice)
                        .keyboardType(.numberPad)
                        .font(.title).padding(7)
                    Spacer()
                    Text("원").font(.title2).foregroundColor(.secondary)
                }
                Divider()
                //Quantity
                HStack{
                    Text("단위").font(.title2).bold()
                        .frame(width: 70, alignment: .leading)
                    TextField("150",
                              text: $productData.unitQuanity)
                        .keyboardType(.numberPad)
                        .font(.title).padding(7)
                    
                    Picker("단위", selection: $productData.unitMeasure){
                        ForEach(Measure.allCases){product in
                            Text(product.rawValue).tag(product)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
            }

        }
    }
}

struct InputTabs_Previews: PreviewProvider {
    static var previews: some View {
        InputTabs(productData: .constant(Product.initial[0].hmmm))
    }
}
