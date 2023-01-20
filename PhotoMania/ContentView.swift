//
//  ContentView.swift
//  PhotoMania
//
//  Created by Matt Lawrence Romanes on 29/09/21.
//

import SwiftUI

class ViewModel: ObservableObject{
    @Published var image: Image?
    
    func fetchNewImage(){
//        URL contains random images
        guard let url = URL(string:
                                "https://random.imagecdn.app/500/500") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, _, _ in
            guard let data = data else{ return }
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else{
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                if let image = viewModel.image{
                    ZStack{
                        image
                            .resizable()
                            .foregroundColor(Color.orange)
                            .frame(width: 200, height: 200)
                            .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2,
                           height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.blue)
                    .cornerRadius(10)
                } else{
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.orange)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("New Image")
                        .bold()
                        .frame(width: 250, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                    
                    
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Photo Mania")
                        .font(.largeTitle.bold())
                        .accessibilityAddTraits(.isHeader)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
