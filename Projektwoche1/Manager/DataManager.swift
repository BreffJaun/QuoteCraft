//
//  DataManager.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 18.08.25.
//

import Foundation
import SwiftData

class DataManager {
    private init() {}
    
    // MARK: - Produktiver Container
    static let container: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: User.self, Quote.self
            )
            
            Task { @MainActor in
                let context = container.mainContext
                let userCount = try? context.fetchCount(FetchDescriptor<User>())
                if userCount == 0 {
                    dummyUsers.forEach { context.insert($0) }
                    dummyQuotes.forEach { context.insert($0) }
                    try? context.save()
                }
            }
            
            return container
            
//            return try ModelContainer(for: User.self, Quote.self)
        } catch {
            fatalError("❌ Failed to configure SwiftData ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Preview Container (für SwiftUI Previews)
    @MainActor
    static let previewContainer: ModelContainer = {
        do {
            let container = try ModelContainer(
                for: User.self, Quote.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            
            let context = container.mainContext
            
            // 👉 Dummy-Data
            dummyUsers.forEach { context.insert($0) }
            dummyQuotes.forEach { context.insert($0) }
            
            return container
            
        } catch {
            fatalError("❌ Failed to configure SwiftData Preview ModelContainer: \(error)")
        }
    }()
}
