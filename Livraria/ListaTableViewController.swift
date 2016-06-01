//
//  ListaTableViewController.swift
//  Livraria
//
//  Created by IOS on 31/05/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class ListaTableViewController: UITableViewController, UISearchBarDelegate,  APIProtocol {
    
    var itunesAPI : ItunesAPI = ItunesAPI()
    var dados: NSDictionary?
    var titulos: [String] = []
    var livros : [Livro] = []
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itunesAPI.delegate = self
        itunesAPI.searchItunesFor("Java")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
    
    func dadosRecebidos(dados: NSDictionary) {
        print("dados recebidos")
        self.dados = dados
        
        let resultados: [AnyObject] = self.dados!.valueForKey("results") as! [AnyObject]
        
        for livro in resultados {
            let titulo = livro.valueForKey("trackCensoredName")! as! String
            let autor = livro.valueForKey("artistName")! as! String
            let preco = livro.valueForKey("formattedPrice")! as! String
            let imagem = livro.valueForKey("artworkUrl60")! as! String
            
            self.titulos.append(titulo)
            
            let livro = Livro(titulo: titulo, autor: autor, preco: preco, imagem: imagem)
            self.livros.append(livro)
            
        }
        
        self.tableView.reloadData()
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
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        titulos.removeAll()
        livros.removeAll()
        
        itunesAPI.searchItunesFor(searchBar.text!)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
