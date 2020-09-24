//
//  CharacterDetailViewController.swift
//  HarryPotterAPI
//
//  Created by Trevor Bursach on 9/24/20.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var wizardNameLabel: UILabel!
    @IBOutlet weak var wizardImageView: UIImageView!
    @IBOutlet weak var wizardSpeciesLabel: UILabel!
    @IBOutlet weak var wizardGenderLabel: UILabel!
    @IBOutlet weak var wizardHouseLabel: UILabel!
    @IBOutlet weak var wizardDateOfBirthLabel: UILabel!
    @IBOutlet weak var wizardAncestryLabel: UILabel!
    @IBOutlet weak var wizardEyeColourLabel: UILabel!
    @IBOutlet weak var wizardHairColourLabel: UILabel!
    @IBOutlet weak var wandWoodLabel: UILabel!
    @IBOutlet weak var wandCoreLabel: UILabel!
    
    var character: Character?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        
        if let character = character {
            wizardNameLabel.text = character.name
            wizardSpeciesLabel.text = character.species
            wizardGenderLabel.text = character.gender
            wizardHouseLabel.text = character.house
            wizardDateOfBirthLabel.text = character.dateOfBirth
            wizardAncestryLabel.text = character.ancestry
            wizardEyeColourLabel.text = character.eyeColour
            wizardHairColourLabel.text = character.hairColour
            wandWoodLabel.text = character.wand?.wood
            wandCoreLabel.text = character.wand?.core
            if let imageString = character.image {
                CharacterController.fetchImageFrom(characterURL: imageString) { (result) in
                    switch result {
                    
                    case .success(let image):
                        DispatchQueue.main.async {
                            self.wizardImageView.image = image
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
} // END OF CLASS
