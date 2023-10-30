//
//  SyncContactsView.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import Contacts
import AlertToast

struct SyncContactsView: View {
    
    @State var contactsSynced: Bool = false
    @State var navigateToMainFeed: Bool = false
    @StateObject var loginData: LoginViewModel
    @StateObject var globalVM: GlobalViewModel
    @StateObject var contactVM = ContactsViewModel()
    
    @State var openAgreementBS: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack {
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: UIScreen.screenHeight/70){
                        VStack(alignment: .leading){
                            Text("Contacts")
                                .foregroundColor(.black)
                                .padding(.top, UIScreen.screenHeight/1.7)
                                .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                .font(.title3)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                            
                            Text("Stay connected with ease, sync your contacts now!")
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                .font(.body)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                            Text(loginData.contactsText)
                                .foregroundColor(.black)
                                .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                .font(.body)
                                .fontWeight(.light)
                                .multilineTextAlignment(.leading)
                            if loginData.contactsText != "" {
                                Button(action: {
                                    openAgreementBS.toggle()
                                }, label: {
                                    Text("Why are we collecting contacts?")
                                        .font(.body)
                                        .foregroundColor(.blue)
                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                        .fontWeight(.light)
                                        .padding(.vertical, UIScreen.screenHeight/80)
                                })
                                .sheet(isPresented: $openAgreementBS, content: {
                                    ScrollView {
                                        VStack {
                                            HStack{
                                                Spacer()
                                                Text("Upload Contacts Consent")
                                                    .foregroundColor(.black)
                                                    .frame(width: UIScreen.screenWidth)
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                                    .multilineTextAlignment(.leading)
                                                Spacer()
                                            }
                                            .padding(.vertical, UIScreen.screenHeight/30)
                                            VStack(alignment: .leading){
                                                VStack(alignment: .leading){
                                                    
                                                    Text("Dear \(loginData.mainUserFullName),")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    
                                                    Text("At R-Own, we believe in providing you with the best experience while ensuring your privacy and data security. To enhance your experience and offer valuable features, we would like to request your consent to upload your contacts to our secure servers.")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.regular)
                                                        .multilineTextAlignment(.leading)
                                                    
                                                    Text("Why do we need your contacts? Uploading your contacts allows us to:")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    VStack{
                                                        Text("1. Help you connect with your friends and colleagues who are already using R-Own.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                        Text("2. Provide a seamless experience when you invite friends to join you on our platform.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                        Text("3. Suggest relevant connections and content to enrich your experience.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                    }
                                                    .padding(.leading, UIScreen.screenWidth/30)
                                                }
                                                VStack(alignment: .leading){
                                                    
                                                    Text("Your privacy matters:")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.medium)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    VStack{
                                                        Text("1. Security: Your contacts are securely stored and encrypted on our servers.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                        Text("2. Usage: We will never share your contacts with third parties without your explicit permission.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                        Text("3. Control: You can manage your uploaded contacts and revoke access at any time in your account settings.")
                                                            .foregroundColor(.black)
                                                            .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                            .font(.body)
                                                            .fontWeight(.regular)
                                                            .multilineTextAlignment(.leading)
                                                    }
                                                    .padding(.leading, UIScreen.screenWidth/30)
                                                    Text("Your consent, your choice:")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.bold)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    Text("By pressing the \"Upload Contacts Now\" button below, you grant us permission to upload and securely store your contacts. Rest assured, your data's security is our top priority.")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.light)
                                                        .multilineTextAlignment(.leading)
                                                }
                                                VStack(alignment: .leading){
                                                    Text("If you have any questions or concerns about how we handle your data, please review our Privacy Policy (https://www.r-own.com/privacy-policy) or contact our support team at rown@retvensservices.com")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.light)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    Text("Thank you for choosing R-Own! Your trust and confidence are greatly appreciated.")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.light)
                                                        .multilineTextAlignment(.leading)
                                                        .padding(.vertical, UIScreen.screenHeight/80)
                                                    Text("Best regards,")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.light)
                                                    Text("R-Own Team")
                                                        .foregroundColor(.black)
                                                        .frame(width: UIScreen.screenWidth/1.5, alignment: .leading)
                                                        .font(.body)
                                                        .fontWeight(.light)
                                                        .multilineTextAlignment(.leading)
                                                }
                                                Spacer()
                                            }
                                            .padding(.leading, UIScreen.screenWidth/30)
                                        }
                                    }
                                })
                            }
                        }
                        HStack(spacing: UIScreen.screenWidth/30){
                            Button(action: {
                                loginData.loginStatusFinal = true
                            }, label: {
                                Text("Next")
                                    .foregroundColor(greenUi)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, UIScreen.screenWidth/15)
                                    .overlay{
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(lineWidth: 1)
                                            .foregroundColor(greenUi)
                                    }
                                    .padding(.bottom, 20)
                            })
                            Button(action: {
                                Task {
                                    let res = await contactVM.fetchContactsFromPhone(loginData: loginData, globalVM: globalVM)
                                    if res == "Success Uploaded" {
                                        loginData.contactsSettingInfo.toggle()
                                        loginData.showLoader = true
                                    } else if res == "Sucessfully Fetched" {
                                        loginData.contactsSettingInfo.toggle()
                                    } else if res == "Failure" {
                                        loginData.contactsUploadDenied.toggle()
                                    }
                                }
                            }, label: {
                                Text("Continue")
                                    .foregroundColor(greenUi)
                                    .font(.body)
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, UIScreen.screenWidth/15)
                                    .background(jobsDarkBlue)
                                    .cornerRadius(10, corners: .allCorners)
                                    .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
                                    .padding(.bottom, 20)
                            })
                            Spacer()
                        }
                        .frame(width: UIScreen.screenWidth/1.5)
                    }
                    Spacer(minLength: UIScreen.screenHeight/7)
                }
                .frame(height: UIScreen.screenHeight, alignment: .topLeading)
                .background(
                    VStack{
                        Image("UploadContacts")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenWidth)
                        Spacer()
                    }
                        .offset(y: -UIScreen.screenHeight/80)
            )
                RownLoaderView(loginData: loginData)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .toast(isPresenting: $loginData.contactsUploadDenied, duration: 2, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Upload unavailable", subTitle: ("Contacts upload denied, try giving access in setting!"))
        }
        .toast(isPresenting: $loginData.contactsSettingInfo, duration: 4, tapToDismiss: true){
            AlertToast( type: .systemImage("exclamationmark.triangle.fill", .red), title: "Upload unavailable", subTitle: ("Give permission of contacts from setting to upload again"))
        }
    }
}


