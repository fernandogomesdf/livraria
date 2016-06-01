//
//  AddFavorito.swift
//  Livraria
//
//  Created by IOS on 01/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class AddFavorito: UIActivity {
    
    var livroFavorito : LivroFavorito?
    let livroDAO : LivrosDAO = LivrosDAO()
    
    
    override func activityType() -> String? {
        return "AddFavorito"
    }
    
    override func activityTitle() -> String? {
        return "Add Favorito"
    }
    
    override func performActivity() {
        
    }
    
}
