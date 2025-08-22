//
//  UserProfilSheet.swift
//  Projektwoche1
//
//  Created by Romina Reiber on 19.08.25.
//

import SwiftUI
import SwiftData

struct UserProfilSheet: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var users: [User]
    
    @AppStorage("currentUserId") private var currentUserId: String?
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    @State private var username = ""
    @State private var selectedCategories: Set<Category> = []
    @State private var entryCategory: Category = .miscellaneous
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Username")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("Enter your username", text: $username)
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Favorite Categories")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Menu {
                            ForEach(Category.allCases.filter { $0 != .ellipsis }, id: \.rawValue) { category in
                                Button {
                                    if !selectedCategories.contains(category) {
                                        selectedCategories.insert(category)
                                    }
                                } label: {
                                    Label(category.rawValue, systemImage: selectedCategories.contains(category) ? "checkmark" : "")
                                }
                            }
                        } label: {
                            HStack {
                                Text("Add Category")
                                Spacer()
                                Image(systemName: "plus.circle")
                            }
                            .padding(12)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        
                        if selectedCategories.isEmpty {
                            Text("No Categories selected yet!")
                                .foregroundColor(.secondary)
                                .font(.subheadline)
                        } else {
                            FlowLayoutUPS(data: Array(selectedCategories), spacing: 8) { category in
                                Text(category.rawValue)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                //                                    .background(.ultraThinMaterial)
                                    .background(
                                        ZStack {
                                            Capsule()
                                                .fill(.ultraThinMaterial)
                                            
                                            Capsule()
                                                .fill(category.gradient)
                                            
                                            Capsule()
                                                .stroke(Color.white.opacity(0.25), lineWidth: 1)
                                        }
                                    )
                                    .foregroundColor(.white)
                                    .onTapGesture {
                                        selectedCategories.remove(category)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Appearance")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Image(systemName: colorScheme == .dark ? "moon.fill" : "sun.max.fill")
                                .foregroundColor(.primary)
                            
                            Toggle(isDarkModeEnabled ? "Dark Mode" : "Light Mode", isOn: $isDarkModeEnabled)
                                .onChange(of: isDarkModeEnabled) { _, newValue in
                                    // Systemeinstellung für Dark Mode setzen
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let window = windowScene.windows.first {
                                        window.overrideUserInterfaceStyle = newValue ? .dark : .light
                                    }
                                }
                        }
                        .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                        .padding(12)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .padding(.horizontal)
                    
                    Button {
                        let newUser = User(
                            id: UUID(),
                            username: username,
                            favCategories: Array(selectedCategories)
                        )
                        context.insert(newUser)
                        currentUserId = newUser.id.uuidString
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color.accentColor)
                            )
                            .padding(.horizontal)
                            .shadow(radius: 4)
                    }
                    .disabled(username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedCategories.isEmpty)
                    .opacity(username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedCategories.isEmpty ? 0.5 : 1.0)
                    
                    Button {
                        currentUserId = ""
                        print(currentUserId)
                        dismiss()
                    } label: {
                        Text("Reset USERID")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .fill(Color.accentColor)
                            )
                            .padding(.horizontal)
                            .shadow(radius: 4)
                    }
    
                }
                .padding(.vertical, 20)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .background(
                LinearGradient(
                    colors: [Color("HomeGradientStart"),
                             Color("HomeGradientMiddle"),
                             Color("HomeGradientEnd")],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                            .bold()
                    }
                }
            }
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    isDarkModeEnabled = window.traitCollection.userInterfaceStyle == .dark
                }
            }
        }
    }
}

//#Preview {
//    UserProfilSheet()
//}


