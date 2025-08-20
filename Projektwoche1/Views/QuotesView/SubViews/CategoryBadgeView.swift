//
//  CategoryBadgeView.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 20.08.25.
//

import SwiftUI

// MARK: - Badge View
struct CategoryBadgeView: View {
    let category: Category?
    let isEllipsis: Bool

    var body: some View {
        Text(isEllipsis ? "…" : category?.rawValue ?? "")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                ZStack {
                    if isEllipsis {
                        Capsule().fill(Color.pinkAccent.opacity(0.2))
                        Capsule().stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                    } else if let cat = category {
                        Capsule().fill(.ultraThinMaterial)
                        Capsule().fill(cat.gradient)
                        Capsule().stroke(Color.secondary.opacity(0.25), lineWidth: 1)
                    }
                }
            )
            .foregroundColor(isEllipsis ? Color.pinkAccent : .white)
    }
}



//#Preview {
//    CategoryBadgeView()
//}
