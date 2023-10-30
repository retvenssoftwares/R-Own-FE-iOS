//
//  Extensions.swift
//  R-own
//
//  Created by Aman Sharma on 07/04/23.
//

import SwiftUI
import UIKit

//custom color
extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}
let screenBGGreyColor = Color(hex: 0xF7F7FC)

let greenUi = Color(hex: 0xADD134)
let greyUi = Color(hex: 0xF7F7F7)
let lightGreyUi = Color(hex: 0xE0E0E0)
let callGreenColorUI = Color(hex: 0x31B303)
let chatLightGreenColorUI = Color(hex: 0xF7FEDF)
let chatGreyColorUI = Color(hex: 0xEEEEEE)
let sidebarBGGreyColorUI = Color(hex: 0xDADEE1)
let communityBGBlueColorUI = Color(hex: 0x272A3D)
let communityTextGreenColorUI = Color(hex: 0xADD314)
let communityTextGreyColorUI = Color(hex: 0xD9D9D9)
let communityGreyBG = Color(hex: 0xF0F0F0)
let jobsDarkBlue = Color(hex: 0x272A3D)
let jobsBrightGreen = Color(hex: 0xACD037)
let jobsLightBlue = Color(hex: 0x9AC7F0)
let jobsLightRed = Color(hex: 0xFC3C3C)
let jobsLightGrey = Color(hex: 0x9CA3AF)
let jobsCardLightGrey = Color(hex: 0xF4F4F5)


let jobsTextLightBlue = Color(hex: 0xD6E4FF)
let jobsTextDarkBlue = Color(hex: 0x3366FF)
let jobsGreyUi = Color(hex: 0xF4F4F5)
let profilePostBG = Color(hex: 0xE9E9E9)
let eventsBgGrey = Color(hex: 0xF1F1F1)
let postBgGrey = Color(hex: 0xCDCDCD)

let miniSize = (UIScreen.screenHeight/65)
let normalTextSize = UIScreen.screenHeight/55
let headingTextSize = UIScreen.screenHeight/45
let largeHeadingTextSize = UIScreen.screenHeight/35

struct CustomGreenButton: View {
    var title: LocalizedStringKey
    var width: CGFloat = UIScreen.screenWidth/1.1
    var height: CGFloat = UIScreen.screenHeight/20
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(jobsDarkBlue)
                .font(.title3)
                .fontWeight(.medium)
                .frame(width: width, height: height)
                .background(greenUi)
                .cornerRadius(10)
        }
    }
}

struct CustomBlueButton: View {
    var title: LocalizedStringKey
    var width: CGFloat = UIScreen.screenWidth/1.1
    var height: CGFloat = UIScreen.screenHeight/20
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(greenUi)
                .font(.title3)
                .fontWeight(.medium)
                .frame(width: width, height: height)
                .background(jobsDarkBlue)
                .cornerRadius(10)
        }
    }
}

//border
extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return width
                case .leading, .trailing: return rect.height
                }
            }
            path.addRect(CGRect(x: x, y: y, width: w, height: h))
        }
        return path
    }
}

//custom screen size
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


//custom corner radius-1
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


//custom corner radius-2
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}


//string to number
extension String {

    var numbersOnly: String {

        let numbers = self.replacingOccurrences(
             of: "[^0-9]",
             with: "",
             options: .regularExpression,
             range:nil)
        return numbers
    }
}


//otp field helper
extension Binding where Value == String{
    func limit(_ length: Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                    self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}

//opacity
extension View{
    func disableWithOpacity(_ condition: Bool)->some View{
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

//removing prefix from string
extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

//swipeback to last view
extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

//get elements that exist before or after any particular element
extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element

    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.index(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }

    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.index(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
}

//crop
extension UIImage {

func crop(to:CGSize) -> UIImage {

    guard let cgimage = self.cgImage else { return self }

    let contextImage: UIImage = UIImage(cgImage: cgimage)

    guard let newCgImage = contextImage.cgImage else { return self }

    let contextSize: CGSize = contextImage.size

    //Set to square
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    let cropAspect: CGFloat = to.width / to.height

    var cropWidth: CGFloat = to.width
    var cropHeight: CGFloat = to.height

    if to.width > to.height { //Landscape
        cropWidth = contextSize.width
        cropHeight = contextSize.width / cropAspect
        posY = (contextSize.height - cropHeight) / 2
    } else if to.width < to.height { //Portrait
        cropHeight = contextSize.height
        cropWidth = contextSize.height * cropAspect
        posX = (contextSize.width - cropWidth) / 2
    } else { //Square
        if contextSize.width >= contextSize.height { //Square on landscape (or square)
            cropHeight = contextSize.height
            cropWidth = contextSize.height * cropAspect
            posX = (contextSize.width - cropWidth) / 2
        }else{ //Square on portrait
            cropWidth = contextSize.width
            cropHeight = contextSize.width / cropAspect
            posY = (contextSize.height - cropHeight) / 2
        }
    }

    let rect: CGRect = CGRect(x: posX, y: posY, width: cropWidth, height: cropHeight)

    // Create bitmap image from context using the rect
    guard let imageRef: CGImage = newCgImage.cropping(to: rect) else { return self}

    // Create a new image based on the imageRef and rotate back to the original orientation
    let cropped: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

    UIGraphicsBeginImageContextWithOptions(to, false, self.scale)
    cropped.draw(in: CGRect(x: 0, y: 0, width: to.width, height: to.height))
    let resized = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return resized ?? self
  }
}

//image to uiimage
extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
 // Set the background to be transparent incase the image is a PNG, WebP or (Static) GIF
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}


struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

extension Float {
    func decimals(_ nbr: Int) -> String {
        String(self.formatted(.number.precision(.fractionLength(nbr))))
    }
}


extension String {

