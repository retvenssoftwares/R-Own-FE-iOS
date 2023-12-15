//
//  MessiboViewModel.swift
//  R-own
//
//  Created by Aman Sharma on 10/04/23.
//

import UIKit
import SwiftUI
import mesibo
import MesiboUI
import MesiboCall
import Combine


class MesiboViewModel: UIViewController, MesiboDelegate, ObservableObject{
    
    //Mesibo Var
    @StateObject var mesiboData = AddUserMesiboService()
    @StateObject var loginData = LoginViewModel()
    
    // MARK: user messages
    @Published var messageList: [MessageListModel] = []
    @Published var chatMessageList: [MessageListModel] = []
    @Published var chatListMessageList: [MessageListModel] = []
    @Published var showCallOutgoingScreen: Bool = false
    @State var mReadQuery: String = ""
    @Published var mCall: MesiboCallApi!
    @Published var session: MesiboReadSession!
    @Published var mGroupProfile: MesiboGroupProfile!
    @Published var mPresence: MesiboPresence!
    
    //call
    @Published var mesiboNotConnected: Bool = false
    @Published var callConnecting: Bool = false
    @Published var callConnected: Bool = false
    @Published var callAnswered: Bool = false
    @Published var callEnded: Bool = false
    @Published var isVideoSwapped: Bool = false
    @Published var muteToggle: Bool = false
    @Published var videoToggle: Bool = false
    @Published var profilePicMCall: String = ""
    @Published var nameMCall: String = ""
    @Published var unreadChatCount: Int = 0
    @Published var currentAudioDeviceToggle: Bool = false
    @Published var timeIntervalforvideo: Double = 1
    
    @Published var messageType: String = "New"
    
    private var callTimer: Timer?
    
    //mesibo var
    @AppStorage("m_Remote_User") var mRemoteUser: String!
    var mProfile: MesiboProfile!
    var mSelfProfile: MesiboProfile!
    
    let settings: MesiboGroupSettings = MesiboGroupSettings()
    @State var mConnectionStatus: String = "Connection Status: nil"
    var mMessageStatus: String = ""
    
    var MESIBOCALL_UI_STATE_SHOWINCOMING: Bool = false
    
    
    
    func addUserToMesiboModelFunc(loginData: LoginViewModel) async -> String {
        let res = await mesiboData.addUserToMesibo(loginData: loginData)
        if res == "Success" {
            return "Success"
        } else {
            return "Failure"
        }
    }
    
    func mesiboInitalize(_ token: String?, address: String?, remoteUserName name: String?){
        
        print("Mesibo instance starting to initalize")
        Mesibo.getInstance().addListener(self)

        // set user authentication token obtained by creating user
        Mesibo.getInstance().setAccessToken(token)
        Mesibo.getInstance().setDatabase("mydb", resetTables: 0)
        Mesibo.getInstance().start()
        
        print("mesibo initalized")
        
        
        self.mRemoteUser = address
        print("Printing mesibo user using the application")
//        print(mRemoteUser as Any)
        
        //set profile which is required by UI
        mProfile = Mesibo.getInstance().getProfile(address, groupid: 0)
        
        
        /* OPTIONAL - customize various UI defaults */
        let defs = MesiboUI.getUiDefaults()
        defs.emptyUserListMessage = "No messages!"
        
        //calls
        print("Call initalised")
        MesiboCall.start(with: nil, name: "RownApp", icon: nil, callKit: true)
        //messages
        // set app mode in foreground for read-receipt to be sent
        Mesibo.getInstance().setAppInForeground(self, screenId: 0, foreground: true)
        session = mProfile.createReadSession(self)
        
        print("mesibo initalization completed")
        
    }
    
    func mesiboSetTPPUser(_ address: String?) {
        //set profile which is required by UI
        mProfile = Mesibo.getInstance().getProfile(address, groupid: 0)
        print(6)
        print(mProfile)
    }
    
    func mesiboSetSelfProfile(_ address: String?) {
        //set profile which is required by UI
        mSelfProfile = Mesibo.getInstance().getSelfProfile()
        print(6)
        print(mSelfProfile)
    }
    
    func mesiboGroupSet(_ address: UInt32) {
        //set group which is required by UI
        mProfile = Mesibo.getInstance().getGroupProfile(address)
        mGroupProfile = mProfile.getGroupProfile()
        print(6)
        print(mGroupProfile)
    }
    
