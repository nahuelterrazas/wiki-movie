//
//  AuthService.swift
//  WikiMovie
//
//  Created by Nahuel Terrazas on 29/06/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AuthService {
    public static let shared = AuthService()
    
    private init(){} // singleton
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: User information (email, password, username)
    ///   - completion: A Completion with two values...
    ///   - Bool: wasRegistered - Determinates if the user was registered and saved in the database correctly
    ///   - Error?: An optional error if firebase provides one
    public func registerUser(with userRequest: RegisterUser, completion: @escaping (Bool, Error?)->Void){
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let dataBase = Firestore.firestore()
            dataBase.collection("user")
                .document(resultUser.uid)
                .setData([
                    "username": username,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    
    public func signIn(with userRequest:LoginUser, completion: @escaping (Bool, Error?)->Void) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            } else {
                completion(true, nil)
                print("\(userRequest.email)")
            }
        }
    }
    
    
    public func signOut(completion: @escaping (Error?)->Void){
        do{
            try Auth.auth().signOut()
            completion(nil)
            print("signed out")
        }catch let error{
            completion(error)
        }
    }
}
