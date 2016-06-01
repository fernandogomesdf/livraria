//
//  FavoritosViewController.swift
//  Livraria
//
//  Created by IOS on 01/06/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class FavoritosViewController: UITableViewController {
    
    var livros : [Livro] = []
    var livrosFavoritos : [LivroFavorito] = []
    let livrosDAO : LivrosDAO = LivrosDAO()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.livros.removeAll()
        
        for livroFavorito in livrosDAO.obterLivros() {
            let livro : Livro = Livro(titulo: livroFavorito.titulo!, autor:livroFavorito.autor!, preco:livroFavorito.preco!, imagem: livroFavorito.imagem!, descricao:livroFavorito.descricao!, imagemGrande: livroFavorito.imagem!)
            self.livros.append(livro)
            self.livrosFavoritos.append(livroFavorito)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return livros.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("minhaCelula", forIndexPath: indexPath) as! LivroTableViewCell

        // Configure the cell...
        
        let livro : Livro = self.livros[indexPath.row]
        cell.tituloLabel.text = livro.getTitulo()
        cell.autorLabel.text = livro.getAutor()
        cell.precoLabel.text = livro.getPreco()
        
        print(livro.getImagem())
        cell.capaImageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: livro.getImagem())!)!)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            
            do {
                try livrosDAO.apagar(livrosFavoritos[indexPath.row])
                
                self.livrosFavoritos.removeAtIndex(indexPath.row)
                self.livros.removeAtIndex(indexPath.row)
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
               
                
            } catch (ExcecoesDados.Delete){
                print("Deu zebra no delete")
            } catch {
                print("Deu zebra")
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let detalhes: DetalhesViewController = segue.destinationViewController as! DetalhesViewController
        detalhes.livroAtual = livros[self.tableView.indexPathForCell(sender! as! LivroTableViewCell)!.row];
    }
    

}
