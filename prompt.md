## The task

You are asked to create an outfit mixer prototype for a fashion retailer. If the prototyping goes well, it will eventually get implemented on the fashion retailer's website. 

Let's call this fashion retailer X and its website is example.com.

## User Journey

- As a customer, I visit example.com.
- I have no idea what I am looking for, just want to browse around
- I see this new gadget on the website called Outfit Mixer. It looks interesting, so I click on it.
- At high level, I see 3 columns: 
  - On the left there is some instructions for how to use this Outfit Mixer.
  - In the middle is a UI that looks like a pizza, or perhaps resembles a color wheel. The wheel is multiple slices, and when I mouse over a slice, it pops out a little, kind of slick looking animation.
  - On the right, there are some toggles such as gender, vibes.
- When I click on a slice on the pizza, I see a panel pops up. It allows me to filter products by categories. The category defaults to Tops.
- As soon as I select an apparel, I see a table on the left column shows up, displaying the details about the selected apparel. I see a thumbnail, product name, and an option to remove the item from the table.
- I see there's a Mix button in the middle of the pizza. I first select one or a few apparels, and click on the Mix button, the pizza spins, and "magically" the page recommends me apparels for the categories that I did not make an selection.
- Once I have an outfit, I see there's a button in the left column that says "Preview". I click on it, the panel in the left column flips over and shows me a preview of the outfit.

## Additional Requirements

- You are given a blank workspace, with a `product_catalog.json` file and a `images` folder to work with.
- Generate a single HTML file that contains all the code.
- Use SVG for the pizza UI.
- Show the categories adjacent to the pies.
- When a apparel is chosen, show a thumbnail on the pie.
- The UI should be fun to use, ideally creates "wow" moments for the user.
- The look and feel should resemble a modern high fashion retailer's website.
- The categories of the entire catalog is defined in `product_catalog.json`.
- The filters on the right columns are for display purposes only. They do need to be functional.

## Artifact

- A single HTML file name outfit-mixer.html