//
//  EditEventView.swift
//  R-own
//
//  Created by Aman Sharma on 12/06/23.
//

import SwiftUI

struct EditEventView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var eventVM: EventViewModel
    @State var eventID: String
    
    @StateObject var hotelService = HotelService()
    @StateObject var eventService = UserEventService()
    @State var openEventCategoryBottomSHeeet: Bool = false
    
    @State var eventBG: UIImage = UIImage(named: "demo") ??  UIImage(named: "HotelBGIllustration")!
    @State var eventBGCropped: UIImage?
    
    
    @FocusState private var isKeyboardShowing: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Edit Your Event")
                ScrollView{
                    VStack{
                        VStack{
                            
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
                                            }
                                    } else {
                                        AsyncImage(url: URL(string: globalVM.eventDetailsByEventIDForEdit[0].eventThumbnail)) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: UIScreen.screenWidth/1.3)
                                                .padding(.vertical, UIScreen.screenHeight/30)
                                                .overlay{
//                                                    ImagePickerAndCropper(inputImage: $eventBG, croppedImage: $eventBGCropped, cropSize: CGSize(width: 500, height: 300), imageNameforCropper: "HotelIconUploadCameraIcon", imageIconWidth: UIScreen.screenHeight/40, imageIconHeight: UIScreen.screenHeight/40)
//                                                        .offset(x: UIScreen.screenHeight/8, y: -UIScreen.screenWidth/6)
                                                    
                                                }
                                        } placeholder: {
                                            Rectangle()
                                                .fill(lightGreyUi)
                                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/3)
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
                                //location text
                                Text("Your venue location")
                                    .font(.system(size: UIScreen.screenHeight/55))
                                    .fontWeight(.regular)
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                
                                //location field
                                Button(action: {
                                    loginData.mainLocationBottomSheet.toggle()
                                }, label: {
                                    TextField("Select Venue Location", text: $globalVM.eventDetailsByEventIDForEdit[0].location)
                                        .disabled(true)
                                        .padding()
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Location")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                            
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                })
                            }
                            
                            VStack{
                                //venue text
                                Text("Enter the name of your venue")
                                    .font(.system(size: UIScreen.screenHeight/55))
                                    .fontWeight(.regular)
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                
                                //venue field
                                
                                Button(action: {
                                    hotelService.getHotelsByUserID(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID, viewerID: loginData.mainUserID)
                                    eventVM.showVenueBottomSheet.toggle()
                                }, label: {
                                    TextField("Select the name of your venue here", text: $globalVM.eventDetailsByEventIDForEdit[0].venue)
                                        .disabled(true)
                                        .padding()
                                        .cornerRadius(7)
                                        .overlay{
                                            // apply a rounded border
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(.gray, lineWidth: 0.5)
                                            Text("Venue")
                                                .font(.system( size: 14))
                                                .foregroundColor(.black)
                                                .background(Color.white)
                                                .padding(.horizontal,5)
                                                .fontWeight(.ultraLight)
                                                .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                            
                                        }
                                        .padding(.vertical, UIScreen.screenHeight/50)
                                        .padding(.horizontal, UIScreen.screenWidth/30)
                                })
                            }
                        }
                        
                        VStack{
                            //text
                            Text("Please enter the details about your event")
                                .font(.system(size: UIScreen.screenHeight/55))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.vertical, UIScreen.screenHeight/20)
                            
                            //event title field
                            TextField("Enter title here..", text: $globalVM.eventDetailsByEventIDForEdit[0].eventTitle)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Event Title")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .frame(width: UIScreen.screenWidth/1.2)
                            
                            Text("Event Description")
                                .font(.system(size: UIScreen.screenHeight/55))
                                .fontWeight(.regular)
                                .padding(.vertical, UIScreen.screenHeight/40)
                            
                            //event description field
                            TextEditor(text: $globalVM.eventDetailsByEventIDForEdit[0].eventDescription)
                                .frame(width: UIScreen.screenWidth/1.3, height: UIScreen.screenHeight/4)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                        .frame(width: UIScreen.screenWidth/1.2, height: UIScreen.screenHeight/3.7)
                                }
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            Text("Event Category")
                                .font(.system(size: UIScreen.screenHeight/55))
                                .fontWeight(.regular)
                                .padding(.vertical, UIScreen.screenHeight/40)
                            
                            
                            //event title field
                            TextField("Enter title here..", text: $globalVM.eventDetailsByEventIDForEdit[0].eventCategory)
                                .disabled(true)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Event Title")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .frame(width: UIScreen.screenWidth/1.2)
                                .onTapGesture {
                                    eventService.getEventCategory(globalVM: globalVM, loginData: loginData, userID: loginData.mainUserID)
                                    openEventCategoryBottomSHeeet.toggle()
                                }
                            
                        }
                        
                        VStack{
                            //text
                            Text("Please enter the details about your event")
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                            
                            //price email field
                            TextField("Enter event price here..", text: $globalVM.eventDetailsByEventIDForEdit[0].price)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Event Ticket Price")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //support email field
                            TextField("Enter support email here..", text: $globalVM.eventDetailsByEventIDForEdit[0].email)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Support Email")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Phone number field
                            TextField("Enter phone number here..", text: $globalVM.eventDetailsByEventIDForEdit[0].phone)
                                .padding()
                                .cornerRadius(7)
                                .keyboardType(.numberPad)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Phone No.")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Website field
                            TextField("Enter website here..", text: $globalVM.eventDetailsByEventIDForEdit[0].websiteLink)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Website")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
                            
                            //Booking Link field
                            TextField("Enter booking link here..", text: $globalVM.eventDetailsByEventIDForEdit[0].bookingLink)
                                .padding()
                                .cornerRadius(7)
                                .overlay{
                                    // apply a rounded border
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.gray, lineWidth: 0.5)
                                    Text("Booking Link")
                                        .font(.system( size: 14))
                                        .foregroundColor(.black)
                                        .background(Color.white)
                                        .padding(.horizontal,5)
                                        .fontWeight(.ultraLight)
                                        .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                    
                                }
                                .focused($isKeyboardShowing)
                                .padding(.vertical, UIScreen.screenHeight/50)
                                .padding(.horizontal, UIScreen.screenWidth/30)
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
                            dismiss()
                        }, label: {
                            Text("Update Event")
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.vertical, UIScreen.screenHeight/80)
                                .padding(.horizontal, UIScreen.screenHeight/60)
                                .background(greenUi)
                                .cornerRadius(5)
                                .padding(UIScreen.screenHeight/60)
                            
                        })
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear{
            eventService.getEventInfoByEventIDForEdit(globalVM: globalVM, loginData: loginData, eventID: eventID)
        }
    }
    
    func convertToDate() {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        
    }
    
    func convertToTime() {
        
        var timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        timeFormatter.locale = Locale.init(identifier: "en_GB")
    }
}

//struct EditEventView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditEventView()
//    }
//}
