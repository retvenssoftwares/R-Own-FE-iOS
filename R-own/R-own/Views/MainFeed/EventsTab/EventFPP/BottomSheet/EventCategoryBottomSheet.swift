//
//  EventCategoryBottomSheet.swift
//  R-own
//
//  Created by Aman Sharma on 08/06/23.
//

import SwiftUI

struct EventCategoryBottomSheet: View {
    
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    @Binding var bottomSheetToggle: Bool
    @StateObject var globalVM: GlobalViewModel
    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
            VStack{
                Spacer()
                VStack(spacing: 12){
                    Capsule()
                        .fill(Color.gray)
                        .frame(width:60, height: 4)
                        
                    VStack(alignment: .leading, spacing: 20){
                        Text("Select event category:")
                            .font(.system(size: UIScreen.screenHeight/60))
                            .fontWeight(.bold)
                            .padding(.vertical, UIScreen.screenHeight/60)
                        
                        ScrollView{
                            if globalVM.eventCategoryList.count > 0 {
                                ForEach(0..<globalVM.eventCategoryList.count, id: \.self){ count in
                                    VStack{
                                        Button(action: {
                                            eventVM.eventCategory = globalVM.eventCategoryList[count].categoryName
                                            eventVM.eventCategoryID = globalVM.eventCategoryList[count].categoryID
                                            bottomSheetToggle.toggle()
                                            
                                        }, label: {
                                            Text(globalVM.eventCategoryList[count].categoryName)
                                                .font(.system(size: UIScreen.screenHeight/80))
                                                .padding(.vertical, UIScreen.screenHeight/70)
                                                .foregroundColor(.black)
                                        })
                                        
                                        Divider()
                                    }
                                }
                            } else {
                                Text("No category available right now!")
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
                .offset(y: bottomSheetToggle ? 0 : UIScreen.main.bounds.height)
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(bottomSheetToggle ? 0.3 : 0).ignoresSafeArea()
                .onTapGesture {
                    withAnimation{
                        bottomSheetToggle.toggle()
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
                    bottomSheetToggle.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//
//struct EventCategoryBottomSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        EventCategoryBottomSheet()
//    }
//}
