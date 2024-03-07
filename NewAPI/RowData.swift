//
//  RowData.swift
//  NewAPI
//
//  Created by Alex Beattie on 9/28/23.
//

import SwiftUI

struct RowData: View {
    
    var listing: Value
     
//    let results: Listing
    var body: some View {
        
        ZStack {
            VStack (alignment: .leading, spacing: 12) {
                Text(listing.ListAgentFullName ?? "")

                AsyncImage(url: URL(string: listing.Media?.first?.MediaURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width:400, height:200)
                        .clipped()
                    
                } placeholder: {
                    ProgressView()
                }
                HStack (alignment: .bottom){
                    
                    VStack (alignment: .leading) {
                        Text("$\(listing.ListPrice ?? 0)")
                            .font(.system(size: 14, weight: .semibold))
                            .scaledToFit()

                            .foregroundColor(Color(.label))

                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                        Text("Price")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        Text("\(listing.BedroomsTotal ?? 0)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(.label))
                        Label("Beds", systemImage: "bed.double")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        Text(String(listing.BathroomsTotalInteger ?? 0))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Color(.label))
                        Label("Baths", systemImage: "bathtub")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack (alignment: .leading) {
                        Spacer()
                        Text("\(listing.BuildingAreaTotal ?? 0)")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(.label))
                        
                        Text("Sq Feet")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                        
                    }
                }.padding(.horizontal)
                
                HStack (alignment: .lastTextBaseline, spacing: 0){
                    
                    VStack (alignment:.leading) {
                        HStack {
                            VStack (alignment: .leading){
                                Text(listing.UnparsedAddress ?? "")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.gray))
                                Text(listing.ListAgentFullName ?? "")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(Color(.gray))
                                Text(listing.MlsStatus ?? "")
                                    .font(.system(size: 14, weight: .regular))
                                    .frame(maxHeight: .infinity)

//                                HStack {
//                                    Text("\(listing.City),")
//                                        .font(.system(size: 14, weight: .regular))
//                                        .foregroundColor(Color(.gray))
//                                    Text("\(listing.StateOrProvince),")
//                                        .font(.system(size: 14, weight: .regular))
//                                        .foregroundColor(Color(.gray))
//                                    Text(listing.PostalCode)
//                                        .font(.system(size: 14, weight: .regular))
//                                        .foregroundColor(Color(.gray))
//                                }
                                
                            }
                        }
//                        Text(listing.MlsStatus)
//                            .frame(maxHeight: .infinity)
//                            .padding(.bottom)
//                        Link("List Agent", destination: URL(string: listing.ListAgentURL ?? "alex")!)

                        Divider()
                    }
//                    Link("List Agent", destination: URL(string: li ?? "alex")!)

                    .padding(.horizontal)
                }
//                Spacer(minLength: 400)
            }
        }
    }
}
struct RowData_Previews: PreviewProvider {
    static var previews: some View {
//        RowData()
    
        RowData(listing: Value(CoListAgentFullName: "Alex", ListAgentFullName: "Beattie", MlsStatus: "Open", Media: [], ListingKey: "1221", UnparsedAddress: "123 Anywhere Usa", PostalCode: "91221", StateOrProvince: "CA", City: "Thousand Oaks", BathroomsTotalInteger: 0, BuilderName: "Sherwood", BuyerAgentMlsId: "123",BuyerOfficePhone: "1",CloseDate: "99",LivingArea: 123))
    }
}
