//
//  ListView.swift
//  Snacktacular
//
//  Created by Christopher Kennedy on 3/26/23.
//

import SwiftUI
import Firebase

struct ListView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        List{
            Text("List items will go here")
        }
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Sign Out") {
                    do{
                        try Auth.auth().signOut()
                        print("🪵 Log out succesful")
                        dismiss()
                    } catch{
                        print("🤬 ERROR: Could not sign out!")
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }

            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ListView()
        }
    }
}
