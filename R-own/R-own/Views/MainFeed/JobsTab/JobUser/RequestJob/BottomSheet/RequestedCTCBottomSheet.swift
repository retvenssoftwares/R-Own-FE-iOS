//
//  RequestedCTCBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/05/23.
//

import SwiftUI

struct RequestedCTCBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var jobsVM: JobsViewModel
    
    @State var ctcSearch: String = ""
        
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                        VStack(spacing: 20){
                            Text("Expected CTC?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Select one -")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    VStack{
                                        Text("1-3 Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = "1-3 Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("3-6 Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = "3-6 Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("6-10 Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = "6-10 Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("10-15  Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = "10-15  Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text("15-25 Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = "15-25 Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                    VStack{
                                        Text(">25 Lakhs/p.a")
                                            .padding(.vertical, UIScreen.screenHeight/60)
                                            .onTapGesture{
                                                jobsVM.expectedCTCRequestedFor = ">25 Lakhs/p.a"
                                                jobsVM.requestedCTCBottomSheet = false
                                            }
                                        Divider()
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/1.5)
                }
                .padding(.top)
                .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                .offset(y: offset)
                .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                .offset(y: jobsVM.requestedCTCBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.requestedCTCBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.requestedCTCBottomSheet.toggle()
                    }
                }
            )
    }
    func onChanged(value: DragGesture.Value){
        if value.translation.height > 0{
            offset = value.translation.height
        }
    }
    
    func onEnded(value: DragGesture.Value){
        if value.translation.height > 0{
            withAnimation(Animation.easeInOut(duration: 0.2)){
                
                //onChecking
                
                let height = UIScreen.screenHeight/3
                
                if value.translation.height > height/1.5 {
                    jobsVM.requestedCTCBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct RequestedCTCBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        RequestedCTCBottomSheet()
//    }
//}