    func toDate(withFormat format: String = "yyyy/MM/dd")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
    
    func toTime(withFormat format: String = "HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}

// to use aray in app storage
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

//this funciton help us to calculate the relative time

func relativeTime(from dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

    guard let date = dateFormatter.date(from: dateString) else {
        return nil
    }
    
    let currentDate = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.second, .minute, .hour, .day], from: date, to: currentDate)
    
    if let days = components.day, days > 0 {
        return "\(days) day\(days == 1 ? "" : "s") ago"
    } else if let hours = components.hour, hours > 0 {
        return "\(hours) hour\(hours == 1 ? "" : "s") ago"
    } else if let minutes = components.minute, minutes > 0 {
        return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
    } else if let seconds = components.second, seconds > 0 {
        return "\(seconds) second\(seconds == 1 ? "" : "s") ago"
    } else {
        return "Just now"
    }
}

//this extension help us to format date from dateadded fromat from backend to normal date
func formattedDate(from dateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withFullTime, .withFractionalSeconds]
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day, .month, .year], from: date)
            
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.dateFormat = "d MMMM"
            
            if let year = components.year, year != calendar.component(.year, from: Date()) {
                dateFormatterOutput.dateFormat = "d MMMM yyyy"
            }
            
            let formattedDate = dateFormatterOutput.string(from: date)
            return formattedDate
        }
        
        return ""
    }
//blogs date converter
func convertToRelativeDateString(from dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    if let date = dateFormatter.date(from: dateString) {
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.day, .weekOfYear], from: date, to: now)
        
        if let weeksAgo = components.weekOfYear, weeksAgo > 0 {
            return "\(weeksAgo) \(weeksAgo == 1 ? "week" : "weeks") ago"
        } else {
            return "7 days ago"
        }
    } else {
        return "Invalid date format"
    }
}
//this extension help us to extract first word from string that is seperated by comma, using here for location
func extractFirstWord(from string: String) -> String? {
    let components = string.components(separatedBy: ",")
    if let firstComponent = components.first {
        let trimmedFirstComponent = firstComponent.trimmingCharacters(in: .whitespaces)
        let words = trimmedFirstComponent.components(separatedBy: .whitespaces)
        if let firstWord = words.first {
            return firstWord
        }
    }
    return nil
}

//this extension help us to pop out the object from the array
extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}

//to get last seen for mesibo chats as we get last seen in seconds
func timeAgoString(fromSeconds seconds: Int) -> String {
    let minute = 60
    let hour = 60 * minute
    let day = 24 * hour
    
    if seconds < minute {
        return "\(seconds) seconds ago"
    } else if seconds < hour {
        let minutes = seconds / minute
        return "\(minutes) minutes ago"
    } else if seconds < day {
        let hours = seconds / hour
        return "\(hours) hours ago"
    } else {
        let days = seconds / day
        return "\(days) days ago"
    }
}

//this is the extension to add two cgsize, used in video call screen
extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
}

//checks and validates the url
func validateURL(_ urlString: String) -> String? {
    guard var correctedURL = URL(string: urlString) else {
        return nil
    }
    
    // Check if the URL scheme is missing
    if correctedURL.scheme == nil {
        // Add "http://" as the default scheme
        correctedURL = URL(string: "http://\(urlString)")!
    }
    
    // Check if the host is missing
    if correctedURL.host == nil {
        // Append "www." as the default host
        correctedURL = URL(string: correctedURL.absoluteString.replacingOccurrences(of: "http://", with: "http://www."))!
    }
    
    // Return the corrected URL as a string
    return correctedURL.absoluteString
}

func convertTo12HourClock(_ timeString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    
    if let date = dateFormatter.date(from: timeString) {
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: date)
    }
    
    return nil
}



// Extension to get height of the text with given width and font
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return boundingBox.height
    }
}
