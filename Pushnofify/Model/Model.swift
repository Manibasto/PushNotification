//
//  Model.swift
//  Pushnofify
//
//  Created by Anil Kumar on 11/07/19.
//  Copyright © 2019 AIT. All rights reserved.
//

import Foundation


struct notification:Codable {
  let Titile : String?
  let Desc : String?
  
  init(Titile: String,Desc: String) {
      self.Titile = Titile
      self.Desc = Desc
  }    
}

