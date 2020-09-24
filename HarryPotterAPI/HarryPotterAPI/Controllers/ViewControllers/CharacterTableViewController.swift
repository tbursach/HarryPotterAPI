//
//  CharacterTableViewController.swift
//  HarryPotterAPI
//
//  Created by Trevor Bursach on 9/24/20.
//

import UIKit

class CharacterTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        tableView.reloadData()
    }
    
    //MARK: - Properties
    var characters: [Character] = []
    
    //MARK: - Helpers
    
    func fetchCharacters() {
        CharacterController.fetchCharacter { (result) in
            DispatchQueue.main.async {
                switch result {
                
                case .success(let characters):
                    self.characters = characters
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? CharacterDetailViewController else { return }
            let character = characters[indexPath.row]
            destination.character = character
        }
    }
}
