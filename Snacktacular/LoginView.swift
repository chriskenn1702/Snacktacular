//
//  LoginView.swift
//  Snacktacular
//
//  Created by Christopher Kennedy on 3/26/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    enum Field{
        case email, password
    }
    
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var buttonDisable = true
    @State private var path = NavigationPath()
    @FocusState private var focusField: Field?
    
    var body: some View {
        NavigationStack (path: $path){
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding()
            
            Group{
                TextField("E-Mail", text: $email)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusField, equals: .email)
                    .onSubmit {
                        focusField = .password
                    }
                    .onChange(of: email) { _ in
                        enableButtons()
                    }
                
                SecureField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.done)
                    .focused($focusField, equals: .password)
                    .onSubmit {
                        focusField = nil
                    }
                    .onChange(of: password) { _ in
                        enableButtons()
                    }
            }
            .textFieldStyle(.roundedBorder)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.gray.opacity(0.5), lineWidth: 2)
            }
            .padding(.horizontal)
            
            HStack{
                Button {
                    register()
                } label: {
                    Text("Sign Up")
                }
                .padding(.trailing)
                
                Button {
                    login()
                } label: {
                    Text("Log In")
                }
                .padding(.leading)
            }
            .disabled(buttonDisable)
            .buttonStyle(.borderedProminent)
            .tint(Color("SnackColor"))
            .font(.title2)
            .padding(.top)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { view in
                if view == "ListView"{
                    ListView()
                }
            }
        }
        .alert(alertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) {}
        }
        .onAppear{
            if Auth.auth().currentUser != nil{
                print("🪵 Login success!")
                path.append("ListView")
            }
        }
    }
    
    func enableButtons(){
        let emailIsGood = email.count > 6 && email.contains("@")
        let passwordIsGood = password.count > 6
        buttonDisable = !(emailIsGood && passwordIsGood)
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in
            if let error = error{
                print("🤬 REGISTRATION ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else{
                print("😎 Registration success!")
                path.append("ListView")
            }
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if let error = error{
                print("🤬 LOGIN ERROR: \(error.localizedDescription)")
                alertMessage = "LOGIN ERROR: \(error.localizedDescription)"
                showingAlert = true
            } else{
                print("🪵 Login success!")
                path.append("ListView")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