    func mesiboMessageListInit(loginData: LoginViewModel) {
        print(2345)
        
        print("-----message list read session initalized-----")
        session = MesiboReadSession(self)
        session.setQuery(self.mReadQuery)
        session.enableSummary(true)
        session.read(100)
        print(100)
        print("Sent Message Count: \(session.getSentMessageCount())")
        print(101)
        print("Failed Message Count: \(session.getFailedMessageCount())")
        print(102)
        print("Total Message Count: \(session.getTotalMessageCount())")
        print(103)
        print("Unread Message Count: \(session.getUnreadMessageCount())")
        print(104)
//        print(session.read(100))
        print(105)
        print("Sent Message Count: \(session.getSentMessageCount())")
        print(106)
        print("Failed Message Count: \(session.getFailedMessageCount())")
        print(107)
        print("Total Message Count: \(session.getTotalMessageCount())")
        print(108)
        print("Unread Message Count: \(session.getUnreadMessageCount())")
        print(109)
        print(110)
        print(111)
        print(session)
        print(112)
        
        loginData.showLoader = false

    }
    
    func mesiboMessageScreenInit(loginData: LoginViewModel) {
        print(3435)
        // following code will read messages from the database and
        // will also send read receipts for db and real-time messages
        
        
        var opts:MesiboMessageScreenOptions = MesiboMessageScreenOptions();
        opts.profile = mProfile;
        opts.navigation = true;
        MesiboUI.launchMessaging(self, opts:opts)
        
//        MesiboUI.launchMessageViewController(self, profile: mProfile)
//        MesiboUI.getMessageViewController(opts)
        print(119)
        var session: MesiboReadSession = mProfile.createReadSession(self)
        session.enableReadReceipt(true)
        session.enableMessages(true)
        print(1100)
        print("Sent Message Count: \(session.getSentMessageCount())")
        print(1101)
        print("Failed Message Count: \(session.getFailedMessageCount())")
        print(1102)
        print("Total Message Count: \(session.getTotalMessageCount())")
        print(1103)
        print("Unread Message Count: \(session.getUnreadMessageCount())")
        print(1104)
        print(session.read(100))
        print(1105)
        print("Sent Message Count: \(session.getSentMessageCount())")
        print(1106)
        print("Failed Message Count: \(session.getFailedMessageCount())")
        print(1107)
        print("Total Message Count: \(session.getTotalMessageCount())")
        print(1108)
        print("Unread Message Count: \(session.getUnreadMessageCount())")
        print(1109)
        print(1110)
        print(1111)
        print(session)
        print(1112)
        
        
        loginData.showLoader = false
    }
    
    
    func Mesibo_onConnectionStatus(status: Int) {
        print(2343)
        // You will receive the connection status here
        
        print("Connection status: \(status)")
        print(11)
        let str = "Connection Status: \(status)"
        if status == 4 || status == nil {
            print("mesibo not connected")
            self.mesiboNotConnected = true
        }
        print(12)
        mConnectionStatus = str
        print(mConnectionStatus)
        print(13)
    }
    
    func Mesibo_onSendPresence (){
        mPresence = mProfile.newPresence()
        mPresence.sendTyping()
    }
    
    func Mesibo_onPresence(presence: MesiboPresence){
        print("typinhg....")
    }
    
