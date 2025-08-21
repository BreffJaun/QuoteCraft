//
//  ShareSheet.swift
//  Projektwoche1
//
//  Created by Jeff Braun on 21.08.25.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

//#Preview {
//    ShareSheet()
//}
