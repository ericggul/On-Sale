import SwiftUI

struct Main: View {
    @State private var nowPlaying: Int = 0
    @State var search = ""
    @State private var onLive = false
    
    
    var body: some View {
        
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
    }
    }
    

}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Main()
        }
    }
}

