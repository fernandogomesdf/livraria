//
//  Livro.swift
//  Livraria
//
//  Created by IOS on 31/05/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import Foundation

class Livro {
    
    var titulo : String
    var autor : String
    var preco : Double
    var imagem : String
    
    init (titulo: String, autor: String, preco: Double, imagem : String) {
        
        self.titulo = titulo
        self.autor = autor
        self.preco = preco
        self.imagem = imagem
    }
    
    func setTitulo(titulo:String){self.titulo=titulo}
    func setAutor(autor:String){self.autor=autor}
    func setPreco(preco:Double){self.preco=preco}
    func setImagem(imagem:String){self.imagem=imagem}
    
    func getTitulo()->String {return titulo}
    func getAutor()->String{return autor}
    func getPreco()->Double{return preco}
    func getImagem()->String{return imagem}
}