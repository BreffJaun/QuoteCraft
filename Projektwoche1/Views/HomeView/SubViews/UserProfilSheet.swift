//
//  UserProfilSheet.swift
//  Projektwoche1
//
//  Created by Romina Reiber on 19.08.25.
//

import SwiftUI
import SwiftData

struct UserProfilSheet: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var users: [User]
    
    @State private var username = ""
    @State private var selectedCategories: Set<Category> = []
    @State private var entryCategory: Category = .miscellaneous
    
    @AppStorage("currentUserId") private var currentUserId: String?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Username", text: $username)
                }
                Section(header: Text("Favorite Categories")) {
                    Menu {
                        ForEach(Category.allCases, id: \.rawValue) { category in
                            Button {
                                if !selectedCategories.contains(category) {
                                    selectedCategories.insert(category)
                                }
                            } label: {
                                Text(category.rawValue)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Add Category")
                            Spacer()
                            Image(systemName: "plus.circle")
                        }
                    }
                    if selectedCategories.isEmpty {
                        Text("No Categories selected yet!")
                    } else {
                        ForEach(Array(selectedCategories), id: \.self) { category in
                            Text(category.rawValue)
                        }

                    }
                }
                Button {
                    let newUser = User(
                        id: UUID(), username:username,
                        favCategories: Array(selectedCategories)
                    )
                    context.insert(newUser)
                    currentUserId = newUser.id.uuidString
//                    currentUserId = users[0].id.uuidString
                    dismiss()
                } label: {
                    Text("safe")
                }
            }
        }
    }
}

#Preview {
    UserProfilSheet()
}
