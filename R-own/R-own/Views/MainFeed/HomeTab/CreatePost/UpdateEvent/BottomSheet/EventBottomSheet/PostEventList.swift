//
//  PostEventList.swift
//  R-own
//
//  Created by Aman Sharma on 11/05/23.
//

import SwiftUI
import Shimmer

struct PostEventList: View {
    
    @StateObject var createPostVM: CreatePostViewModel
    @State var event: EventListWhilePostingModel
    
    var body: some View {
        VStack{
            Button(action: {
                createPostVM.postEvent = event.eventTitle
                createPostVM.selectedEventID = event.eventID
                createPostVM.updateEventBottomSheet.toggle()
            }, label: {
                HStack{
                    AsyncImage(url: URL(string: event.eventThumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                    } placeholder: {
                        //put your placeholder here
                        Rectangle()
                            .fill(lightGreyUi)
                            .frame(width: UIScreen.screenHeight/40, height: UIScreen.screenHeight/40)
                            .shimmering(active: true)
                    }
                    Text(event.eventTitle)
                        .font(.system(size: UIScreen.screenHeight/70))
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, UIScreen.screenWidth/40)
                .padding(.vertical, UIScreen.screenHeight/70)
            })
            Divider()
        }
    }
}

//
//struct PostEventList_Previews: PreviewProvider {
//    static var previews: some View {
//        PostEventList()
//    }
//}