    func Mesibo_onMessage(message: MesiboMessage) {
        // A simple example of message processing
        /* Messaging documentation https://mesibo.com/documentation/api/messaging/ */
        print(23)
        print(message.message)
        DispatchQueue.main.async {
            print("\(self.messageList.count)")
            if message.isRealtimeMessage(){
                self.addNewMessage(message)
            } else {
                self.addMessage(message)
            }
            print("message added")
            print("\(self.messageList.count)")
        }
        
        
//        if message.isAudio(){
//            print("isAudio")
//            print(message.getFile()?.url)
//            print(message.getFile()?.type)
//            print(message.getFile()?.source)
//            print(message.getFile()?.progress)
//            print(message.getFile()?.name)
//            print(message.getFile()?.path)
//        }
//        if message.isImage(){
//            print("isImage")
//        }
//        if message.isVideo() {
//            print("isVideo")
////            print(message.getThumbnail())
////            print(message.getFileSize())
////            print(message.getFileType())
////            print(message.getFilePath())
////            print(message.video)
//
//        }
//        if message.isDocument(){
//            print("isDocument")
//        }
//        if message.isFileReady(){
//            print("isFileReady")
//        }
//        if message.isFilePending(){
//            print("isFilePending")
//        }
//        if message.isMatureContent(){
//            print("isMatureContent")
//        }
//        if message.isUploadRequired(){
//            print("isUploadRequired")
//        }
//        if message.isDownloadRequired(){
//            print("isDownloadRequired")
//        }
//        if message.isFileTransferRequired(){
//            print("isFileTransferRequired")
//        }
//        if message.isFileTransferInProgress(){
//            print("isFileTransferInProgress")
//        }
//        if message.isCall(){
//            print("isCall")
//        }
//        if message.isDate(){
//            print("isDate")
//        }
//        if message.isSent(){
//            print("isSent")
//        }
//        if message.isReply(){
//            print("isReply")
//        }
//        if message.isWiped(){
//            print("isWiped")
//        }
//        if message.isCustom(){
//            print("isCustom")
//        }
//        if message.isFailed(){
//            print("isFailed")
//        }
//        if message.isHeader(){
//            print("isHeader")
//        }
//        if message.isUnread(){
//            print("isUnread")
//        }
//        if message.isDeleted(){
//            print("isDeleted")
//        }
//        if message.isDynamic(){
//            print("isDynamic")
//        }
//        if message.isMessage(){
//            print("isMessage")
//        }
//        if message.isUpdated(){
//            print("isUpdated")
//        }
//        if message.isProxy(){
//            print("isProxy")
//        }
//        if message.isIncoming(){
//            print("isIncoming")
//        }
//        if message.isModified(){
//            print("isModified")
//        }
//        if message.isModified(){
//            print("isModified")
//        }
//        if message.isOutgoing(){
//            print("isOutgoing")
//        }
//        if message.isPresence(){
//            print("isPresence")
//        }
//        if message.isDelivered(){
//            print("isDelivered")
//        }
//        if message.isForwarded(){
//            print("isForwarded")
//        }
//        if message.isInvisible(){
//            print("isInvisible")
//        }
//        if message.isInOutbox(){
//            print("isInOutbox")
//        }
//        if message.isPstnCall(){
//            print("isPstnCall")
//        }
//        if message.isDbMessage(){
//            print("isDbMessage")
//        }
//        if message.isVideoCall(){
//            print("isVideoCall")
//        }
//        if message.isVoiceCall(){
//            print("isVoiceCall")
//        }
//        if message.isMissedCall(){
//            print("isMissedCall")
//        }
//        if message.isLastMessage(){
//            print("isLastMessage")
//        }
//        if message.isRichMessage(){
//            print("isRichMessage")
//        }
//        if message.isReadByUs(){
//            print("isReadByUs")
//        }
//        if message.isGroupMessage(){
//            print("isGroupMessage")
//        }
//        if message.isIncomingCall(){
//            print("isIncomingCall")
//        }
//        if message.isOutgoingCall(){
//            print("isOutgoingCall")
//        }
//        if message.isPlainMessage(){
//            print("isPlainMessage")
//        }
//        if message.isSavedMessage(){
//            print("isSavedMessage")
//        }
//        if message.isPendingMessage(){
//            print("isPendingMessage")
//        }
//        if message.isRealtimeMessage(){
//            print("isRealtimeMessage")
//        }
//        if message.isReadByPeer(){
//            print("isReadByPeer")
//        }
//        if message.isModifiedByPeer(){
//            print("isModifiedByPeer")
//        }
//        if message.isDbPendingMessage(){
//            print("isDbPendingMessage")
//        }
//        if message.isDbSummaryMessage(){
//            print("isDbSummaryMessage")
//        }
//        if message.isFileTransferFailed(){
//            print("isFileTransferFailed")
//        }
//        if message.isEndToEndEncrypted(){
//            print("isEndToEndEncrypted")
//        }
//        if message.isMessageStatusInProgress(){
//            print("isMessageStatusInProgress")
//        }
//        if message.isEndToEndEncryptionStatus(){
//            print("isEndToEndEncryptionStatus")
//        }
        
//        print(message.getStatus())
//        print(message.getTimestamp().daysElapsed)
//        print(message.getUserData())
//        if message.isCall() {
//            print("callIncoming")
//            return
//        }
//        if(message.isIncoming()) {
//            print(24)
//            /* Profile documentation https://mesibo.com/documentation/api/users-and-profiles/ */
//            var sender: MesiboProfile = message.profile!;
//
//            print(25)
//            /* Group Management - https://mesibo.com/documentation/api/group-management/ */
//            // check if this message belongs to a group
//            if(message.isGroupMessage()) {
//                print("group message incoming")
//                var group: MesiboProfile = message.groupProfile!;
//            } else {
//                print("user message incoming")
//            }
//            print(26)
//
//            // check if this message is realtime or read from the database
//            if (message.isRealtimeMessage()) {
////                alert("New Message", message: message.message)
//                print("new message incoming")
//                print(message.message)
//                messages.insert(message, at: 0)
//                messages = [MesiboMessage]()
//                mesiboMessageScreenInit(loginData: loginData)
//            } else{
//                print("Old Message here")
//                messages.append(message)
//            }
//            print(27)
//        } else{
//            messages.append(message)
//        }
    }
    
