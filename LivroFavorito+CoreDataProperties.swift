//
//  LivroFavorito+CoreDataProperties.swift
//  Livraria
//
//  Created by IOS on 01/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension LivroFavorito {

    @NSManaged var titulo: String?
    @NSManaged var autor: String?
    @NSManaged var preco: String?
    @NSManaged var imagem: String?
    @NSManaged var descricao: String?

}
