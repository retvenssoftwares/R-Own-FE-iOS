//
//  UserAPIModel.swift
//  R-own
//
//  Created by Aman Sharma on 12/04/23.
//

import Foundation

struct UserDataFromServer: Codable, Identifiable {
    let hotelOwnerInfo: HotelOwnerInfo
    let vendorInfo: VendorInfo
    let id, fullName, email, phone: String
    let profilePic: String
    let resume: String
    let mesiboAccount: [MesiboAccount]
    let interest: [Interest]
    var verificationStatus, userBio, createdOn: String
    let savedPost: [JSONAny]
    let likedPost: [LikedPost?]
    var userName, dob, location, profileCompletionStatus: String
    let role, deviceToken: String
    var studentEducation: [StudentEducation?]
    var normalUserInfo: [NormalUserInfoProfile?]
    var hospitalityExpertInfo: [HospitalityExpertInfoProfile?]
    let displayStatus, userID: String
    let bookmarkjob: [JSONAny]
    let postCount: [PostCount?]
    let connections, pendingRequest, requests: [Connection?]
    let v: Int
    var gender: String?

    enum CodingKeys: String, CodingKey {
        case hotelOwnerInfo, vendorInfo
        case id = "_id"
        case fullName = "Full_name"
        case email = "Email"
        case phone = "Phone"
        case profilePic = "Profile_pic"
        case resume
        case mesiboAccount = "Mesibo_account"
        case interest = "Interest"
        case verificationStatus, userBio
        case createdOn = "Created_On"
        case savedPost = "saved_post"
        case likedPost = "Liked_post"
        case userName = "User_name"
        case dob = "DOB"
        case location, profileCompletionStatus
        case role = "Role"
        case deviceToken = "device_token"
        case studentEducation, normalUserInfo, hospitalityExpertInfo
        case displayStatus = "display_status"
        case userID = "User_id"
        case bookmarkjob = "Bookmarkjob"
        case postCount = "post_count"
        case connections
        case pendingRequest = "pending_request"
        case requests
        case v = "__v"
        case gender = "Gender"
    }
}

// MARK: - Connection
struct Connection: Codable {
    let userID, dateAdded: String
    let displayStatus: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case dateAdded = "date_added"
        case displayStatus = "display_status"
        case id = "_id"
    }
}

// MARK: - HotelOwnerInfo
struct HotelOwnerInfo: Codable {
    let hotelownerName, hotelDescription, hotelType, hotelCount: String
    let websiteLink, bookingEngineLink, hotelownerid: String
    let hotelInfo: [JSONAny]
}

// MARK: - Interest
struct Interest: Codable {
    let intid: String?
    let id: String

    enum CodingKeys: String, CodingKey {
        case intid
        case id = "_id"
    }
}

// MARK: - LikedPost
struct LikedPost: Codable {
    let postID, id: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case id = "_id"
    }
}

// MARK: - MesiboAccount
struct MesiboAccount: Codable {
    let uid: Int
    let address, token, id: String

    enum CodingKeys: String, CodingKey {
        case uid, address, token
        case id = "_id"
    }
}

// MARK: - PostCount
struct PostCount: Codable {
    let postID, dateAdded, id: String

    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case dateAdded = "date_added"
        case id = "_id"
    }
}

// MARK: - StudentEducation
struct StudentEducation: Codable {
    var educationPlace, educationSessionStart, educationSessionEnd, id: String

    enum CodingKeys: String, CodingKey {
        case educationPlace
        case educationSessionStart = "education_session_start"
        case educationSessionEnd = "education_session_end"
        case id = "_id"
    }
}

// MARK: - StudentEducation
struct NormalUserInfoProfile: Codable {
    var jobType, jobTitle, jobCompany, jobStartYear, jobEndYear: String

    enum CodingKeys: String, CodingKey {
        case jobType
        case jobTitle
        case jobCompany
        case jobStartYear
        case jobEndYear
    }
}


// MARK: - StudentEducation
struct HospitalityExpertInfoProfile: Codable {
    let userDescription, jobtype, jobtitle, hotelCompany, jobstartYear, jobendYear: String

    enum CodingKeys: String, CodingKey {
        case userDescription
        case jobtype
        case jobtitle
        case hotelCompany
        case jobstartYear
        case jobendYear
    }
}


// MARK: - VendorInfo
struct VendorInfo: Codable {
    let vendorImage, vendorName, vendorDescription, websiteLink: String
    let vendorServices, portfolioLink: [JSONAny]
}


// MARK: - Encode/decode helpers


class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
