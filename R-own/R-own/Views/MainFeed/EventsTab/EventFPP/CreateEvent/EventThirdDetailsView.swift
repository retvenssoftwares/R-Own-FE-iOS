//
//  EventThirdDetailsView.swift
//  R-own
//
//  Created by Aman Sharma on 13/05/23.
//

import SwiftUI

struct EventThirdDetailsView: View {
    @StateObject var globalVM: GlobalViewModel
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    @State var eventBG: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var eventBGCropped: UIImage?
    
    @State var navigateToAllEventView: Bool = false
    
    @StateObject var eventService = UserEventService()
    
    var body: some View {
        NavigationStack{
                VStack{
                    //nav
                    
                    BasicNavbarView(navbarTitle: "Create An Event")
                    
                    //body
                    ScrollView {
                        VStack{
                            //Text
                            Text("Please enter the details about your event")
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, UIScreen.screenHeight/50)
                            
                            VStack{
                                
                                //text event thumbnail
                                
                                Text("Event Thumbnail")
                                    .font(.system(size: UIScreen.screenHeight/70))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                    //img Hotelimg
                                    
                                    if self.eventBGCropped != nil {
                                        Image(uiImage: self.eventBGCropped!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.3)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .overlay{
//                                                ImagePickerAndCropper(inputImage: $eventBG, croppedImage: $eventBGCropped, cropSize: CGSize(width: 500, height: 300), imageNameforCropper: "HotelIconUploadCameraIcon", imageIconWidth: UIScreen.screenHeight/40, imageIconHeight: UIScreen.screenHeight/40)
//                                                    .offset(x: UIScreen.screenHeight/8, y: -UIScreen.screenWidth/6)
//
                                            }
                                    } else {
                                        Image("HotelBGIllustration")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenWidth/1.3)
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            .overlay{
//                                                ImagePickerAndCropper(inputImage: $eventBG, croppedImage: $eventBGCropped, cropSize: CGSize(width: 500, height: 300), imageNameforCropper: "HotelIconUploadCameraIcon", imageIconWidth: UIScreen.screenHeight/40, imageIconHeight: UIScreen.screenHeight/40)
//                                                    .offset(x: UIScreen.screenHeight/8, y: -UIScreen.screenWidth/6)
                                                
                                            }
                                    }
                                HStack{
                                    Text("Upload")
                                        .font(.system(size: UIScreen.screenHeight/70))
                                        .fontWeight(.thin)
                                    Image("UploadIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                                }
                                .frame(width: UIScreen.screenWidth/1.4, height: UIScreen.screenHeight/15)
                                .background(communityGreyBG)
                                .cornerRadius(5)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding()
                                
                                Divider()
                            }
                            
                            VStack{
                                //text event start date time
                                
                                Text("Event start and end date & time")
                                    .font(.system(size: UIScreen.screenHeight/70))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                VStack{
                                    //Text starts on
                                    Text("Starts On")
                                        .font(.system(size: UIScreen.screenHeight/50))
                                        .fontWeight(.thin)
                                    
                                    DatePicker(
                                        "Select date",
                                        selection: $eventVM.eventStartDate,
                                        in: ...Date(),
                                        displayedComponents: [.date]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                    
                                    DatePicker(
                                        "Select time",
                                        selection: $eventVM.eventStartTime,
                                        in: ...Date(),
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                }
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/6)
                                .background(eventsBgGrey)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                
                                
                                VStack{
                                    //Text starts on
                                    Text("Ends On")
                                        .font(.system(size: UIScreen.screenHeight/50))
                                        .fontWeight(.thin)
                                    
                                    DatePicker(
                                        "Select date",
                                        selection: $eventVM.eventEndDate,
                                        in: ...Date(),
                                        displayedComponents: [.date]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                    
                                    DatePicker(
                                        "Select time",
                                        selection: $eventVM.eventEndTime,
                                        in: ...Date(),
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                }
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/6)
                                .background(eventsBgGrey)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                
                                Divider()
                            }
                            
                            
                            VStack{
                                //text event start date time
                                
                                Text("Registration start and end date & time")
                                    .font(.system(size: UIScreen.screenHeight/70))
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .padding(.top, UIScreen.screenHeight/50)
                                
                                VStack{
                                    //Text starts on
                                    Text("Starts On")
                                        .font(.system(size: UIScreen.screenHeight/50))
                                        .fontWeight(.thin)
                                    
                                    DatePicker(
                                        "Select date",
                                        selection: $eventVM.eventRegistrationStartDate,
                                        in: ...Date(),
                                        displayedComponents: [.date]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                    
                                    DatePicker(
                                        "Select time",
                                        selection: $eventVM.eventRegistrationStartTime,
                                        in: ...Date(),
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                }
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/6)
                                .background(eventsBgGrey)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                
                                
                                VStack{
                                    //Text starts on
                                    Text("Ends On")
                                        .font(.system(size: UIScreen.screenHeight/50))
                                        .fontWeight(.thin)
                                    
                                    DatePicker(
                                        "Select date",
                                        selection: $eventVM.eventRegistrationEndDate,
                                        in: ...Date(),
                                        displayedComponents: [.date]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                    
                                    DatePicker(
                                        "Select time",
                                        selection: $eventVM.eventRegistrationEndTime,
                                        in: ...Date(),
                                        displayedComponents: [.hourAndMinute]
                                    )
                                    .background(Color.white)
                                    .datePickerStyle(.compact)
                                    .labelsHidden()
                                    .accentColor(greenUi)
                                }
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/6)
                                .background(eventsBgGrey)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                .padding(.horizontal, UIScreen.screenWidth/40)
                                .padding(.vertical, UIScreen.screenHeight/60)
                                
                                Divider()
                            }
                            
                            //post event button
                            Button(action: {
                                eventService.postEvent(loginData: loginData, eventVM: eventVM, eventBG: eventBGCropped)
                                navigateToAllEventView.toggle()
                            }, label: {
                                Text("Post Event")
                                    .font(.system(size: UIScreen.screenHeight/60))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(.vertical, UIScreen.screenHeight/80)
                                    .padding(.horizontal, UIScreen.screenHeight/60)
                                    .background(greenUi)
                                    .cornerRadius(5)
                                    .padding(UIScreen.screenHeight/60)
                                
                            })
                            .navigationDestination(isPresented: $navigateToAllEventView, destination: {
                                AllEventsFPPView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                            })
                        }
                    }
                }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct EventThirdDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventThirdDetailsView()
//    }
//}
