//
//  NotificationSecondHalfView.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI

struct NotificationSecondHalfView: View {
    
    @StateObject var notificationVM: NotificationViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var notificationService = NotificationService()
    
    var body: some View {
            HStack{
                
                Spacer()
                
                Button(action: {
                    notificationVM.notificationCategorySelected = "Personal"
                }, label: {
                    if notificationVM.notificationCategorySelected == "Personal" {
                        Text("Personal")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(greenUi)
                            .border(greenUi)
                            .cornerRadius(10)
                    } else {
                        Text("Personal")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                })
                
                Spacer()
                
                if loginData.isHiddenKPI{
                    Button(action: {
                        notificationVM.notificationCategorySelected = "Community"
                    }, label: {
                        if notificationVM.notificationCategorySelected == "Community" {
                            Text("Community")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(greenUi)
                                .border(greenUi)
                                .cornerRadius(10)
                        } else {
                            Text("Community")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                )
                        }
                    })
                }
                
                Spacer()
                
                Button(action: {
                    notificationVM.notificationCategorySelected = "Connections"
                }, label: {
                    if notificationVM.notificationCategorySelected == "Connections" {
                        Text("Connections")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(greenUi)
                            .border(greenUi)
                            .cornerRadius(10)
                    } else {
                        Text("Connections")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding()
                            .background(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1)
                            )
                    }
                })
                Spacer()
                
                if loginData.isHiddenKPI{
                    Button(action: {
                        notificationVM.notificationCategorySelected = "Suggestions"
                    }, label: {
                        if notificationVM.notificationCategorySelected == "Suggestions" {
                            Text("Suggestions")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(greenUi)
                                .border(greenUi)
                                .cornerRadius(10)
                        } else {
                            Text("Suggestions")
                                .font(.body)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                )
                        }
                    })
                    
                    Spacer()
                }
        }
        .padding(.vertical, UIScreen.screenHeight/50)
    }
}

//struct NotificationSecondHalfView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationSecondHalfView()
//    }
//}
