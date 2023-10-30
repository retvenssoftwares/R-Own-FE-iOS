//
//  ProfileReportView.swift
//  R-own
//
//  Created by Aman Sharma on 26/07/23.
//

import SwiftUI
import AlertToast

struct ProfileReportView: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    
    @State var openBottomSheet: Bool = false
    
    @StateObject var mainUserService = MainUserService()
    
    @State var reportReason: String = ""
    @State var reportedUseriD: String = ""
    
    @State var alertReport: Bool = false
    @State var alertFailure: Bool = false
    
    var body: some View {
        VStack{
            BasicNavbarView(navbarTitle: "Report")
            VStack{
                Text("What do you want to report ?")
                    .font(.body)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .frame(width: UIScreen.screenWidth/1.3)
                    .padding(.vertical, UIScreen.screenHeight/70)
                
                VStack(alignment: .leading, spacing: UIScreen.screenHeight/80){
                    Text("It's important to know that your report is anonymous, except for cases of intellectual property infringement. If you are reporting such an infringement, we may need to share your identity with the relevant parties.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.screenWidth/1.1)
                    Text("Also, if someone is in immediate danger, call the local emergency services immediately. Don't wait or hesitate. Your safety and the safety of others should always be the top priority.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.screenWidth/1.1)
                    Text("Thank you for choosing to report any concerns or issues you may have. We take all reports seriously and will do our best to address them promptly.")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .frame(width: UIScreen.screenWidth/1.1)
                }
                VStack{
                    Button(action: {
                        openBottomSheet.toggle()
                    }, label: {
                        Text("Something is wrong with the profile")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            .padding(.vertical, UIScreen.screenHeight/60)
                        
                    })
                    Divider()
                }
                .sheet(isPresented: $openBottomSheet, content: {
                    VStack{
                        Text("Select your reason to report")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/70)
                            .frame(width: UIScreen.screenWidth/1.3)
                        
                        VStack(spacing: UIScreen.screenHeight/80){
                            Text("It's important to know that your report is anonymous, except for cases of intellectual property infringement. If you are reporting such an infringement, we may need to share your identity with the relevant parties.")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/1.1)
                                .padding(.horizontal, UIScreen.screenWidth/20)
                            Text("Also, if someone is in immediate danger, call the local emergency services immediately. Don't wait or hesitate. Your safety and the safety of others should always be the top priority.")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/1.1)
                                .padding(.horizontal, UIScreen.screenWidth/20)
                            Text("Thank you for choosing to report any concerns or issues you may have. We take all reports seriously and will do our best to address them promptly")
                                .font(.body)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/1.1)
                                .padding(.horizontal, UIScreen.screenWidth/20)
                        }
                        ScrollView{
                            VStack(alignment: .leading){
                                VStack{
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "It’s spam"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("It’s spam")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "I just don’t like it"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("I just don’t like it")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Suicide, self-injury or eating disorders"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Suicide, self-injury or eating disorders")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Sale of illegal or regulated goods"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Sale of illegal or regulated goods")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Interior Nudity or sexual activity"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Interior Nudity or sexual activity")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                }
                                VStack{
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Hate speech or symbols"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Hate speech or symbols")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Violence or dangerous orgnaisations"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Violence or dangerous orgnaisations")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Bullying or harassment"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Bullying or harassment")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Intellectual property violation"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Intellectual property violation")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                    HStack{
                                        Button(action: {
                                            Task{
                                                reportReason = "Scam or fraud"
                                                let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                                if res == "Success"{
                                                    openBottomSheet.toggle()
                                                    alertReport = true
                                                } else {
                                                    alertFailure = true
                                                }
                                            }
                                        }, label: {
                                            Text("Scam or fraud")
                                                .font(.body)
                                                .foregroundColor(.black)
                                                .padding(.vertical, UIScreen.screenHeight/90)
                                                .frame(width: UIScreen.screenWidth)
                                        })
                                        Spacer()
                                    }
                                    Divider()
                                }
                                HStack{
                                    Button(action: {
                                        Task{
                                            reportReason = "False Information"
                                            let res = await mainUserService.reportUser(reportType: "Profile Report", reporterUserID: loginData.mainUserID, reportedUserID: reportedUseriD, postID: "", reason: reportReason)
                                            if res == "Success"{
                                                openBottomSheet.toggle()
                                                alertReport = true
                                            } else {
                                                alertFailure = true
                                            }
                                        }
                                    }, label: {
                                        Text("False Information")
                                            .font(.body)
                                            .foregroundColor(.black)
                                            .padding(.vertical, UIScreen.screenHeight/90)
                                            .frame(width: UIScreen.screenWidth)
                                    })
                                    Spacer()
                                }
                                Divider()
                            }
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        }
                        Spacer()
                    }
                })
            }
            .toast(isPresenting: $alertFailure, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Try Again")
            }
            .toast(isPresenting: $alertReport, duration: 2, tapToDismiss: true){
                AlertToast( type: .systemImage("checkmark.square.fill", greenUi), title: "Reported")
            }
            Spacer()
        }
        .onAppear{
            if globalVM.viewingUserRole == "Normal User"{
                reportedUseriD = globalVM.viewingNormalUserID
            } else if globalVM.viewingUserRole == "VEndor"{
                reportedUseriD = globalVM.viewingVendorUserID
            } else if globalVM.viewingUserRole == "Hotel Owner"{
                reportedUseriD = globalVM.viewingHotelOwnerUserID
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

//struct ProfileReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileReportView()
//    }
//}
