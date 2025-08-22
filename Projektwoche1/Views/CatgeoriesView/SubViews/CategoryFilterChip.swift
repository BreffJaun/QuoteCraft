//
//  CategoryFilterChip.swift
//  QuoteCraft
//
//  Created by Jeff Braun on 22.08.25.
//

import SwiftUI
import SwiftData

struct CategoryFilterChip: View {
    let title: String
    let isSelected: Bool
    let gradient: LinearGradient
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.weight(.medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background {
                    if isSelected {
                        gradient
                    } else {
                        Color.clear
                    }
                }
                .overlay {
                    if !isSelected {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke(.ultraThinMaterial, lineWidth: 1)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(
                    color: isSelected ? .black.opacity(0.2) : .clear,
                    radius: isSelected ? 4 : 0,
                    x: 0,
                    y: isSelected ? 2 : 0
                )
        }
        .scaleEffect(isSelected ? 1.05 : 1.0)
    }
}


//#Preview {
//    CategoryFilterChip()
//}
