//
//  PopularInTheirFieldCard.swift
//  R-own
//
//  Created by Aman Sharma on 09/06/23.
//

import SwiftUI

struct PopularInTheirFieldCard: View {
    
    @State var jobProfile: RequestedUsersModel
    
    var body: some View {
        ZStack{
            VStack{
                VStack{
                    HStack{
                        VStack(alignment: .leading){
                            Text(jobProfile.fullName ?? "Fetching Name")
                                .font(.system(size: UIScreen.screenHeight/60))
                                .fontWeight(.regular)
                                .padding(.top, UIScreen.screenHeight/30)
                            Text(jobProfile.designationType)
                                .font(.system(size: UIScreen.screenHeight/110))
                                .fontWeight(.regular)
                            Text("Experience")
                                .font(.system(size: UIScreen.screenHeight/110))
                                .fontWeight(.regular)
                            Text(jobProfile.employmentType)
                                .font(.system(size: UIScreen.screenHeight/110))
                                .fontWeight(.regular)
                            Text(jobProfile.location ?? "Fetching Location")
                                .font(.system(size: UIScreen.screenHeight/110))
                                .fontWeight(.regular)
                        }
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Looking for")
                                .font(.system(size: UIScreen.screenHeight/70))
                                .fontWeight(.regular)
                                .foregroundColor(jobsBrightGreen)
                            Text(jobProfile.designationType)
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                            Text(jobProfile.department)
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                            Text("")
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                            Text(jobProfile.preferredLocation)
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                            Text(jobProfile.noticePeriod)
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                            Text(jobProfile.expectedCTC)
                                .font(.system(size: UIScreen.screenHeight/100))
                                .fontWeight(.regular)
                        }
                    }
                    .padding(.horizontal, UIScreen.screenWidth/50)
                    Button(action: {
                        
                    }, label: {
                        Text("View Profile")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .fontWeight(.thin)
                            .foregroundColor(.black)
                            .padding(.horizontal, UIScreen.screenWidth/7)
                            .padding(.vertical, UIScreen.screenHeight/80)
                            .background(jobsBrightGreen)
                            .padding(5)
                            .cornerRadius(15)
                    })
                    
                }
                .frame(width: UIScreen.screenWidth/2.5, height: UIScreen.screenHeight/6)
                .padding(10)
                .background(jobsCardLightGrey)
                .cornerRadius(15)
                .padding(30)
            }
            
            ProfilePictureView(profilePic: jobProfile.profilePic ?? "", verified: false, height: UIScreen.screenHeight/15, width: UIScreen.screenHeight/15)
                .offset(x: -UIScreen.screenWidth/9, y: -UIScreen.screenHeight/11)
        }
    }
}

//struct PopularInTheirFieldCard_Previews: PreviewProvider {
//    static var previews: some View {
//        PopularInTheirFieldCard()
//    }
//}
