//
//  InappManager.swift
//  Blog
//
//  Created by Apple on 31/01/2023.
//

//appl_NwXCklLvpgjhLlHhDuuZTPJDZCs

import StoreKit
import UIKit
import RevenueCat
import Foundation



final class iappmanager {
    
    static let Shared = iappmanager()
    
    
     
    private init() {}
    
    
    
    func ispremium() -> Bool {
        return UserDefaults.standard.bool(forKey: "Premium")
        
    }
    public func getsubcriptionstatus(completion: ((Bool) -> Void)? ) {
        Purchases.shared.getCustomerInfo { info, error in
            guard let entitlements = info?.entitlements,
                  error  == nil else {return}
            print(entitlements)
            if entitlements.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true,forKey: "Premium")
            
                completion?(true)
            }
   
            UserDefaults.standard.set(false,forKey: "Premium")
            completion?(false)
        }
       
    }
  public  func fetchpackage(completion: @escaping( Package?)-> Void )  {
        Purchases.shared.getOfferings { offerings, error in
            guard let package =  offerings?.offering(identifier:"Premium")?.availablePackages.first,
                  error == nil else {
                completion(nil)
                return
            }
            completion(package)
        }
    }
  public  func subcribe(package: Package,completion: @escaping (Bool) -> Void ) {
        guard !ispremium() else {
            print("user already subcriber")
            completion(true)
            
            return }
        Purchases.shared.purchase(package: package) {transaction,info,error,usercancelled in
            guard
                  let entitlements = info?.entitlements,
                  error == nil,
                  !usercancelled else {return}
            if error  == nil && !usercancelled  {
                if entitlements.all["Premium"]?.isActive == true {
                    UserDefaults.standard.set(true,forKey: "Premium")
                    completion(true)
                }
             
            }else{
                UserDefaults.standard.set(false,forKey: "Premium")
                completion(false)
            }
          
            }
        }
    
    
   public func restorepurchase(completion: @escaping (Bool) -> Void ) {
   
        Purchases.shared.restorePurchases { info, error in
            guard
                  let entitlements = info?.entitlements,
              error == nil
                  else {return}
 
                if entitlements.all["Premium"]?.isActive == true {
                    UserDefaults.standard.set(true,forKey: "Premium")
                    completion(true)
                }
                UserDefaults.standard.set(false,forKey: "Premium")
                completion(false)
            }
             
            }
            
        }
    
    
    
    

