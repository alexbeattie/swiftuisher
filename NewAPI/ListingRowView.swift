//
//  ListingRowView.swift
//  NewAPI
//
//  Created by Alex Beattie on 3/6/24.
//

import Foundation


import SwiftUI

struct ListingRowView: View {
    let listing: Value // Assuming `Value` is your data model type

    var body: some View {
        VStack(alignment: .center) {
            Text("$\(listing.ListPrice ?? 0)")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.label))
                .scaledToFit()
                .minimumScaleFactor(0.01)
                .lineLimit(1)
//            Text("Price")
//                .font(.system(size: 14, weight: .regular))
//                .foregroundColor(.gray)
        }
        HStack(alignment: .bottom) {

            
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(listing.BedroomsTotal ?? 0)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(.label))
                Label("Beds", systemImage: "bed.double")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(listing.BathroomsTotalInteger ?? 0)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(.label))
                Label("Baths", systemImage: "bathtub")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack(alignment: .center) {
                Text("\(listing.BuildingAreaTotal ?? 0)")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(.label))
                Text("Sq Feet")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
        VStack(alignment: .center){
            Text(AttributedString(listing.UnparsedAddress ?? ""))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color(.label))
                .minimumScaleFactor(0.01)
                .lineLimit(1)
        }
        .padding(.horizontal)
    }
}
