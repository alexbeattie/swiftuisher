//
//  PopDetailsView.swift
//  NewAPI
//
//  Created by Alex Beattie on 9/28/23.
//

import SwiftUI
import MapKit
import Kingfisher

struct PopDestDetailsView: View {

    let value:[Value]
    let media: [Value.Media]
    
    @State var region:MKCoordinateRegion
    @Environment(\.dismiss) var dismiss

    init(value: Value, media: [Value.Media]) {
        
        self.value = [value]
        self.media = value.Media.map { $0 }!
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: value.Latitude ?? 0, longitude: value.Longitude ?? 0), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                TabView {
                    ForEach(media, id: \.MediaKey) { media in
                        KFImage(URL(string: (media.MediaURL ?? "")))
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .frame(height:320)
            .tabViewStyle(.page)
               
            .overlay(alignment: .topLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .background {
                            Circle()
                                .fill(.white)
                                .frame(width: 32, height: 32)
                                
                        }
                }
                .padding(62)
            }
            HStack (alignment: .bottom) {
                
                VStack (alignment: .center) {
                    Text("$\(value.first?.ListPrice ?? 0)")
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
                
                VStack (alignment: .center) {
                    Text("\(value.first?.BedroomsTotal ?? 0)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.label))
                    Label("Beds", systemImage: "bed.double")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                VStack (alignment: .center) {
                    Text(String(value.first?.BathroomsTotalInteger ?? 0))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(.label))
                    Label("Baths", systemImage: "bathtub")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                Spacer()
                
                VStack (alignment: .center) {
                    Text("\(value.first?.BuildingAreaTotal ?? 0)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color(.label))
                    
                    Text("Sq Feet")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
            }.padding(.horizontal)
            Spacer()
            
            HStack () {
                
                VStack (alignment: .leading) {
                    Link("Website", destination: URL(string: value.first?.ListAgentURL ?? "alex")!)
                    }
//                  Link("List Agent", destination: URL(string: li ?? "alex")!)
//                .padding(.horizontal)
            }

            VStack (alignment: .leading, spacing: 16) {
                Text("What this place has to offer")
                    .font(.headline)
//                ForEach(0 ..< 5) { feature in
//                    HStack {
//                        Image(systemName: "wifi")
//                            .frame(width:32)
//                        Text("wifi")
//                            .font(.footnote)
//                        Spacer()
//                    }
//                }
            }
            .padding()
            VStack (alignment: .leading) {
                
//                Text(value.first?.UnparsedAddress ?? "")
//                    .multilineTextAlignment(.leading)
//
//                Text("$\(value.first?.ListPrice ?? 0)")
//
//                Text("aex")
//                    .font(.headline)
//                    .foregroundColor(Color(.green))
                Text(value.first?.MlsStatus ?? "")
                    .font(.system(size: 14, weight: .heavy))
                 
                Text(value.first?.PublicRemarks ?? "")
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
          
            Divider()
            

            MapView(value: value)
                .frame(height:200)
                .clipShape(RoundedRectangle(cornerRadius:12))
                .edgesIgnoringSafeArea(.bottom)
        }
        .padding(.bottom, 122)

        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            VStack {
                Divider()
                    .padding(.bottom)
                HStack {
                    VStack (alignment: .leading) {
                        Text("$500")
                            .foregroundStyle(.black)
                            .font(.subheadline)
                        Text("total")
                            .foregroundStyle(.black)
                            .font(.footnote)
                        Text("date")
                            .foregroundStyle(.black)
                            .font(.footnote)
                        
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Reserve")
                            
                            .foregroundStyle(.white)
                            .font(.headline)
                            .frame(width: 140, height: 40)
                            .background(.pink)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                }
                .padding(.horizontal, 32)
            }
            .background(.white)
        }

    }
}

struct MapView: UIViewRepresentable {
    
    
    let value:[Value]

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
                init(_ parent: MapView) {
                    self.parent = parent
                }
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard !(annotation is MKUserLocation) else {
//                return nil
//            }
            
            let annotationIdentifier = "AnnotationIdentifier"
            
            let annoView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annoView.canShowCallout = true
        
            // Add a RIGHT CALLOUT Accessory
            let rightButton = UIButton(type: UIButton.ButtonType.detailDisclosure)
            rightButton.frame = CGRect(x:0, y:0, width:32, height:32)
            rightButton.clipsToBounds = true
            rightButton.setImage(UIImage(named: "small-pin-map-7"), for: UIControl.State())
            annoView.rightCalloutAccessoryView = rightButton
            
            let leftView = UIView()
            
            leftView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            leftView.backgroundColor = .blue
            annoView.leftCalloutAccessoryView = leftView

//           Add a LEFT IMAGE VIEW
            
//            var leftIconView = UIImageView()
//            leftIconView.contentMode = .scaleAspectFill
//            leftIconView.contentMode = .scaleAspectFill
//            let newBounds = CGRect(x:0.0, y:0.0, width:54.0, height:54.0)
//            leftIconView.bounds = newBounds
//            leftIconView.clipsToBounds = true
//            let thumbnailImageUrl = KFImage(URL(string:listing.StandardFields.Photos?.first?.Uri300 ?? ""))
//            leftIconView = KFImage(URL(string:listing.StandardFields.Photos?.first?.Uri300 ?? ""))
//            annoView.leftCalloutAccessoryView = leftIconView
            
            return annoView
            
            }
        
        }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func updateUIView(_ view: MKMapView, context: Context) {
        view.mapType = .hybrid
        view.delegate = context.coordinator

        let coordinate = CLLocationCoordinate2D(
            latitude: value.first?.Latitude ?? 0, longitude: value.first?.Longitude ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
        
        let lat = value.first?.Latitude ?? 0
        let lng = value.first?.Longitude ?? 0
            
        let pinDrop = CLLocationCoordinate2DMake(lat, lng)
        let pin = MKPointAnnotation()
        pin.coordinate = pinDrop
                       
//            let coordinateRegion = MKCoordinateRegion.init(center: location, latitudinalMeters: 27500.0,
//                  longitudinalMeters: 27500.0)
//            mapView.setRegion(coordinateRegion, animated: true)
//
//            let pin = MKPointAnnotation()
//            pin.coordinate = location
        
            pin.title = value.first?.UnparsedAddress
            let listPrice = value.first?.ListPrice
            let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal

        let subtitle = "$\(numberFormatter.string(from: NSNumber(value:(UInt64(listPrice ?? 0) )))!)"
//
            pin.subtitle = subtitle
//            pin.coordinate = pin
//            view.addAnnotation(lat as! MKAnnotation)
            view.selectAnnotation(pin, animated: true)
            view.addAnnotation(pin)
//            view.addAnnotations(landmarks)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
}

struct PopDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PopDestDetailsView(value: Value(CoListAgentFullName: "Alex", 
                                        ListAgentFullName: "Beattie",
                                        MlsStatus: "Open",
                                        Media: [],
                                        ListingKey: "1221",
                                        UnparsedAddress: "123 Anywhere Usa",
                                        PostalCode: "91221",
                                        StateOrProvince: "CA",
                                        City: "Thousand Oaks",
                                        BathroomsTotalInteger: 0,
                                        PublicRemarks: "This 11,719 sq. ft. Presidential Palace overlooking the Ronald Reagan Library rests on a 10 acre lot. The estate boasts commanding views of the Santa Rosa Valley all the way to the Pacific Ocean! The sheer beauty of the views pairs brilliantly with all the amenities within the Mediterranean style mansion. A carefully thought out layout provides both convenience and comfort. Entering through the 4 Corinthian Columns leading to the front door you are met with a floor to ceiling foyer captivating your senses immediately. On the right a beautifully woodworked library complimented by one of the 4 wood burning fireplaces in the main residence. To the left a stunning formal living room. Moving down the expansive hallway you\'ll pass an elegant formal powder, dining room, temperature controlled wine cellar, gourmet kitchen with views that will bring as much pleasure as the delicacies created within, and the family room. An impressive Game Room/Bar, another powder bath, 2 guest rooms, laundry room, and full gym en suite with a steam shower and a sauna. To arrive upstairs you may take the beautiful winding marble staircase, one of three in the home, or you may choose to take the elevator. Once there you will find the primary suite, a private oasis, featuring his and her bathrooms with bidets, a walk-in linen closet, shower big enough for 2 with a steam shower option! Still yet a master walk-in closet featuring separate entries with an additional walk-in closet dedicated to special suits, furs and cashmere treasures, as well as a Master Sitting room all encompassed by the primary balcony where one can enjoy the breathtaking views and picturesque sunsets. 4 additional bedrooms, a laundry/arts and crafts room, kitchenette, and a fully equipped theater with seating for at least 15 is ready to satisfy your entertainment desires rounds out the upper story. Outside you\'ll find over 1,000 sq ft of covered patio, a built-in BBQ, spa , and a fully gated beach entry pool with grotto and waterslide, a lovely 600+ sq ft pool cabana with outdoor shower to accommodate all your hosting needs. Behind the cabana you\'ll discover a magical walkway encircling the property taking you through the beautifully landscaped hillside leading you to a staircase back up to the kitchen terrace. The driveway leads you up to the motor court, and the over 2,300 sq ft of garages that are able to accommodate 9 vehicles. Across the motor court lies a 1,198 sq ft 2+2 guest house with full kitchen and laundry that features a patio looking out to the beautiful horizon. The Mediterranean masterclass of architecture weaves together both beauty and function constructed entirely out of 2x6\'s, and steel structural supports with a detached solar system that eliminates the electric bill",
                                        BuilderName: "Sherwood",
                                        BuyerAgentMlsId: "123",
                                        BuyerOfficePhone: "1",
                                        LivingArea: 123
                                       ), media: [])
    }
}
