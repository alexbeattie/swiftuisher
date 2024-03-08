//
//  ContentView.swift
//  NewAPI
//
//  Created by Alex Beattie on 9/20/23.
//

import SwiftUI
import Combine
import AVKit

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let listing: Value
    let topListing: Listing
    
    let media: [Value.Media]
    @StateObject var vm = ListingPublisherViewModel()
    @State private var showingSheet = false
    @State private var destinationSearchView = false
    var body: some View {

        VStack(alignment: .leading, spacing: 8.0) {
            NavigationView {
//                                if destinationSearchView {
//                                    DestinationSearchView()
//                                } else {
//                
//                                }
                

                
                ScrollView {
//                    SearchAndFilterBar()

                    ForEach(vm.results, id: \.ListingKey)  { listing  in
                        
                        NavigationLink {
                            
                            NavigationLazyView(
                                
                                PopDestDetailsView(value: listing, media: media))
//                                .navigationBarBackButtonHidden()
//                                  Text("details")
                        } label: {
                            VStack(alignment: .leading) {
                                HStack {
                                    AsyncImage(url: URL(string: listing.Media?.first?.MediaURL ?? "")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)                                            .clipped()
                                            .ignoresSafeArea()
                                            .overlay(alignment: .bottom) {
                                                VStack {
//                                                    Divider()
//                                                        .padding(.bottom)
                                                    HStack {
                                                        Spacer()
                                                        VStack () {
                                                            Text("$\(listing.ListPrice ?? 0)")
                                                                .font(.system(size: 16, weight: .semibold))
                                                                .foregroundColor(Color(.label))
                                                                .scaledToFit()
                                                                .minimumScaleFactor(0.01)
                                                                .lineLimit(1)
                                                        }
//                                                        .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 0))
                                                        Spacer()

                                                        
                                                        VStack () {
                                                            Text("\(listing.Model ?? "")")
                                                                .font(.system(size: 16, weight: .semibold))
                                                                .foregroundColor(Color(.label))
                                                                .scaledToFit()
                                                                .minimumScaleFactor(0.01)
                                                                .lineLimit(1)
//
                                                            
                                                        }.padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                                        Spacer()
                                                        VStack {
                                                                   // Conditional rendering based on listing's MlsStatus
                                                                   if listing.MlsStatus == "Active" {
                                                                       Text(listing.MlsStatus ?? "")
                                                                           .font(.system(size: 16, weight: .semibold))
                                                                           .foregroundColor(Color(.label)) // Use Color.label for SwiftUI native color
                                                                           .scaledToFit()
                                                                           .minimumScaleFactor(0.01)
                                                                           .lineLimit(1)
                                                                   } else if listing.MlsStatus == "Pending" {
                                                                       Text(listing.MlsStatus ?? "")
                                                                           .font(.system(size: 16, weight: .semibold))
                                                                           .foregroundColor(Color.red) // Red color for 'Pending' status
                                                                           .scaledToFit()
                                                                           .minimumScaleFactor(0.01)
                                                                           .lineLimit(1)
                                                                   } else if listing.MlsStatus == "Active Under Contract" {
                                                                       Text(listing.MlsStatus ?? "")
                                                                           .font(.system(size: 16, weight: .semibold))
                                                                           .foregroundColor(Color.red) // Red color for 'Pending' status
                                                                           .scaledToFit()
                                                                           .minimumScaleFactor(0.01)
                                                                           .lineLimit(1)
                                                                   }
                                                            
                                                            
                                                                else {
                                                                       // Default view if MlsStatus is neither 'Active' nor 'Pending'
                                                                       Text(listing.MlsStatus ?? "Unknown Status")
                                                                           .font(.system(size: 16, weight: .regular))
                                                                           .foregroundColor(Color.gray)
                                                                           .scaledToFit()
                                                                           .minimumScaleFactor(0.01)
                                                                           .lineLimit(1)
                                                                   }
                                                               }
                                                                    
                                                                    .padding(.init(top: 8, leading: 0, bottom: 8, trailing: 0))
                                                        Spacer()

                                                    }
//                                                    .padding(.horizontal, 32)
                                                }
                                                .background(Color.black.opacity(0.5))
//                                                .background(LinearGradient(
//                                                    gradient: Gradient(colors: [Color.clear, Color.white]),
//                                                    startPoint: .bottom, // Start from transparent
//                                                    endPoint: .top // End at dark
//                                                )).edgesIgnoringSafeArea(.all) // Extend to the edges if needed
                                            }

//
                                        
                                        
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    
                                }
                                ListingRowView(listing: listing)


                                    
                                HStack (alignment: .center) {
                                       
                                        VStack (alignment: .leading) {
//                                            
                                        

                                            Text(listing.ListAgentFullName ?? "")
                                                .font(.system(size: 16, weight: .regular))

                                        
                                        
                                            
                                            HStack {
                                                Text(listing.MlsStatus ?? "")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(Color(.tertiaryLabel))
//                                                Text("\(listing.BuyerOfficeAOR ?? "")")
//                                                    .font(.system(size: 12, weight: .heavy))
                                            }
                                            Button("VIEW DETAILS") {
                                                showingSheet.toggle()
                                            }
                                            .sheet(isPresented: $showingSheet) {
                                                
                                                PopDestDetailsView(value: listing, media: media)
                                            }
                                            
                                            HStack {
                                                
                                                
                                                Text(listing.ListPrice ?? 0, format: .currency(code: "USD"))
                                                    .font(.system(size: 14, weight: .regular))
                                                Text(listing.formattedLaunchDate)
                                                    .font(.system(size: 14, weight: .regular))
                                                
                                                
                                            }
                                            .padding(.horizontal)
                                        }
                                        
                                    }
                                    .padding(.horizontal)
                                
                                
                            }
                        }
                        
                        .padding(.bottom)
                    }
                    //TODO
                    //Show next page of listings
                    //                                    ForEach(vm.listings, id: \.odataContext) { topListing in
                    //                                        Link ("next", destination: URL(string: topListing.odataNextLink!)!)
                    //                                    }
                }
                //                .navigationTitle("Listings")
                //                .navigationBarTitleDisplayMode(.automatic)
                .ignoresSafeArea()
//                .background(.darkBackground)
                .preferredColorScheme(.dark)
            }
        }
        .task {
            await vm.fetchProducts()
        }
    }
    
}
struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}


struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(listing: Value(CoListAgentFullName: "Alex", ListAgentFullName: "Beattie", MlsStatus: "Open", Media: [], ListingKey: "1221", UnparsedAddress: "123 Anywhere Usa", PostalCode: "91221", StateOrProvince: "CA", City: "Thousand Oaks", BathroomsTotalInteger: 0, BuilderName: "Sherwood",BuyerAgentMlsId: "123", BuyerOfficePhone: "1", CloseDate: "99", ListingContractDate: Date(),LivingArea: 123), topListing: Listing(odataContext: "alex", odataNextLink: "alex", odataCount: 0, value: [Value].init()), media: [] )
        
            .preferredColorScheme(.dark)
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(json JSONData: Data) {
        guard
            let JSONObject = try? JSONSerialization.jsonObject(with: JSONData, options: []),
            let jsonData = try? JSONSerialization.data(withJSONObject: JSONObject, options: .prettyPrinted) else {
            appendInterpolation("Invalid JSON data")
            return
        }
        appendInterpolation("\n\(String(decoding: jsonData, as: UTF8.self))")
    }
}