    func Mesibo_onMessageUpdate(message: MesiboMessage) {
        print(243)
    }
    
    func Mesibo_onMessageStatus(message: MesiboMessage) {
        print(20)
        let status = message.getStatus()
        print(message.message)
        print(21)
        let str: String = "Message Status: \(status)"
        print(22)
        print(str)
        mMessageStatus = str
        DispatchQueue.main.async {
            if self.messageList.count > 0{
                if self.messageList[0].mMessage == message {
                    self.messageList[0].mMessage.status = status
                }
                for i in 1..<(self.messageList.count < 20 ? self.messageList.count : 20) {
                    if self.messageList[i].mMessage == message {
                        self.messageList[i].mMessage.status = 3
                    }
                }
            }
        }
//        mesiboMessageScreenInit(loginData: loginData)
    }
    
    func onSendMessage(messageText: String, loginData: LoginViewModel) {
        print(14)
        if !isLoggedIn() {
            return
        }
        print(15)

        let msg = mProfile.newMessage();
        
        
        
        print(16)
        print(messageText)
        msg.message = messageText;
        
        print(17)
        msg.send()
        print("message sent")
    }
    
    func onSendImageMessage(img: UIImage, loginData: LoginViewModel, text: String) {
        
        guard let imageData = img.jpegData(compressionQuality: 0.8) else {
            return
        }

        print(14)
        if !isLoggedIn() {
            return
        }
        print(15)

        let msg = mProfile.newMessage();
        
        msg.setContent(img)
        msg.message = text;

        print(17)
        msg.send()
        print("message sent")
    }
    
    func onSendVideoMessage(videoURL: URL, loginData: LoginViewModel, text: String) {
        print(14)
        if !isLoggedIn() {
            return
        }
        print(15)

        let msg = mProfile.newMessage();
        
        print(text)
        msg.setContent(videoURL)
        msg.message = text;
        
        print(17)
        msg.send()
        print("message sent")
    }
    
    func isLoggedIn() -> Bool {
        if MESIBO_STATUS_ONLINE == Mesibo.getInstance().getConnectionStatus() {
            return true
        }
        print("not logged in: Login with a valid token first")
        return false
    }
    
    func onAudioCall(loginData: LoginViewModel) {
        
        if !isLoggedIn() {
            return
        }
        print("attempting call")
        
        
//        MesiboCall.getInstance().callUi(self, profile: mProfile, video: false)
//        if MesiboCall.getInstance().callUi(self, profile: mProfile, video: false) {
//            MesiboCall.getInstance().callUi(forExistingCall: self)
//        }
//        MesiboCall.getInstance().call(MesiboCall.getInstance().createCallProperties(false))
//        MesiboCall.getInstance().callUi(MesiboCall.getInstance().createCallProperties(false))
        
        if (MesiboCall.getInstance().getActiveCall() != nil) {
            print("calling existing voice call")
            MesiboCall.getInstance().callUi(forExistingCall: self)
        } else {
            print("normal voice call")
            MesiboCall.getInstance().callUi(self, profile: mProfile, video: false)
        }
        
//        let cp = MesiboCall.getInstance().createCallProperties(false)
        print("call succeded")
//        if mCall == nil {
//            print("error")
//        } else {
//            print("call succeded")
//        }
    }
    
