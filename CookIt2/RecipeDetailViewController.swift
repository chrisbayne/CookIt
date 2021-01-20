//
//  RecipeDetailViewController.swift
//  CookIt2
//
//  Created by Chris Bayne on 2021-01-19.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var recipe: Recipe?
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var imageView: UIImageView!
  
  override func viewDidLoad() {
      super.viewDidLoad()
        
      // this gives the new page a title based on which recipe is clicked
      self.title = recipe?.title
      // We are telling the tableView that our ViewController will act as its delagate and dataSource
      tableView.delegate = self
      tableView.dataSource = self
    
      guard let unWrappedRecipe = recipe,
            let url = URL(string: unWrappedRecipe.imageURL),
            let data = try? Data(contentsOf: url),
            let validImage = UIImage(data: data)
      else {
        print("error")
        return
      }
    self.title = unWrappedRecipe.title
    imageView.image = validImage
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipe?.steps.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "recipeStepCell", for: indexPath) // creating the cell
    cell.textLabel?.text = recipe?.steps[indexPath.row]
    return cell
    
    
  }

  }
  
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
