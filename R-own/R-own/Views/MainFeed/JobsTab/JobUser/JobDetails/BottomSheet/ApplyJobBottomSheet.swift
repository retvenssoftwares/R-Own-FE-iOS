//
//  ApplyJobBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 09/05/23.
//

import SwiftUI

struct ApplyJobBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    @State var serviceSearch: String = ""
    @State var serviceSelected: Bool = false
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @FocusState private var isKeyboardShowing: Bool
    
    @State var offset : CGFloat = 0
    
    @State var fileName = "no file chosen"
    @State var openFile = false
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading){
                        Text("Please, verify and enter all the details for applying for this job")
                            .font(.system(size: UIScreen.screenHeight/70))
                            .multilineTextAlignment(.leading)
                            .fontWeight(.bold)
                            .padding(.bottom, UIScreen.screenHeight/40)
                        
                        TextField("Enter Full Name", text: $loginData.mainUserFullName)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Full Name")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        TextField("Your Experience", text: $jobsVM.jobLocationRequestedFor)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Experience")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                
                            }
                            .focused($isKeyboardShowing)
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
                        TextField("Select a File", text: $fileName)
                            .disabled(true)
                            .padding()
                            .cornerRadius(7)
                            .overlay{
                                // apply a rounded border
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.gray, lineWidth: 0.5)
                                Text("Attach Your Resume")
                                    .font(.system( size: 14))
                                    .foregroundColor(.black)
                                    .padding(.horizontal,5)
                                    .fontWeight(.ultraLight)
                                    .offset(x: -UIScreen.screenWidth/3.2, y: -27)
                                Image(systemName: "paperclip")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                    .offset(x: UIScreen.screenWidth/2.8)
                            }
                            .padding(.vertical, UIScreen.screenHeight/50)
                            .padding(.horizontal, UIScreen.screenWidth/30)
//                            .onTapGesture {
//                                openFile.toggle()
//                            }
//                            .fileImporter( isPresented: $openFile, allowedContentTypes: [.pdf], allowsMultipleSelection: false, onCompletion: {
//                                (Result) in
//
//                                do{
//                                    let fileURL = try Result.get()
//                                    print(fileURL)
//                                    fileName = fileURL.first?.lastPathComponent ?? "file not available"
//
//                                }
//                                catch{
//                                   print("error reading file \(error.localizedDescription)")
//                                }
//
//                            })
                        
                        //button post
                        HStack{
                            Spacer()
                            Button(action: {
                                jobsVM.jobApplied.toggle()
                                jobsVM.applyJobBottomSheet = false
                            }) {
                                Text("Apply Now")
                                    .foregroundColor(.black)
                                    .font(.system(size: UIScreen.screenHeight/70))
                                    .fontWeight(.bold)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, UIScreen.screenWidth/7)
                                    .background(greenUi)
                            }
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
                            .padding(.horizontal, UIScreen.screenHeight/40)
                            .padding(.vertical, UIScreen.screenHeight/40)
                            Spacer()
                        }
                        .padding(.top, UIScreen.screenHeight/50)
                    }
                    .padding(.horizontal, UIScreen.screenWidth/40)
                    .padding(.bottom, UIScreen.screenHeight/10)
                    .padding(.bottom,edges?.bottom)
                    .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.7)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .offset(y: jobsVM.applyJobBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.applyJobBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.applyJobBottomSheet.toggle()
                    }
                }
            )
    }
}

//struct ApplyJobBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ApplyJobBottomSheet()
//    }
//}
