//
//  EventAddBottomSheetView.swift
//  R-own
//
//  Created by Aman Sharma on 18/05/23.
//

import SwiftUI

struct EventAddBottomSheetView: View {
    
    @StateObject var globalVM: GlobalViewModel
    @StateObject var loginData: LoginViewModel
    @StateObject var eventVM: EventViewModel
    
    @State var navigateToAddEventScreen: Bool = false
    @State var navigateToMyEventsScreen: Bool = false

    
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    @State var offset : CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack{
                    Spacer()
                    VStack(spacing: 12){
                        Capsule()
                            .fill(Color.gray)
                            .frame(width:60, height: 4)
                            
                        VStack(alignment: .leading, spacing: 20){
                            VStack(alignment: .leading){
                                Button(action: {
                                    navigateToAddEventScreen.toggle()
                                }, label: {
                                    HStack{
                                        Image("EditPenIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        Text("Add an event")
                                            .font(.system(size: UIScreen.screenHeight/60))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/30)
                                })
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/60)
                                .navigationDestination(isPresented: $navigateToAddEventScreen, destination: {
                                    CreateEventView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                                })
                                Divider()
                            }
                            VStack(alignment: .leading){
                                Button(action: {
                                    navigateToMyEventsScreen.toggle()
                                }, label: {
                                    HStack{
                                        Image("EventCalanderIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIScreen.screenHeight/50, height: UIScreen.screenHeight/50)
                                        Text("My events")
                                            .font(.system(size: UIScreen.screenHeight/60))
                                            .foregroundColor(.black)
                                    }
                                    .padding(.vertical, UIScreen.screenHeight/30)
                                })
                                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight/60)
                                .navigationDestination(isPresented: $navigateToMyEventsScreen, destination: {
                                    AllEventsFPPView(globalVM: globalVM, loginData: loginData, eventVM: eventVM)
                                })
                                Divider()
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom,edges?.bottom)
                        .frame(width: UIScreen.screenWidth ,height: UIScreen.screenHeight/4)
                    }
                    .padding(.top)
                    .background(BlurView().clipShape(CustomCorner(corners: [.topLeft, .topRight])))
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnded(value: )))
                    .offset(y: eventVM.showAddEventBottomSheet ? 0 : UIScreen.main.bounds.height)
                }
                .ignoresSafeArea()
                .background(Color.black.opacity(eventVM.showAddEventBottomSheet ? 0.3 : 0).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            eventVM.showAddEventBottomSheet.toggle()
                        }
                    }
            )
        }
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
                    eventVM.showAddEventBottomSheet.toggle()
                }
                
                offset = 0
            }
        }
    }
}
//struct EventAddBottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventAddBottomSheetView()
//    }
//}
