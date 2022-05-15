//
//  UserData.swift
//  randomUsers
//
//  Created by Антон Голубейков on 15.05.2022.
//

import Foundation

@MainActor
class UserData: ObservableObject {
    @Published var users: String = ""
    
    init() {
        Task {
        await loadUsers()
    }
    }
    func loadUsers() async {
        do {
            let users = try await UserFetchingClient.getUsers()
            self.users = users
        }
        catch {
            print(error)
        }
    }
    
}
