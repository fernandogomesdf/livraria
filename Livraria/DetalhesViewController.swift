//
//  DetalhesViewController.swift
//  Livraria
//
//  Created by IOS on 01/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    

    @IBOutlet weak var capaImageView: UIImageView!

    @IBOutlet weak var tituloLabel: UILabel!
    
    @IBOutlet weak var autorLabel: UILabel!
    
    @IBOutlet weak var descricaoLabel: UITextView!
    
    @IBOutlet weak var labelPreco: UILabel!
    
    var isFavoritos : Bool = false
    var livroAtual : Livro?
    let livroDAO : LivrosDAO = LivrosDAO()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.tituloLabel.text = livroAtual?.getTitulo()
        self.autorLabel.text = livroAtual?.getAutor()
        self.capaImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: (livroAtual?.getImagemGrande())!)!)!)
        self.labelPreco.text = livroAtual?.getPreco()
        
        
        var str: NSAttributedString?
        
        do{
            str = try NSAttributedString(data: (livroAtual?.getDescricao().dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!)!, options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        }
        catch{
            str = NSAttributedString(string: "")
        }
        
        // Texto formatado
        self.descricaoLabel.attributedText = str 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvar(sender: AnyObject) {
        let livrosDAO : LivrosDAO = LivrosDAO()
        
        let livroFavorito : LivroFavorito = livrosDAO.novo()
        livroFavorito.autor = livroAtual?.getAutor()
        livroFavorito.titulo = livroAtual?.getTitulo()
        livroFavorito.descricao = livroAtual?.getDescricao()
        livroFavorito.preco = livroAtual?.getPreco()
        livroFavorito.imagem = livroAtual?.getImagemGrande()
        
        livrosDAO.salvar()
        
    }
    
    @IBAction func compartilhar(sender: AnyObject) {
        let shareItems = [livroAtual!.autor, livroAtual!.titulo]
        
        let minhasAtividades : [UIActivity]?
        
        if isFavoritos {
            minhasAtividades = nil
        } else {
            minhasAtividades = [AddFavorito(livro: self.livroAtual!)]
        }
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities:  minhasAtividades)
        
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]
        
        
        
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
