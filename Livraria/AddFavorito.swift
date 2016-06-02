//
//  AddFavorito.swift
//  Livraria
//
//  Created by IOS on 01/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class AddFavorito: UIActivity {
    
    let livro: Livro?
    
    init(livro: Livro){
        self.livro = livro
    }
    
    override func activityType()->String?{
        return "br.com.begyn.AddLivro"
    }
    
    override func activityTitle()->String?{
        return "Salvar"
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        return true
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        salvarLivro()
    }
    
    func salvarLivro(){
        let livrosDAO: LivrosDAO = LivrosDAO()
        let livroFavorito: LivroFavorito = livrosDAO.novo()
        
        livroFavorito.autor = livro!.getAutor()
        livroFavorito.titulo = livro!.getTitulo()
        livroFavorito.preco = livro!.getPreco()
        livroFavorito.descricao = livro!.getDescricao()
        livroFavorito.imagem = livro!.getImagemGrande()
        
        livrosDAO.salvar()
    }
}
