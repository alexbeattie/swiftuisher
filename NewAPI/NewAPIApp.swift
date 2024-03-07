//
//  NewAPIApp.swift
//  NewAPI
//
//  Created by Alex Beattie on 9/20/23.
//

import SwiftUI

@main
struct NewAPIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(listing: .init(), topListing: .init(odataContext: "", odataNextLink: "", odataCount: 0, value: nil), media: []
            )
        }
    }
}