    func onVideoCall(loginData: LoginViewModel) {
        print(3535)
        if !isLoggedIn() {
            return
        }
        print("attempting video call")
        
        
        if (MesiboCall.getInstance().getActiveCall() != nil) {
            print("calling existing video call")
            MesiboCall.getInstance().callUi(forExistingCall: self)
        } else {
            print("normal video call")
            MesiboCall.getInstance().callUi(self, profile: mProfile, video: true)
        }
        self.callConnecting = true
//        startUpdatingMCall(loginData: loginData)
        print("video call successful")
//        MesiboCall.getInstance().call(MesiboCall.getInstance().createCallProperties(true))
    }
    
    
    // MARK: - Various Call Listners from https://mesibo.com/documentation/api/calls/listeners/
    
    func startUpdatingMCall(loginData: LoginViewModel) {
        callTimer = Timer.scheduledTimer(withTimeInterval: timeIntervalforvideo, repeats: true) { [weak self] _ in
            self?.updateMCall(loginData: loginData)
        }
    }
    
//    func stopUpdatingMCall() {
//        callTimer?.invalidate()
//        callTimer = nil
//
//        self.mesiboNotConnected = false
//        self.callConnecting = false
//        self.callConnected = false
//        self.callAnswered = false
//        self.callEnded = false
//        self.isVideoSwapped = false
//        self.muteToggle = false
//        self.videoToggle = false
//        self.profilePicMCall = ""
//        self.nameMCall = ""
//    }
    
    func updateMCall(loginData: LoginViewModel) {
        self.callEnded = false
        
        
        // Perform your background task here
        
        mCall = MesiboCall.getInstance().getActiveCall()
        DispatchQueue.main.async {
            if self.mCall != nil {
                if self.mCall.isAnswered(){
                    print("isAnswered")
                }
                if self.mCall.isIncoming(){
                    print("isIncoming")
                }
                if self.mCall.isLinkUp(){
                    print("isLinkUp")
                }
                if self.mCall.isVideoCall(){
                    print("isVideoCall")
                }
                if self.mCall.isCallConnected(){
                    print("isCallConnected")
                }
                if self.mCall.isCallInProgress(){
                    print("isCallInProgress")
                }
            }
            if self.mCall == nil {
                self.callEnded = true
//                self.stopUpdatingMCall()
                self.timeIntervalforvideo = 1
            } else if self.mCall.isIncoming(){
                loginData.callActivated = true
                if self.mCall.isVideoCall() {
                    print("video call")
                }
                if self.mCall.isIncoming(){
                    print("incoming call")
                }
            } else if self.mCall!.isAnswered() {
                loginData.callActivated = true
                print("call is answered")
                self.callConnecting = false
                self.callAnswered = true

                if self.mCall!.isCallConnected() {
                    print("call is connected")
                    self.callConnected = true
                }
            }
        }
    }
    
    func MesiboCall_OnIncoming(profile: MesiboProfile, video: Bool) -> MesiboCallProperties {
        // Define call properties
        print("Call is incoming")
        let prop: MesiboCallProperties = MesiboCall.getInstance().createCallProperties(video)
        print(143)
        print(prop.audio)
        print(343)
        return prop
    }
    
//    func MesiboCall_OnIncoming(_ call: MesiboCall!) -> Bool {
//        let callId = call.getActiveCall()?.getCallProperties()
//
//        // Use the call ID as needed
//
//
//        return true
//    }
    
    
    func MesiboCall_OnShowUserInterface( call: MesiboCall, properties cp: MesiboCallProperties?) -> Bool {
        print("showing call interface")
        return true
    }
    
    func MesiboCall_onNotify() {
        print("notifying about call")
    }
    
    
    func MesiboCall_OnNotify(type: Int32, profile: MesiboProfile, video: Bool) -> Bool {
        print(3535)
        print(type)
        print(profile.getAddress())
        return false
    }
    
    func MesiboCall_OnError(cp: MesiboCallProperties, error: Int32) {
        print(2435)
        print(error)
        print(cp)
    }
    func MesiboCall_OnUpdateUserInterface(p: MesiboCallProperties, state: Int, video: Bool, enable: Bool) {
        print("updating call ui")
    }

