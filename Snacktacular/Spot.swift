//
//  Spot.swift
//  Snacktacular
//
//  Created by Christopher Kennedy on 3/26/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Spot: Identifiable, Codable{
    @DocumentID var id: String?
    var name  = ""
    var address = ""
    var dictionary: [String: Any]{
        return ["name": name, "address": address]
    }
}
