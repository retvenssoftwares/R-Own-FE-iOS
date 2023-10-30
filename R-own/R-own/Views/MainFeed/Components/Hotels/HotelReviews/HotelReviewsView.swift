//
//  HotelReviewsView.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct HotelReviewsView: View {
    
    @State var hotelID: String
    
    var body: some View {
        NavigationStack{
            VStack{
                BasicNavbarView(navbarTitle: "Review")
                ScrollView{
                    VStack{
                        VStack{
                            HStack{
                                Image("ReviewStar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/30, height: UIScreen.screenHeight/30)
                                VStack(alignment: .leading, spacing: 5){
                                    Text("Rate 3.0")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.semibold)
                                    Text("3.2K review and ratings")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .fontWeight(.thin)
                                }
                                Spacer()
                            }
                            .padding(.horizontal, UIScreen.screenWidth/20)
                            .padding(.vertical, UIScreen.screenHeight/30)
                            .background(.white)
                            .frame(width: UIScreen.screenWidth/1.3)
                            .overlay{
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lightGreyUi, lineWidth: 1)
                            }
                            .padding(.vertical, UIScreen.screenHeight/60)
                            
                            HStack(spacing: 10){
                                VStack{
                                    Image("ReviewStar")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    Text("Great Behaviour")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("1.5K review and ratings")
                                        .font(.body)
                                        .fontWeight(.thin)
                                }
                                .padding(.horizontal, UIScreen.screenWidth/20)
                                .padding(.vertical, UIScreen.screenHeight/30)
                                .background(.white)
                                .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lightGreyUi, lineWidth: 1)
                                }
                                VStack{
                                    Image("ReviewTime")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    Text("Attentive staff")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("1.5K review and ratings")
                                        .font(.body)
                                        .fontWeight(.thin)
                                }
                                .padding(.horizontal, UIScreen.screenWidth/20)
                                .padding(.vertical, UIScreen.screenHeight/30)
                                .background(.white)
                                .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lightGreyUi, lineWidth: 1)
                                }
                                VStack{
                                    Image("ReviewMoney")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIScreen.screenHeight/20, height: UIScreen.screenHeight/20)
                                    Text("Worth the money")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("1.5K review and ratings")
                                        .font(.body)
                                        .fontWeight(.thin)
                                }
                                .padding(.horizontal, UIScreen.screenWidth/20)
                                .padding(.vertical, UIScreen.screenHeight/30)
                                .background(.white)
                                .frame(width: UIScreen.screenHeight/5, height: UIScreen.screenHeight/5)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(lightGreyUi, lineWidth: 1)
                                }
                            }
                            
                            HStack{
                                Text("All Reviews")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    
                                Spacer()
                            }
                            .padding(.leading, UIScreen.screenWidth/10)
                            .padding(.top, UIScreen.screenHeight/30)
                            
                            VStack{
                                ForEach(0...5, id: \.self){ count in
                                    
                                    HStack(spacing: UIScreen.screenWidth/30){
                                        VStack{
                                            ProfilePictureView(profilePic: "", verified: false, height: UIScreen.screenHeight/20, width: UIScreen.screenHeight/20)
                                            Spacer()
                                        }
                                        VStack(alignment: .leading){
                                            Text("User Name")
                                                .font(.body)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, UIScreen.screenHeight/70)
                                            Text("Ordered on 28 June 2021")
                                                .font(.body)
                                                .fontWeight(.thin)
                                            Text("I received the works before the deadline. Totally satisfied..!!")
                                                .font(.body)
                                                .fontWeight(.regular)
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                            Button(action: {
                                                
                                            }, label: {
                                                Text("FollowUp with guest")
                                                    .font(.body)
                                                    .foregroundColor(.white)
                                                    .fontWeight(.bold)
                                                    .padding(.horizontal, UIScreen.screenWidth/40)
                                                    .padding(.vertical, UIScreen.screenHeight/60)
                                                    .background(greenUi)
                                                    .cornerRadius(15)
                                            })
                                            .padding(.vertical, UIScreen.screenHeight/70)
                                        }
                                        VStack{
                                            HStack{
                                                Image("FeedStaysStarFilled")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: UIScreen.screenHeight/60, height: UIScreen.screenHeight/60)
                                                Text("4.6")
                                                    .font(.body)
                                                    .fontWeight(.regular)
                                                    .foregroundColor(.black)
                                            }
                                            Spacer()
                                        }
                                    }
                                    .padding(.horizontal, UIScreen.screenWidth/10)
                                    .padding(.vertical, UIScreen.screenHeight/40)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(greyUi, lineWidth: 1 )
                                    }
                                    
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//struct HotelReviewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        HotelReviewsView()
//    }
//}
