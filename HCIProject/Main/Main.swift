import SwiftUI

struct Main: View {
    @Binding var products: [Product]
    @State private var nowPlaying: Int = 0
    @State var search = ""
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        
        ScrollView{
            VStack(spacing: 18){
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.primary)
                    
                    TextField("Search", text: $search)
                }
                .padding(.vertical)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.06))
                .cornerRadius(15)
                
                LazyVGrid(columns: columns,spacing: 30){
                    
                    //Add New Item Slot
                    
                    NavigationLink(destination: InputMain(product: .constant(Product.initial[0]))) {
                        VStack(alignment: .leading, spacing: 5){
                            
                            Text("지금")
                                .foregroundColor(.secondary)
                            Image(systemName: "plus")
                                .font(.system(size: 100))
                                .foregroundColor(.secondary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(
                                        style: StrokeStyle(
                                            lineWidth: 2,
                                            dash : [5])
                                        )
                                        .frame(width: (UIScreen.main.bounds.width - 70)/2, height: 180, alignment: .center)
                                )
                                .frame(width: (UIScreen.main.bounds.width - 70)/2, height: 180, alignment: .center)
                            Text("새로 만들기")
                                .font(.title)
                                .foregroundColor(.primary)
                            Text("")
                                .foregroundColor(.secondary)
                    }}
                    
                    ForEach(products){product in
                        NavigationLink(
                            destination: InputMain(
                                product: binding(for: product))){
                                ProductCard(product: product)
                            }
                    }
                }
                .padding(.bottom, 70)
            }.padding(10)
        }
    }
    
    private func binding(for product: Product) -> Binding<Product> {
        guard let productIndex = products.firstIndex(where: { $0.id == product.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $products[productIndex]
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(products: .constant(Product.initial))
    }
}

