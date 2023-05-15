//
//  DetailScreen.swift
//  Workday
//
//  Created by Franco Fantillo 
//

import SwiftUI

struct DetailScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: DetailScreenViewModel
    let config = UIConfig()
    
    var body: some View {
        VStack {
            ScrollView{
                
                Text(vm.title)
                    .font(.system(size: config.titleFontSize))
                    .padding(.bottom, config.titlePadding)
                ZStack {
                    AsyncImage(url: URL(string: vm.imageURL)) { phase in
                        switch phase {
                        case .failure:
                            Image(systemName: "photo")
                                .font(.largeTitle)
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        default: ProgressView()
                        }
                    }
                    .frame(width: config.imageWidth, height: config.imageWidth)
                    .clipShape(RoundedRectangle(cornerRadius: config.imageWidth/2))
                    .padding()
                    
                }
                .background(.gray)
                .cornerRadius(config.cardCornerRadius)
                .padding(.bottom, config.padding)
            
                HStack {
                    Text("Date Created:")
                    Text(vm.date)
                    Spacer()
                }
                .padding(.bottom, config.textPadding)
                HStack {
                    Text("Description:  " + vm.description )
                        .multilineTextAlignment(.leading)
                        
                    Spacer()
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(config.cardCornerRadius)
        }
        .padding(config.padding)
        .background(Color("Primary"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Spacer(minLength: config.padding)
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                }
        })
    }
}

struct DetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DetailScreen.DetailScreenViewModel(title: "Title", imageURL: "https://hws.dev/paul.jpg", description: "A description", date: "October 26, 2022")
        DetailScreen(vm: vm)
    }
}
