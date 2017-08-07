//
//  DoCatchViewController.swift
//  SwiftStudy
//
//  Created by d2c_cyf on 17/8/1.
//  Copyright © 2017年 d2c_cyf. All rights reserved.
//

import UIKit

enum CustomError : Error {
    case NameInvalidError
    case AgeInvalidError
    case NameLengthError
}

//TUDO: - 如何像OC一样可以包括代码块 获取到系统的崩溃
class DoCatchViewController: BaseViewController {

    var name : String!
    var age  : Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catchExample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func catchExample () {
        do {
            try errorTest()
        } catch CustomError.NameLengthError {
            print("NameLengthError")
        } catch CustomError.NameInvalidError {
            print("NameInvalidError")

        } catch CustomError.AgeInvalidError {
            print("AgeInvalidError")
        } catch {
            print("all Catch")
        }
    }
    
    func errorTest () throws {
        throw CustomError.NameLengthError

    }
    

    
}
