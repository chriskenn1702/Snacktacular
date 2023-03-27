//
//  SpotViewModel.swift
//  Snacktacular
//
//  Created by Christopher Kennedy on 3/26/23.
//

import Foundation
import FirebaseFirestore

class SpotViewModel: ObservableObject{
    @Published var spot = Spot()
    
    func saveSpot(spot: Spot) async -> Bool{
        let db = Firestore.firestore()
        if let id = spot.id{
            do{
                try await db.collection("spots").document(id).setData(spot.dictionary)
                print("Data updated succesfully!")
                return true
            } catch{
                print("ERROR: Could not update data in 'spots' \(error.localizedDescription)")
                return false
            }
        } else{
            do{
                try await db.collection("spots").addDocument(data: spot.dictionary)
                print("Data added succesfully!")
                return true
            } catch{
                print("ERROR: Could not could not create a new spot in 'spots' \(error.localizedDescription)")
                return false
            }
        }
    }
}
