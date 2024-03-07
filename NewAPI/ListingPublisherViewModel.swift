//
//  ListingPublisherViewModel.swift
//  NewAPI
//
//  Created by Alex Beattie on 10/3/23.
//

import Foundation

@MainActor
class ListingPublisherViewModel: ObservableObject {
    
    @Published var results = [Value]()
    @Published var listings = [Listing]()

    func fetchProducts() async {
        
//        @State var media = [Media]()

        //jordan
//        let url = URL(string: "https://replication.sparkapi.com/Reso/OData/Property?$filter=(ListAgentKey eq '20160917171113923841000000')  and StandardStatus eq 'Active'&$top=20&$orderby=ListPrice desc&$count=true&$limit=60&$expand=Media".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
//        let url = URL(string:  "https://replication.sparkapi.com/Reso/OData/Property?$top=50&$expand=Media&$filter=&$count=true&$filter=(ListAgentKey eq '20160917171119703445000000') and StandardStatus eq 'Pending'".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        //create the new url
//       let url = URL(string: "https://replication.sparkapi.com/Reso/OData/Property?$filter=(ListPrice ge 1000000) and (MlsStatus eq 'Active')&$orderby=ListPrice desc&$expand=Media&$skip=10&$count=true".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
//    let url = URL(string: "https://replication.sparkapi.com/Reso/OData/Property?$orderby=ListPrice desc&$expand=Media&$count=true&$filter=ListAgentKey eq '20160917171119703445000000'and StandardStatus eq 'Active'".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
//        let url = URL(string:"https://replication.sparkapi.com/Reso/OData/Property?$orderby=ListPrice desc&$expand=Media&$count=true&$filter=(MlsStatus eq 'Active' and ListAgentKey eq '20220622184809040862000000')".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
//    https://replication.sparkapi.com/Reso/OData/Property?orderby=ListPrice asc&$expand=Media&$top=50&$count=true&$filter=ListAgentKey eq '20160917171119703445000000'
        
        ///THE FUCKING LISTINGS
               let url = URL(string:"https://replication.sparkapi.com/Reso/OData/Property?$orderby=ListPrice desc&$filter=ListAgentKey eq '20160917171119703445000000' and StandardStatus ne 'Closed' and StandardStatus ne 'Expired' and StandardStatus ne 'Canceled'&$top=50&$expand=Media".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        //create a new urlRequest passing the url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
        do {
            
            //run the request and retrieve both the data and the response of the call
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-dd"
            decoder.dateDecodingStrategy = .formatted(formatter)

            //checks if there are errors regarding the HTTP status code and decodes using the passed struct
            if let fetchedData = try? decoder.decode(Listing.self, from: data) {
//                , let moreData = try? decoder.decode(Media.self, from: data) {
                print(fetchedData)

                self.results = fetchedData.value ?? []
                self.listings = [fetchedData]
                
//                self.media = [moreData]
//                ForEach(moreData, id: \.self) { newResult in
//                    print(newResult)
//                }
//                for x in results {
//                    print(x.Media?.first?.MediaURL)
//                }
//                for y in [media] {
//
//                    print(y.first?.MediaURL)
//                }
//                print(media)
//                self.media = fetchedData
//                for moreData in self.listings {
//                    print([moreData.value?.first?.Media])
//                }
//                print(moreData)
//                print("The JSON response is \(json: data)")
                 
            }
        } catch {
            print("invalid data")
        }
    }
}

   
