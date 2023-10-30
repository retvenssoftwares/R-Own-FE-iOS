//
//  AutoFetchLocationTab.swift
//  R-own
//
//  Created by Aman Sharma on 22/07/23.
//

import SwiftUI
import Combine
import CoreLocation
import AlertToast

struct AutoFetchLocationTab: View {
    
    @Binding var autoLocation: String
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    let locationProvider = LocationProvider()
    @StateObject var deviceLocationService = DeviceLocationService.shared

    @State var tokens: Set<AnyCancellable> = []
//    @StateObject var locationManager = LocationManager()
    
    @State var alertForLocation: Bool = false
    
    @State var locationBottomSheet: Bool = false
    @State var width: CGFloat
    
    var body: some View {
        
        //Location Field=
        ZStack{
            VStack{
                Button(action: {
                    loginData.mainLocationBottomSheet.toggle()
                }, label: {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.5)
                        .frame(width: width, height: UIScreen.screenHeight/22)
                        .background(.white)
                        .overlay{
                            if autoLocation == "" {
                                HStack{
                                    Text("Your Location")
                                        .font(.body)
                                        .fontWeight(.light)
                                        .foregroundColor(lightGreyUi)
                                        .frame( alignment: .leading)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                    Spacer()
                                }
                            } else {
                                HStack{
                                    Text(autoLocation)
                                        .font(.body)
                                        .fontWeight(.light)
                                        .frame( alignment: .leading)
                                        .foregroundColor(.black)
                                        .padding(.horizontal, UIScreen.screenWidth/40)
                                    Spacer()
                                }
                            }
                            VStack{
                                HStack{
                                    Text("Location")
                                        .font(.footnote)
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: UIScreen.screenWidth/40, y: -UIScreen.screenHeight/100)
                                    Spacer()
                                }
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                Button(action: {
                                    loginData.showLoader = true
                                    fetchLocation()
                                }, label: {
                                    Image("AutoDetectLocationIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                })
                                .padding(.horizontal, UIScreen.screenWidth/40)
                            }
                        }
                })
            }
            .padding(.vertical, UIScreen.screenHeight/30)
        }
        .toast(isPresenting: $alertForLocation, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Auto Fetch Error", subTitle: ("Can't find your location, check your permission or enter manually"))
        }
    }
    func fetchLocation() {
        
        LocationManager.sharedManager().requestLocationUpdate { coordinates in
            if let coordinates = coordinates {
                loginData.coordinates = coordinates
                print("Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if loginData.coordinates.latitude != 0.000000{
                        let location = CLLocation(latitude: loginData.coordinates.latitude, longitude: loginData.coordinates.longitude)
                        
                        locationProvider.getPlace(for: location) { plsmark in
                            guard let placemark = plsmark else { return }
                            if let streetNumber = placemark.subThoroughfare,
                               let street = placemark.subThoroughfare,
                               let city = placemark.locality,
                               let state = placemark.administrativeArea {
                                autoLocation = "\(streetNumber) \(street) \(city) \(state)"
                                print(1)
                                print(loginData.mainUserLocation)
                            } else if let city = placemark.locality, let state = placemark.administrativeArea, let locality = placemark.subLocality, let country = placemark.country {
                                autoLocation = "\(locality), \(city), \(state), \(country)"
                                print(2)
                                print(autoLocation)
                            } else {
                                alertForLocation = true
                                autoLocation = ""
                                print(3)
                                print(autoLocation)
                            }
                            loginData.showLoader = false
                        }
                    }
                }
            } else {
                loginData.showLoader = false
                alertForLocation = true
                print("Failed to get current location.")
            }
        }
    }
}

//struct AutoFetchLocationTab_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoFetchLocationTab()
//    }
//}
