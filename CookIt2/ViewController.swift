//
//  ViewController.swift
//  CookIt2
//
//  Created by Chris Bayne on 2021-01-19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource { // Delegate is telling
  
  let recipes = [
    Recipe (title: "Best Brownies", steps: ["Step 1", "Step 2", "Step 3"], imageURL: "https://images.pexels.com/photos/45202/brownie-dessert-cake-sweet-45202.jpeg"),
    Recipe (title: "Bandana Bread", steps: ["Step 1", "Step 2", "Step 3"], imageURL: "https://images.pexels.com/photos/830894/pexels-photo-830894.jpeg"),
    Recipe (title: "Chocolate Chip Cookies", steps: ["Step 1", "Step 2", "Step 3"], imageURL: "https://images.pexels.com/photos/230325/pexels-photo-230325.jpeg")
  ]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // OPTIMAL WAY TO PASS DATA FROM ONE VIEW TO ANOTHER VIA SEGUE
    // Use conditional binding to unwrap the cast of the segue destination
    // and the index of the row that the user selected
    if let recipeDetailViewController = segue.destination as? RecipeDetailViewController, // recipedetailViewController will be assigned a value in the last line  - "recipeDetailViewController.recipe = recipes[index]"
       let index = tableView.indexPathForSelectedRow?.row {
      // The recipe is only populated if we know that the destination is our
      // detail view AND we have a recipe row selected from the table
      recipeDetailViewController.recipe = recipes[index]
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    // We are telling the tableView that our ViewController will act as its delagate and dataSource
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return recipes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    // Get the cell
    // We are getting the cell from the queue of cells
    // We recycle cells for better performance
    let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) // creating the cell
    let localRecipe = recipes[indexPath.row]
    
    // Populate the cell
    // We set the cell's text label to our recipe string from the array constant for that index
    cell.textLabel?.text = recipes[indexPath.row].title
    
    // Guard statements - if you're at the very end of a method call / 
    guard let url = URL(string: localRecipe.imageURL),
          let data = try? Data(contentsOf: url),
          let validImage = UIImage(data: data)
    else {
      print("error retrieving image from recipe image url")
      return cell
    }
    cell.imageView?.image = validImage
    
    // Get the image data from a string url
//    if let url = URL(string: localRecipe.imageURL),
//       let data = try? Data(contentsOf: url) {
//
//    // Populate the imageView if recipe.imageURL is infact a URL that contains data
//      cell.imageView?.image = UIImage(data: data)
//    }
    // Return the cell
    return cell
        
  }
}