    func MesiboCall_OnStatus(p: MesiboCallProperties, status: Int, video: Bool){
        print("Handle change in the call status")
    }
    
    func MesiboCall_OnSetCall( call: MesiboCall ) {
        print("the call object is initialized")
    }
    
    func MesiboCall_OnPlayInCallSound(p: MesiboCallProperties, type: Int, video: Bool) -> Bool {
        print("Play ringing sound")
            return true;
    }
    
    func MesiboCall_OnAnswer() {
        self.mCall.answer(false)
        print("answering call")
        
    }
    
    func MesiboCall_OnHangup() {
        showCallOutgoingScreen = false
        self.mCall.hangup()
//        stopUpdatingMCall()
        self.callAnswered = false
        self.callEnded = true
        print("handlingHangup")
        
    }
    
    func MesiboCall_OnMute() {
        self.muteToggle.toggle()
        self.mCall.toggleAudioMute();
    }
    
    func MesiboCall_OnStopVideo() {
        self.videoToggle.toggle()
        self.mCall.toggleVideoMute()
    }
    
    
    func MesiboCall_OnVideoSwap() {
        self.isVideoSwapped.toggle()
        if self.isVideoSwapped {
            self.mCall.setVideoViewsSwapped(true)
        } else {
            self.mCall.setVideoViewsSwapped(false)
        }
    }
    
    
    func MesiboCall_OnVideoSwitch() {
        self.mCall.switchCamera()
    }
    
    func MesiboCall_OnSpeaker() {
        if currentAudioDeviceToggle {
            self.mCall.toggleAudioDevice(0)
            currentAudioDeviceToggle.toggle()
        } else {
            self.mCall.toggleAudioDevice(1)
            currentAudioDeviceToggle.toggle()
        }
    }
    
    func MesiboCall_OnAudioDeviceChanged(p: MesiboCallProperties, active: MesiboAudioDevice, inactive: MesiboAudioDevice) {
        print("Handling audio device change")
    }
    
    func MesiboCall_OnDTMF( p: MesiboCallProperties, digit: Int) {
        print("DTMF digit is received from the remote end")
    }
    
    func MesiboCall_OnVideo( p: MesiboCallProperties, video: MesiboVideoProperties, remote: Bool) {
        print("Displaying Video Feeds")
    }
    
    
//    func updateMCall() {
//        // Create a timer that fires every second
//        let timer = Timer(timeInterval: 0.5, repeats: true) { _ in
//            // Perform your background task here
//            self.mCall = MesiboCall.getInstance().getActiveCall()
//            // Update UI on the main thread if needed
//            if self.mCall == nil {
//                print("call ended")
//                self.callEnded = true
//            } else if self.mCall.isAnswered() {
//                print("call is answered")
//                DispatchQueue.main.async {
//                    self.callConnecting = false
//                    self.callAnswered = true
//                }
//                if self.mCall.isCallConnected() {
//                    DispatchQueue.main.async {
//                        // Update UI components here
//                        print("call is connected")
//                        self.callConnected = true
//                    }
//                }
//            }
//
//            if self.callEnded == false {
//                self.updateMCall()
//            }
//        }
//
//        // Schedule the timer on the main run loop
//        RunLoop.main.add(timer, forMode: .common)
//    }
    
//    public func mesiboCall_(onNotifyIncoming type: Int32, profile: MesiboProfile?, video: Bool) -> Bool {
//        print("messibo call")
//        var n: String? = nil
//        var subj: String? = nil
//        print(123)
//        if MESIBOCALL_NOTIFY_INCOMING == type {
//            subj = "Mesibo Incoming Call"
//            print(1234)
//            if let name = profile?.getName() {
//                n = String(format: "Mesibo %scall from %@", video ? "Video " : "", name)
//                print(n)
//                print(12345)
//            }
//        } else if MESIBOCALL_NOTIFY_MISSED == type {
//            subj = "Mesibo Missed Call"
//            print(123456)
//            if let name = profile?.getName() {
//                n = String(format: "You missed a Mesibo %scall from %@", video ? "Video " : "", name)
//                print(123456)
//            }
//        }
//
//        if n != nil {
//
//            print(12345678)
//            Mesibo.getInstance().run(inThread: true, handler: {
//                print("notification for call")
////                SampleAppNotify.getInstance().notify(2, subject: subj, message: n)
//            })
//        }
//        print(123456789)
//        return true
//    }
    
