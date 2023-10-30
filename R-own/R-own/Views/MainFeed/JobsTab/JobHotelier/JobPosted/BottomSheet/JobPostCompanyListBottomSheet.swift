//
//  JobPostCompanyListBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 10/06/23.
//

import SwiftUI

struct JobPostCompanyListBottomSheet: View {
    @StateObject var globalVM: GlobalViewModel
    @StateObject var jobsVM: JobsViewModel
    @Binding var hotelName: String
    @Binding var hotelID: String
    @State var hotelTitleSearch: String = ""
    
    @FocusState private var isKeyboardShowing: Bool
    
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
                            Text("Select your company ?")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            Text("Search your company below")
                                .foregroundColor(.black)
                                .font(.system(size: UIScreen.screenHeight/40))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .padding(.top,30)
                            
                            TextField("Search Company Name", text: $hotelTitleSearch)
                                .font(.system(size: 14))
                                .frame(width: UIScreen.screenWidth/1.2)
                                .overlay(alignment: .trailing, content: {
                                    Image(systemName: "magnifyingglass")
                                })
                                .focused($isKeyboardShowing)
                                .padding()
                                .border(.black.opacity(0.5))
                            
                            
                            //Location Array
                            ScrollView{
                                VStack(alignment: .leading){
                                    if globalVM.hotelListByID.count > 0 {
                                        ForEach(0..<globalVM.hotelListByID.count, id: \.self){ count in
                                            VStack{
                                                Text(globalVM.hotelListByID[count].hotelName)
                                                    .padding(.vertical, UIScreen.screenHeight/40)
                                                    .onTapGesture{
                                                        hotelName = globalVM.hotelListByID[count].hotelName
                                                        hotelID = globalVM.hotelListByID[count].hotelID
                                                        jobsVM.showCompanyNameBottomSheet = false
                                                    }
                                                Divider()
                                            }
                                        }
                                        
                                    } else {
                                        Text("You havent posted any hotel yet")
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
                .offset(y: jobsVM.showCompanyNameBottomSheet ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(jobsVM.showCompanyNameBottomSheet ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        jobsVM.showCompanyNameBottomSheet.toggle()
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
                    jobsVM.showCompanyNameBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}

//struct JobPostCompanyListBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        JobPostCompanyListBottomSheet()
//    }
//}
