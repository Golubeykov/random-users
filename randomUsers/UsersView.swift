//
//  ContentView.swift
//  randomUsers
//
//  Created by Антон Голубейков on 15.05.2022.
//

import SwiftUI

struct UsersView: View {
    @StateObject var userData = UserData()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.users) {
                    user in
                    HStack {
                        AsyncImage(url: URL(string: user.picture.thumbnail), content: {image in image.clipShape(Circle())}, placeholder: {
                            Image(systemName: "person")
                                .frame(width: 50, height: 50, alignment: .center)
                        })
                        Text(user.fullName)
                    }
                }
            }
            .navigationTitle("Random Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
