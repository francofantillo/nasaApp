//
//  DetailScreen.swift
//  Workday
//
//  Created by Franco Fantillo on 2022-12-08.
//

import SwiftUI

struct DetailScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var vm: DetailScreenViewModel
    
    var body: some View {
        VStack {
            ScrollView{
                
                Text(vm.title)
                    .font(.system(size: 30))
                    .padding(.bottom, 25)
                
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
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 125))
                .padding([.bottom])
                
                HStack {
                    Text("Date Created:")
                    Text(vm.date)
                    Spacer()
                }
                .padding(.bottom, 4)
                HStack {
                    Text("Description:  " + vm.description )
                        .multilineTextAlignment(.leading)
                        
                    Spacer()
                }
                
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
        }
        .padding(16)
        .background(Color("Primary"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Spacer(minLength: 14)
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