    @State var messageCount = 0
    
    func addMessage(_ message: MesiboMessage) {
        self.messageCount += 1
        if self.messageType == "MessageList" {
            chatMessageList.insert(MessageListModel(id: (self.chatMessageList.count + 1), mMessage: message), at: 0)
        } else if self.messageType == "ChatTabList" {
            chatListMessageList.insert(MessageListModel(id: (self.chatListMessageList.count + 1), mMessage: message), at: 0)
            print("printing chatlist mess")
            print(chatListMessageList)
        } else{
            messageList.insert(MessageListModel(id: (self.messageList.count + 1), mMessage: message), at: 0)
        }
        print(randomString(length: 10))
    }
    
    func addNewMessage(_ message: MesiboMessage) {
        self.messageCount += 1
        if self.messageType == "MessageList" {
            chatMessageList.append(MessageListModel(id: (self.chatMessageList.count + 1), mMessage: message))
        } else{
            messageList.append(MessageListModel(id: (self.messageList.count + 1), mMessage: message))
        }
        print(randomString(length: 10))
    }
    
    
    
    
    
    public func mesiboCall_(onNotifyIncoming type: Int32, profile: MesiboProfile?, video: Bool) -> Bool {
        
        var n: String? = nil
        var subj: String? = nil
        if MESIBOCALL_NOTIFY_INCOMING == type {
            subj = "Mesibo Incoming Call"
            if let name = profile?.getName() {
                n = String(format: "Mesibo %scall from %@", video ? "Video " : "", name)
            }
        } else if MESIBOCALL_NOTIFY_MISSED == type {
            subj = "Mesibo Missed Call"
            if let name = profile?.getName() {
                n = String(format: "You missed a Mesibo %scall from %@", video ? "Video " : "", name)
            }
        }
        
        if n != nil {
            Mesibo.getInstance().run(inThread: true, handler: {
                print("crevre")
                print(n)
                print(subj)
            })
        }
        
        return true
    }
    
    //group
    
    
    func addMembers(_ profile: MesiboProfile?) {
        var members: [AnyHashable] = []
        members.append(mRemoteUser)
        
        let gp = profile?.getGroupProfile()
        let mp:MesiboMemberPermissions = MesiboMemberPermissions();
        mp.flags = UInt32(MESIBO_MEMBERFLAG_ALL);
        mp.adminFlags = 0;
        gp?.addMembers(members, permissions:mp)
    }
    
    func GetGroupMembers(_ sender: Any) {
        //var profile = Mesibo.getInstance()?.getGroupProfile(2340288);
        //mGroupProfile = profile;
        if(mGroupProfile == nil) {
            return;
        }
        
        mGroupProfile.getGroupProfile()?.getMembers(100, restart: false, listener: self)
    }
    
    func LeaveGroup(_ sender: Any) {
        if(mGroupProfile == nil) {
            return;
        }
        
        mGroupProfile.getGroupProfile()?.leave();
    }
    
//
//    func mesibo_(onGroupCreated profile: MesiboProfile?) {
//        print("New Group Created, \(profile?.getName())")
//
//        mGroupProfile = profile
//        // add members to the group
//        addMembers(profile)
//    }
//
//    func mesibo_(onGroupCreated profile: MesiboProfile?) {
//        print("New Group Created, \(profile?.getName())")
//
//        mGroupProfile = profile
//        // add members to the group
//        addMembers(profile)
//    }
//
//    func mesibo_(onGroupJoined groupProfile: MesiboProfile!) {
//
//    }
//
//    func mesibo_(onGroupLeft groupProfile: MesiboProfile!) {
//        print("New Group Left \(groupProfile?.getName())")
//    }
//
//
//    func mesibo_(onGroupError groupProfile: MesiboProfile!, error: UInt32) {
//
//    }
//
//
//    func mesibo_(onGroupMembers groupProfile: MesiboProfile!, members: [Any]!) {
//        print("members")
//    }
//
//
//    func mesibo_(onProfileUpdated profile: MesiboProfile?) {
//        print("Profile Updated \(profile?.getName())")
//    }
    
}


