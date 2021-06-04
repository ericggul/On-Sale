import Foundation

class ProductData: ObservableObject {
    
    
    private static var documentsFolder: URL{
        do{
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch{
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL{
        return documentsFolder.appendingPathComponent("products.data")
    }
    
    
    @Published var products: [Product] = []
    
    //Load Data
    func load() {
        DispatchQueue.global(qos: .background).async{ [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.products = Product.initial
                }
                #endif
                return
            }
            
            
            

            guard let product = try? JSONDecoder().decode([Product].self, from: data) else{
                fatalError("What")
            }
            
            DispatchQueue.main.async{
                self?.products = product
            }
        }
    }
    
    
    //Save Data
    func save() {
        DispatchQueue.global(qos: .background).async{[weak self] in
            
            guard let products = self?.products else {
                fatalError("Self out of Scope")
            }
            
            guard let data = try? JSONEncoder().encode(products) else {
                fatalError("Error Encoding Data")
            }
            
            do {
                let outfile = Self.fileURL
                try data.write(to: outfile)
            } catch {
                fatalError("oops... can't write to file")
            }
        }
        
    }
}

