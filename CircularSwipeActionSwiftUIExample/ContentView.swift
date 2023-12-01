//
//  ContentView.swift
//  CircularSwipeActionSwiftUIExample
//
//  Created by Antoine Bollengier on 01.12.2023.
//

import SwiftUI
import SwiftUIIntrospect
import UICustomSwipeActions

struct ContentView: View {
    var body: some View {
        VStack {
            List(0..<10, rowContent: { number in
                Text(String(number))
                    .padding()
                    .frame(height: 80)
            })
            .introspect(.list, on: .iOS(.v16, .v17), customize: { controller in
                let controller = controller as UICollectionView
                var config = UICollectionLayoutListConfiguration(appearance: .plain)
                config.trailingSwipeActionsConfigurationProvider = { _ in
                    // Delete button
                    UICustomSwipeActionsConfiguration.configure()
                    let deleteAction = UIContextualAction(style: .destructive, title: "") { $2(true) }
                    deleteAction.image = UIImage(systemName: "trash")
                    
                    // Add button
                    let addAction = UIContextualAction(style: .normal, title: "") { $2(true) }
                    addAction.image = UIImage(systemName: "plus")
                    addAction.backgroundColor = .green
                    
                    let swipeMenu = UICustomSwipeActionsConfiguration(actions: [deleteAction, addAction])
                    swipeMenu.preferredButtonWidth = 50
                    swipeMenu.style = .circular
                    return swipeMenu
                }
                let finalConfig = UICollectionViewCompositionalLayout.list(using: config)
                controller.collectionViewLayout = finalConfig
            })
        }
        .padding()
    }
}


