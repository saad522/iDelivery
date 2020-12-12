//
//  API.swift
//  iDelivery
//
//  Created by mac on 11/11/20.
//

import Firebase
import FirebaseFirestore

class API {
    static let shared = API()
    let db = Firestore.firestore()
    lazy var collection = db.collection(DB_Keys.collectionKey)
    
    func fetchUsersData(city : String,completion : @escaping([User]?,Error?)->Void) {
       
        collection.whereField("city", isEqualTo: city).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error : ",error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            
        let user = documents.map { (snpashot) -> User in
                let dectionary = snpashot.data()
                return User(dectionary: dectionary)
            }
            completion(user,nil)
        }
   }
    
    func fetchMoreLikesHim(like name :String,on city :String, with price :String,completion :@escaping ([User]?, Error?) -> Void) {
        collection.whereField("city", isEqualTo: city).whereField("price", isEqualTo: price).whereField("fullName", isNotEqualTo: name).addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error : ",error.localizedDescription)
                completion(nil,error)
                return
            }
            guard let documents = querySnapshot?.documents else { return }
            let user = documents.map { (snpashot) -> User in
                    let dectionary = snpashot.data()
                    return User(dectionary: dectionary)
                }
            completion(user,nil)
        }
    }
    func fetchUserData(completion : @escaping(User?,Error?)->Void) {
        guard let uiserID = Auth.auth().currentUser?.uid else { return  }
      
        collection.whereField("userId", isEqualTo: uiserID).getDocuments { (snpachot, error) in
            if let error = error {
                completion(nil,error)
            }
            guard let documents = snpachot?.documents else { return }
            for document in documents {
                let dictionary = document.data()
                let user = User(dectionary: dictionary)
                completion(user,nil)
            }
        }
    }
    
    
}
