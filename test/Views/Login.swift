//
//  Login.swift
//  test
//
//  Created by Sami Resua on 28/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct Login: View {
    
    @State var email = ""
    @State var password = ""
    @State var signingIn = false
    @State var didError = false
    @State var signedIn = false
    
    func login(){
        DispatchQueue.main.async { self.signingIn = true }
        Auth.auth().signIn(withEmail: email, password: password) { data, error  in
            if(error != nil){
                DispatchQueue.main.async { self.signingIn = false; self.didError = true }
            } else {
                DispatchQueue.main.async { self.signedIn = true }
            }
        }
    }
    
    var body: some View {
        
        if(!signedIn){
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            Button(action: login) {
                Text(self.signingIn ? "Signing in" : "Login")
            }.alert(isPresented: $didError) {
                Alert(title: Text("We couldnt sign you in"), message: Text("Please check your credentials and try again"), dismissButton: .default(Text("Got it!")))
            }
        } else {
            TaskList()
        }

        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
