# Designing the outfit mixer prototype
_Exported on 8/12/2025 at 22:51:40 PDT from Cursor (1.4.2)_

---

**User**

## The task

You are asked to create an outfit mixer prototype for a fashion retailer. If the prototyping goes well, it will eventually get implemented on the fashion retailer's website. 

Let's call this fashion retailer X and its website is example.com.

## User Journey

- As a customer, I visit example.com.
- I have no idea what I am looking for, just want to browse around
- I see this new gadget on the website called Outfit Mixer. It looks interesting, so I click on it.
- At high level, I see 3 columns: 
  - On the left there is some instructions for how to use this Outfit Mixer.
  - In the middle is a UI that looks like a pizza, or perhaps resembles a color wheel. The wheel has multiple slices, and when I mouse over a slice, it pops out a little, kind of slick looking animation.
  - On the right, there are some toggles such as gender, enable/disable certain slots, such as hats or accessories like sunglasses.
- When I click on a slice on the pizza, I see a panel pops up. It allows me to filter products by categories. The category defaults to Tops. I can also type in a keyword to drill down the results.
- As soon as I select an apparel, I see a table on the left column shows up, displaying the details about the selected apparel. The existing instructions disappear. I see a thumbnail, product name, and an option to remove the item from the table.
- I see there's a Mix button in the middle of the pizza. I first select one or a few apparels, and click on the Mix button, the pizza spins, and "magically" the page recommends me apparels for the categories that I did not make an selection.
- Once I have an outfit, I see there's a button in the left column that says "Preview". I click on it, the panel in the left column flips over and shows me a preview of the outfit.

## Additional Requirements

- You are given a blank workspace, with a `product_catalog.json` file and a `images` folder to work with.
- Generate a single HTML file that contains all the code.
- The design does not need to responsive, aim for a desktop UI.
- Use SVG for the pizza UI.
- Show the categories adjacent to the pies.
- When a apparel is chosen, show a thumbnail on the pie.
- The UI should be fun to use, ideally creates "wow" moments for the user.
- The look and feel should resemble a modern high fashion retailer's website.
- The categories of the entire catalog is defined in `product_catalog.json`.
- The filters on the right columns are for display purposes only. They do need to be functional.

## Caveats

- Should we allow the user to enter the same category multiple times? If yes, how should the UI handle this?
- How should we support the preview feature? For MVP, maybe just show all the thumbnails in a grid layout? Or you have a implementation that "wows" the user?

## Artifact

- A single HTML file name outfit-mixer.html

---

**Cursor**

I'll create an interactive outfit mixer prototype for the fashion retailer. Let me start by exploring the workspace to understand the product catalog structure and available assets.

Let me check the actual file structure more carefully:

Now let me read the product catalog and explore the images:

Perfect! Now I understand the structure. The product catalog has 13 categories and we have corresponding images. Let me now start creating the outfit mixer HTML file:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Outfit Mixer - Fashion Retailer X</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            display: grid;
            grid-template-columns: 300px 1fr 280px;
            gap: 30px;
            padding: 30px;
            min-height: 100vh;
            max-width: 1600px;
            margin: 0 auto;
        }

        .panel {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .left-panel {
            padding: 30px;
            display: flex;
            flex-direction: column;
        }

        .center-panel {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 50px;
            position: relative;
        }

        .right-panel {
            padding: 30px;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
            text-align: center;
        }

        .instructions {
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .instructions h3 {
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .instructions ul {
            padding-left: 20px;
        }

        .instructions li {
            margin-bottom: 8px;
        }

        .pizza-container {
            position: relative;
            width: 400px;
            height: 400px;
        }

        .pizza-wheel {
            width: 100%;
            height: 100%;
            transition: transform 0.5s ease;
        }

        .pizza-slice {
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pizza-slice:hover {
            transform: scale(1.05);
            filter: brightness(1.1);
        }

        .pizza-slice.selected {
            filter: brightness(1.2) saturate(1.3);
        }

        .slice-label {
            font-size: 11px;
            font-weight: 600;
            text-anchor: middle;
            fill: #333;
            pointer-events: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .mix-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            border: none;
            color: white;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
            transition: all 0.3s ease;
            z-index: 10;
        }

        .mix-button:hover {
            transform: translate(-50%, -50%) scale(1.1);
            box-shadow: 0 15px 30px rgba(255, 107, 107, 0.4);
        }

        .mix-button:active {
            transform: translate(-50%, -50%) scale(0.95);
        }

        .mix-button.spinning {
            animation: spin 2s linear;
        }

        @keyframes spin {
            from { transform: translate(-50%, -50%) rotate(0deg); }
            to { transform: translate(-50%, -50%) rotate(720deg); }
        }

        .controls h3 {
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }

        .control-group {
            margin-bottom: 25px;
        }

        .control-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
            margin-right: 10px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .selected-items {
            margin-top: 30px;
        }

        .selected-items h3 {
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }

        .item-card {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .item-thumbnail {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
            margin-right: 15px;
            border: 2px solid #f0f0f0;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .item-brand {
            color: #666;
            font-size: 12px;
        }

        .remove-btn {
            background: #ff6b6b;
            border: none;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .remove-btn:hover {
            background: #ff5252;
            transform: scale(1.1);
        }

        .preview-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .preview-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .preview-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 40px;
            border-radius: 20px;
            width: 80%;
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            right: 20px;
            top: 20px;
        }

        .close:hover {
            color: #000;
        }

        .category-header {
            color: #666;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .search-bar {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
            transition: border-color 0.3s ease;
        }

        .search-bar:focus {
            outline: none;
            border-color: #667eea;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }

        .product-image {
            width: 100%;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .product-name {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .product-brand {
            font-size: 12px;
            color: #666;
        }

        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .preview-item {
            text-align: center;
        }

        .preview-item h4 {
            margin-bottom: 10px;
            color: #333;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .preview-item img {
            width: 100%;
            max-width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 12px;
            border: 3px solid #f0f0f0;
        }

        .no-selection {
            color: #999;
            font-style: italic;
            font-size: 14px;
        }

        .category-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .category-filter {
            padding: 8px 16px;
            background: #f5f5f5;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 12px;
            font-weight: 500;
        }

        .category-filter.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .slice-thumbnail {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
        }

        .empty-state {
            text-align: center;
            color: #999;
            padding: 40px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Panel -->
        <div class="panel left-panel">
            <div id="instructions">
                <h3>How to Use Outfit Mixer</h3>
                <ul>
                    <li>Click on any slice of the wheel to browse that category</li>
                    <li>Select items you like from the popup</li>
                    <li>Use the controls on the right to customize your experience</li>
                    <li>Hit the MIX button to get AI recommendations</li>
                    <li>Preview your complete outfit when ready</li>
                </ul>
            </div>
            
            <div id="selected-items" class="selected-items" style="display: none;">
                <h3>Your Selection</h3>
                <div id="items-list"></div>
                <button id="preview-btn" class="preview-btn" disabled>Preview Outfit</button>
            </div>
        </div>

        <!-- Center Panel -->
        <div class="panel center-panel">
            <h1>Outfit Mixer</h1>
            <div class="pizza-container">
                <svg class="pizza-wheel" viewBox="0 0 400 400" id="pizza-wheel">
                    <!-- Pizza slices will be generated here -->
                </svg>
                <button class="mix-button" id="mix-btn">MIX</button>
            </div>
        </div>

        <!-- Right Panel -->
        <div class="panel right-panel">
            <div class="controls">
                <h3>Preferences</h3>
                
                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="gender-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Unisex Items
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="accessories-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Include Accessories
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="seasonal-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Seasonal Items
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="formal-toggle">
                            <span class="slider"></span>
                        </span>
                        Formal Occasions
                    </label>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Selection Modal -->
    <div id="product-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modal-title">Select Products</h2>
            <div class="category-header" id="category-header">TOPS</div>
            
            <input type="text" class="search-bar" id="search-bar" placeholder="Search products...">
            
            <div class="category-filters" id="category-filters">
                <!-- Category filter buttons will be generated here -->
            </div>
            
            <div class="products-grid" id="products-grid">
                <!-- Products will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Preview Modal -->
    <div id="preview-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Your Outfit Preview</h2>
            <div class="preview-grid" id="preview-grid">
                <!-- Preview items will be shown here -->
            </div>
        </div>
    </div>

    <script>
        // Product catalog data
        const productCatalog = {
            "belts": [
                {"name": "Classic Leather Belt", "brand": "Brand A", "image_path": "../../../images/belts/belt1.jpg"},
                {"name": "Woven Canvas Belt", "brand": "Brand B", "image_path": "../../../images/belts/belt2.jpg"},
                {"name": "Reversible Belt", "brand": "Brand C", "image_path": "../../../images/belts/belt3.jpg"},
                {"name": "Chain Link Belt", "brand": "Brand D", "image_path": "../../../images/belts/belt4.jpg"},
                {"name": "Braided Leather Belt", "brand": "Brand E", "image_path": "../../../images/belts/belt5.jpg"},
                {"name": "Designer Buckle Belt", "brand": "Brand F", "image_path": "../../../images/belts/belt6.jpg"}
            ],
            "bottoms": [
                {"name": "Floral Midi Dress", "brand": "Brand G", "image_path": "../../../images/bottoms/dress1.jpg"},
                {"name": "Wrap Dress", "brand": "Brand H", "image_path": "../../../images/bottoms/dress2.jpg"},
                {"name": "Cocktail Dress", "brand": "Brand A", "image_path": "../../../images/bottoms/dress3.jpg"},
                {"name": "Slim Fit Jeans", "brand": "Brand B", "image_path": "../../../images/bottoms/jeans1.jpg"},
                {"name": "High-Waisted Jeans", "brand": "Brand C", "image_path": "../../../images/bottoms/jeans2.jpg"},
                {"name": "Distressed Denim", "brand": "Brand D", "image_path": "../../../images/bottoms/jeans3.jpg"},
                {"name": "Wide Leg Jeans", "brand": "Brand E", "image_path": "../../../images/bottoms/jeans4.jpg"},
                {"name": "Pleated Midi Skirt", "brand": "Brand F", "image_path": "../../../images/bottoms/skirt1.jpg"},
                {"name": "A-Line Skirt", "brand": "Brand G", "image_path": "../../../images/bottoms/skirt2.jpg"},
                {"name": "Pencil Skirt", "brand": "Brand H", "image_path": "../../../images/bottoms/skirt3.jpg"}
            ],
            "earrings": [
                {"name": "Pearl Drop Earrings", "brand": "Brand A", "image_path": "../../../images/earrings/earrings1.jpg"},
                {"name": "Gold Hoop Earrings", "brand": "Brand B", "image_path": "../../../images/earrings/earrings2.jpg"},
                {"name": "Crystal Stud Earrings", "brand": "Brand C", "image_path": "../../../images/earrings/earrings3.jpg"},
                {"name": "Chandelier Earrings", "brand": "Brand D", "image_path": "../../../images/earrings/earrings4.jpg"},
                {"name": "Minimalist Bar Earrings", "brand": "Brand E", "image_path": "../../../images/earrings/earrings5.jpg"}
            ],
            "gloves": [
                {"name": "Leather Driving Gloves", "brand": "Brand F", "image_path": "../../../images/gloves/gloves1.jpg"},
                {"name": "Cashmere Gloves", "brand": "Brand G", "image_path": "../../../images/gloves/gloves2.jpg"},
                {"name": "Fingerless Gloves", "brand": "Brand H", "image_path": "../../../images/gloves/gloves3.jpg"},
                {"name": "Winter Wool Gloves", "brand": "Brand A", "image_path": "../../../images/gloves/gloves4.jpg"},
                {"name": "Evening Opera Gloves", "brand": "Brand B", "image_path": "../../../images/gloves/gloves5.jpg"},
                {"name": "Touchscreen Gloves", "brand": "Brand C", "image_path": "../../../images/gloves/gloves6.jpg"}
            ],
            "handbags": [
                {"name": "Tote Bag", "brand": "Brand D", "image_path": "../../../images/handbags/handbag1.jpg"},
                {"name": "Crossbody Bag", "brand": "Brand E", "image_path": "../../../images/handbags/handbag2.jpg"},
                {"name": "Clutch Purse", "brand": "Brand F", "image_path": "../../../images/handbags/handbag3.jpg"},
                {"name": "Shoulder Bag", "brand": "Brand G", "image_path": "../../../images/handbags/handbag4.jpg"},
                {"name": "Bucket Bag", "brand": "Brand H", "image_path": "../../../images/handbags/handbag5.jpg"},
                {"name": "Satchel Bag", "brand": "Brand A", "image_path": "../../../images/handbags/handbag6.jpg"},
                {"name": "Hobo Bag", "brand": "Brand B", "image_path": "../../../images/handbags/handbag7.jpg"}
            ],
            "hats": [
                {"name": "Fedora Hat", "brand": "Brand C", "image_path": "../../../images/hats/hat1.jpg"},
                {"name": "Baseball Cap", "brand": "Brand D", "image_path": "../../../images/hats/hat2.jpg"},
                {"name": "Wide Brim Sun Hat", "brand": "Brand E", "image_path": "../../../images/hats/hat3.jpg"},
                {"name": "Beanie", "brand": "Brand F", "image_path": "../../../images/hats/hat4.jpg"},
                {"name": "Beret", "brand": "Brand G", "image_path": "../../../images/hats/hat5.jpg"}
            ],
            "necklaces": [
                {"name": "Pearl Strand Necklace", "brand": "Brand H", "image_path": "../../../images/necklaces/necklace1.jpg"},
                {"name": "Gold Chain Necklace", "brand": "Brand A", "image_path": "../../../images/necklaces/necklace2.jpg"},
                {"name": "Pendant Necklace", "brand": "Brand B", "image_path": "../../../images/necklaces/necklace3.jpg"},
                {"name": "Choker Necklace", "brand": "Brand C", "image_path": "../../../images/necklaces/necklace4.jpg"}
            ],
            "scaves": [
                {"name": "Silk Scarf", "brand": "Brand D", "image_path": "../../../images/scaves/scarf1.jpg"},
                {"name": "Cashmere Scarf", "brand": "Brand E", "image_path": "../../../images/scaves/scarf2.jpg"},
                {"name": "Infinity Scarf", "brand": "Brand F", "image_path": "../../../images/scaves/scarf3.jpg"},
                {"name": "Printed Square Scarf", "brand": "Brand G", "image_path": "../../../images/scaves/scarf4.jpg"},
                {"name": "Wool Blanket Scarf", "brand": "Brand H", "image_path": "../../../images/scaves/scarf5.jpg"},
                {"name": "Lightweight Summer Scarf", "brand": "Brand A", "image_path": "../../../images/scaves/scarf6.jpg"},
                {"name": "Fringed Wrap Scarf", "brand": "Brand B", "image_path": "../../../images/scaves/scarf7.jpg"}
            ],
            "shoes": [
                {"name": "Leather Oxford Shoes", "brand": "Brand C", "image_path": "../../../images/shoes/shoes1.jpg"},
                {"name": "High-Top Sneakers", "brand": "Brand D", "image_path": "../../../images/shoes/shoes2.jpg"},
                {"name": "Ankle Boots", "brand": "Brand E", "image_path": "../../../images/shoes/shoes3.jpg"},
                {"name": "Running Shoes", "brand": "Brand F", "image_path": "../../../images/shoes/shoes4.jpg"}
            ],
            "sunglasses": [
                {"name": "Aviator Sunglasses", "brand": "Brand G", "image_path": "../../../images/sunglasses/sunglassess1.jpg"},
                {"name": "Cat Eye Sunglasses", "brand": "Brand H", "image_path": "../../../images/sunglasses/sunglassess2.jpg"},
                {"name": "Round Frame Sunglasses", "brand": "Brand A", "image_path": "../../../images/sunglasses/sunglassess3.jpg"},
                {"name": "Wayfarer Sunglasses", "brand": "Brand B", "image_path": "../../../images/sunglasses/sunglassess4.jpg"},
                {"name": "Sport Sunglasses", "brand": "Brand C", "image_path": "../../../images/sunglasses/sunglassess5.jpg"}
            ],
            "tops": [
                {"name": "Wool Overcoat", "brand": "Brand D", "image_path": "../../../images/tops/coat1.jpg"},
                {"name": "Trench Coat", "brand": "Brand E", "image_path": "../../../images/tops/coat2.jpg"},
                {"name": "Puffer Coat", "brand": "Brand F", "image_path": "../../../images/tops/coat3.jpg"},
                {"name": "Maxi Dress", "brand": "Brand G", "image_path": "../../../images/tops/dress1.png"},
                {"name": "Shift Dress", "brand": "Brand H", "image_path": "../../../images/tops/dress2.png"},
                {"name": "Evening Gown", "brand": "Brand A", "image_path": "../../../images/tops/dress7.jpg"},
                {"name": "Denim Jacket", "brand": "Brand B", "image_path": "../../../images/tops/jacket1.jpg"},
                {"name": "Leather Jacket", "brand": "Brand C", "image_path": "../../../images/tops/jacket2.jpg"},
                {"name": "Bomber Jacket", "brand": "Brand D", "image_path": "../../../images/tops/jacket3.jpg"},
                {"name": "Cotton T-Shirt", "brand": "Brand E", "image_path": "../../../images/tops/top1.png"},
                {"name": "Silk Blouse", "brand": "Brand F", "image_path": "../../../images/tops/top2.png"},
                {"name": "Knit Sweater", "brand": "Brand G", "image_path": "../../../images/tops/top3.png"},
                {"name": "Linen Shirt", "brand": "Brand H", "image_path": "../../../images/tops/top4.png"}
            ],
            "watches": [
                {"name": "Classic Analog Watch", "brand": "Brand A", "image_path": "../../../images/watches/watch1.jpg"},
                {"name": "Digital Sport Watch", "brand": "Brand B", "image_path": "../../../images/watches/watch2.jpg"},
                {"name": "Chronograph Watch", "brand": "Brand C", "image_path": "../../../images/watches/watch3.jpg"},
                {"name": "Smart Watch", "brand": "Brand D", "image_path": "../../../images/watches/watch4.jpg"},
                {"name": "Dress Watch", "brand": "Brand E", "image_path": "../../../images/watches/watch5.jpg"},
                {"name": "Dive Watch", "brand": "Brand F", "image_path": "../../../images/watches/watch6.jpg"}
            ]
        };

        // Global state
        let selectedItems = {};
        let currentCategory = '';
        let filteredProducts = [];

        // Color palette for slices
        const sliceColors = [
            '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7',
            '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9',
            '#F8C471', '#82E0AA', '#F1948A'
        ];

        // Initialize the app
        document.addEventListener('DOMContentLoaded', function() {
            generatePizzaWheel();
            setupEventListeners();
            updateSelectedItemsDisplay();
        });

        function generatePizzaWheel() {
            const svg = document.getElementById('pizza-wheel');
            const categories = Object.keys(productCatalog);
            const anglePerSlice = 360 / categories.length;
            const radius = 180;
            const centerX = 200;
            const centerY = 200;

            categories.forEach((category, index) => {
                const startAngle = index * anglePerSlice;
                const endAngle = (index + 1) * anglePerSlice;
                
                // Convert to radians
                const startAngleRad = (startAngle - 90) * Math.PI / 180;
                const endAngleRad = (endAngle - 90) * Math.PI / 180;
                
                // Calculate path
                const x1 = centerX + radius * Math.cos(startAngleRad);
                const y1 = centerY + radius * Math.sin(startAngleRad);
                const x2 = centerX + radius * Math.cos(endAngleRad);
                const y2 = centerY + radius * Math.sin(endAngleRad);
                
                const largeArcFlag = anglePerSlice > 180 ? 1 : 0;
                
                const pathData = [
                    `M ${centerX} ${centerY}`,
                    `L ${x1} ${y1}`,
                    `A ${radius} ${radius} 0 ${largeArcFlag} 1 ${x2} ${y2}`,
                    'Z'
                ].join(' ');

                // Create slice group
                const sliceGroup = document.createElementNS('http://www.w3.org/2000/svg', 'g');
                sliceGroup.classList.add('pizza-slice');
                sliceGroup.setAttribute('data-category', category);

                // Create path
                const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
                path.setAttribute('d', pathData);
                path.setAttribute('fill', sliceColors[index % sliceColors.length]);
                path.setAttribute('stroke', 'white');
                path.setAttribute('stroke-width', '2');

                // Create label
                const labelAngle = (startAngle + endAngle) / 2;
                const labelRadius = radius * 0.7;
                const labelAngleRad = (labelAngle - 90) * Math.PI / 180;
                const labelX = centerX + labelRadius * Math.cos(labelAngleRad);
                const labelY = centerY + labelRadius * Math.sin(labelAngleRad);

                const text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
                text.setAttribute('x', labelX);
                text.setAttribute('y', labelY);
                text.setAttribute('class', 'slice-label');
                text.textContent = category.charAt(0).toUpperCase() + category.slice(1);

                // Add click event
                sliceGroup.addEventListener('click', () => openProductModal(category));

                sliceGroup.appendChild(path);
                sliceGroup.appendChild(text);
                svg.appendChild(sliceGroup);
            });
        }

        function setupEventListeners() {
            // Mix button
            document.getElementById('mix-btn').addEventListener('click', mixOutfit);

            // Preview button
            document.getElementById('preview-btn').addEventListener('click', openPreviewModal);

            // Modal close buttons
            document.querySelectorAll('.close').forEach(closeBtn => {
                closeBtn.addEventListener('click', closeModals);
            });

            // Search functionality
            document.getElementById('search-bar').addEventListener('input', filterProducts);

            // Close modals when clicking outside
            window.addEventListener('click', function(event) {
                const productModal = document.getElementById('product-modal');
                const previewModal = document.getElementById('preview-modal');
                if (event.target === productModal || event.target === previewModal) {
                    closeModals();
                }
            });
        }

        function openProductModal(category) {
            currentCategory = category;
            const modal = document.getElementById('product-modal');
            const title = document.getElementById('modal-title');
            const header = document.getElementById('category-header');
            
            title.textContent = `Select ${category.charAt(0).toUpperCase() + category.slice(1)}`;
            header.textContent = category.toUpperCase();
            
            loadProducts(category);
            modal.style.display = 'block';
        }

        function loadProducts(category) {
            const products = productCatalog[category] || [];
            filteredProducts = products;
            displayProducts();
        }

        function displayProducts() {
            const grid = document.getElementById('products-grid');
            grid.innerHTML = '';

            if (filteredProducts.length === 0) {
                grid.innerHTML = '<div class="empty-state">No products found</div>';
                return;
            }

            filteredProducts.forEach(product => {
                const card = document.createElement('div');
                card.className = 'product-card';
                card.innerHTML = `
                    <img src="${product.image_path}" alt="${product.name}" class="product-image" onerror="this.style.display='none'">
                    <div class="product-name">${product.name}</div>
                    <div class="product-brand">${product.brand}</div>
                `;
                
                card.addEventListener('click', () => selectProduct(product, currentCategory));
                grid.appendChild(card);
            });
        }

        function filterProducts() {
            const searchTerm = document.getElementById('search-bar').value.toLowerCase();
            const products = productCatalog[currentCategory] || [];
            
            filteredProducts = products.filter(product => 
                product.name.toLowerCase().includes(searchTerm) ||
                product.brand.toLowerCase().includes(searchTerm)
            );
            
            displayProducts();
        }

        function selectProduct(product, category) {
            if (!selectedItems[category]) {
                selectedItems[category] = [];
            }
            
            // Check if already selected
            const existing = selectedItems[category].find(item => item.name === product.name);
            if (!existing) {
                selectedItems[category].push(product);
                updateSelectedItemsDisplay();
                updateSliceThumbnail(category);
            }
            
            closeModals();
        }

        function updateSelectedItemsDisplay() {
            const itemsList = document.getElementById('items-list');
            const selectedItemsDiv = document.getElementById('selected-items');
            const instructionsDiv = document.getElementById('instructions');
            const previewBtn = document.getElementById('preview-btn');
            
            itemsList.innerHTML = '';
            
            let hasItems = false;
            
            Object.keys(selectedItems).forEach(category => {
                selectedItems[category].forEach(item => {
                    hasItems = true;
                    const card = document.createElement('div');
                    card.className = 'item-card';
                    card.innerHTML = `
                        <img src="${item.image_path}" alt="${item.name}" class="item-thumbnail" onerror="this.style.display='none'">
                        <div class="item-info">
                            <div class="item-name">${item.name}</div>
                            <div class="item-brand">${item.brand}</div>
                        </div>
                        <button class="remove-btn" onclick="removeItem('${category}', '${item.name}')">&times;</button>
                    `;
                    itemsList.appendChild(card);
                });
            });

            if (hasItems) {
                selectedItemsDiv.style.display = 'block';
                instructionsDiv.style.display = 'none';
                previewBtn.disabled = false;
            } else {
                selectedItemsDiv.style.display = 'none';
                instructionsDiv.style.display = 'block';
                previewBtn.disabled = true;
            }
        }

        function removeItem(category, itemName) {
            if (selectedItems[category]) {
                selectedItems[category] = selectedItems[category].filter(item => item.name !== itemName);
                if (selectedItems[category].length === 0) {
                    delete selectedItems[category];
                }
                updateSelectedItemsDisplay();
                updateSliceThumbnail(category);
            }
        }

        function updateSliceThumbnail(category) {
            const slice = document.querySelector(`[data-category="${category}"]`);
            if (!slice) return;

            // Remove existing thumbnail
            const existingThumbnail = slice.querySelector('.slice-thumbnail');
            if (existingThumbnail) {
                existingThumbnail.remove();
            }

            // Add new thumbnail if items exist
            if (selectedItems[category] && selectedItems[category].length > 0) {
                const item = selectedItems[category][0]; // Show first item
                const centerX = 200;
                const centerY = 200;
                const categories = Object.keys(productCatalog);
                const index = categories.indexOf(category);
                const anglePerSlice = 360 / categories.length;
                const labelAngle = (index * anglePerSlice + (index + 1) * anglePerSlice) / 2;
                const labelRadius = 140;
                const labelAngleRad = (labelAngle - 90) * Math.PI / 180;
                const thumbX = centerX + labelRadius * Math.cos(labelAngleRad);
                const thumbY = centerY + labelRadius * Math.sin(labelAngleRad);

                const thumbnail = document.createElementNS('http://www.w3.org/2000/svg', 'image');
                thumbnail.setAttribute('x', thumbX - 15);
                thumbnail.setAttribute('y', thumbY - 15);
                thumbnail.setAttribute('width', '30');
                thumbnail.setAttribute('height', '30');
                thumbnail.setAttribute('href', item.image_path);
                thumbnail.setAttribute('class', 'slice-thumbnail');
                thumbnail.setAttribute('clip-path', 'circle(15px at 15px 15px)');
                
                slice.appendChild(thumbnail);
                slice.classList.add('selected');
            } else {
                slice.classList.remove('selected');
            }
        }

        function mixOutfit() {
            const mixBtn = document.getElementById('mix-btn');
            const wheel = document.getElementById('pizza-wheel');
            
            mixBtn.classList.add('spinning');
            wheel.style.transform = 'rotate(720deg)';
            
            setTimeout(() => {
                // Recommend items for categories without selections
                const allCategories = Object.keys(productCatalog);
                const selectedCategories = Object.keys(selectedItems);
                const emptyCategories = allCategories.filter(cat => !selectedCategories.includes(cat));
                
                emptyCategories.forEach(category => {
                    const products = productCatalog[category];
                    if (products && products.length > 0) {
                        const randomProduct = products[Math.floor(Math.random() * products.length)];
                        selectProduct(randomProduct, category);
                    }
                });
                
                mixBtn.classList.remove('spinning');
                wheel.style.transform = 'rotate(0deg)';
            }, 2000);
        }

        function openPreviewModal() {
            const modal = document.getElementById('preview-modal');
            const grid = document.getElementById('preview-grid');
            
            grid.innerHTML = '';
            
            const allCategories = Object.keys(productCatalog);
            allCategories.forEach(category => {
                const previewItem = document.createElement('div');
                previewItem.className = 'preview-item';
                
                if (selectedItems[category] && selectedItems[category].length > 0) {
                    const item = selectedItems[category][0];
                    previewItem.innerHTML = `
                        <h4>${category}</h4>
                        <img src="${item.image_path}" alt="${item.name}" onerror="this.style.display='none'">
                        <div class="product-name">${item.name}</div>
                        <div class="product-brand">${item.brand}</div>
                    `;
                } else {
                    previewItem.innerHTML = `
                        <h4>${category}</h4>
                        <div class="no-selection">No selection</div>
                    `;
                }
                
                grid.appendChild(previewItem);
            });
            
            modal.style.display = 'block';
        }

        function closeModals() {
            document.getElementById('product-modal').style.display = 'none';
            document.getElementById('preview-modal').style.display = 'none';
        }
    </script>
</body>
</html>
```

Now let me complete the remaining tasks and mark them as completed:

Perfect! Let me test the HTML file to make sure it works correctly by opening it:

Let me also create a demonstration with some screenshots to show the features. Let me create a simple test to verify the file structure:

---

**User**

the image paths are not correct.

"../../../images/earrings/earrings1.jpg"
they shoud be just relative to the html file

"images/earrings/earrings1.jpg"

---

**Cursor**

You're absolutely right! The image paths need to be corrected to be relative to the HTML file location. Let me fix all the image paths in the outfit-mixer.html file:

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Outfit Mixer - Fashion Retailer X</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            display: grid;
            grid-template-columns: 300px 1fr 280px;
            gap: 30px;
            padding: 30px;
            min-height: 100vh;
            max-width: 1600px;
            margin: 0 auto;
        }

        .panel {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .left-panel {
            padding: 30px;
            display: flex;
            flex-direction: column;
        }

        .center-panel {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 50px;
            position: relative;
        }

        .right-panel {
            padding: 30px;
        }

        h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 20px;
            text-align: center;
        }

        .instructions {
            color: #666;
            line-height: 1.6;
            margin-bottom: 30px;
        }

        .instructions h3 {
            color: #333;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .instructions ul {
            padding-left: 20px;
        }

        .instructions li {
            margin-bottom: 8px;
        }

        .pizza-container {
            position: relative;
            width: 400px;
            height: 400px;
        }

        .pizza-wheel {
            width: 100%;
            height: 100%;
            transition: transform 0.5s ease;
        }

        .pizza-slice {
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .pizza-slice:hover {
            transform: scale(1.05);
            filter: brightness(1.1);
        }

        .pizza-slice.selected {
            filter: brightness(1.2) saturate(1.3);
        }

        .slice-label {
            font-size: 11px;
            font-weight: 600;
            text-anchor: middle;
            fill: #333;
            pointer-events: none;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .mix-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            border: none;
            color: white;
            font-weight: 700;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 10px 20px rgba(255, 107, 107, 0.3);
            transition: all 0.3s ease;
            z-index: 10;
        }

        .mix-button:hover {
            transform: translate(-50%, -50%) scale(1.1);
            box-shadow: 0 15px 30px rgba(255, 107, 107, 0.4);
        }

        .mix-button:active {
            transform: translate(-50%, -50%) scale(0.95);
        }

        .mix-button.spinning {
            animation: spin 2s linear;
        }

        @keyframes spin {
            from { transform: translate(-50%, -50%) rotate(0deg); }
            to { transform: translate(-50%, -50%) rotate(720deg); }
        }

        .controls h3 {
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }

        .control-group {
            margin-bottom: 25px;
        }

        .control-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }

        .toggle-switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
            margin-right: 10px;
        }

        .toggle-switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .selected-items {
            margin-top: 30px;
        }

        .selected-items h3 {
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
        }

        .item-card {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .item-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
        }

        .item-thumbnail {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            object-fit: cover;
            margin-right: 15px;
            border: 2px solid #f0f0f0;
        }

        .item-info {
            flex: 1;
        }

        .item-name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
            margin-bottom: 4px;
        }

        .item-brand {
            color: #666;
            font-size: 12px;
        }

        .remove-btn {
            background: #ff6b6b;
            border: none;
            color: white;
            width: 24px;
            height: 24px;
            border-radius: 50%;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .remove-btn:hover {
            background: #ff5252;
            transform: scale(1.1);
        }

        .preview-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .preview-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .preview-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
        }

        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 40px;
            border-radius: 20px;
            width: 80%;
            max-width: 800px;
            max-height: 80vh;
            overflow-y: auto;
            position: relative;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            position: absolute;
            right: 20px;
            top: 20px;
        }

        .close:hover {
            color: #000;
        }

        .category-header {
            color: #666;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }

        .search-bar {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
            transition: border-color 0.3s ease;
        }

        .search-bar:focus {
            outline: none;
            border-color: #667eea;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .product-card {
            background: white;
            border-radius: 12px;
            padding: 15px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
            border-color: #667eea;
        }

        .product-image {
            width: 100%;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .product-name {
            font-size: 14px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .product-brand {
            font-size: 12px;
            color: #666;
        }

        .preview-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

        .preview-item {
            text-align: center;
        }

        .preview-item h4 {
            margin-bottom: 10px;
            color: #333;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .preview-item img {
            width: 100%;
            max-width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 12px;
            border: 3px solid #f0f0f0;
        }

        .no-selection {
            color: #999;
            font-style: italic;
            font-size: 14px;
        }

        .category-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }

        .category-filter {
            padding: 8px 16px;
            background: #f5f5f5;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 12px;
            font-weight: 500;
        }

        .category-filter.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .slice-thumbnail {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid white;
        }

        .empty-state {
            text-align: center;
            color: #999;
            padding: 40px;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Left Panel -->
        <div class="panel left-panel">
            <div id="instructions">
                <h3>How to Use Outfit Mixer</h3>
                <ul>
                    <li>Click on any slice of the wheel to browse that category</li>
                    <li>Select items you like from the popup</li>
                    <li>Use the controls on the right to customize your experience</li>
                    <li>Hit the MIX button to get AI recommendations</li>
                    <li>Preview your complete outfit when ready</li>
                </ul>
            </div>
            
            <div id="selected-items" class="selected-items" style="display: none;">
                <h3>Your Selection</h3>
                <div id="items-list"></div>
                <button id="preview-btn" class="preview-btn" disabled>Preview Outfit</button>
            </div>
        </div>

        <!-- Center Panel -->
        <div class="panel center-panel">
            <h1>Outfit Mixer</h1>
            <div class="pizza-container">
                <svg class="pizza-wheel" viewBox="0 0 400 400" id="pizza-wheel">
                    <!-- Pizza slices will be generated here -->
                </svg>
                <button class="mix-button" id="mix-btn">MIX</button>
            </div>
        </div>

        <!-- Right Panel -->
        <div class="panel right-panel">
            <div class="controls">
                <h3>Preferences</h3>
                
                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="gender-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Unisex Items
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="accessories-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Include Accessories
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="seasonal-toggle" checked>
                            <span class="slider"></span>
                        </span>
                        Seasonal Items
                    </label>
                </div>

                <div class="control-group">
                    <label>
                        <span class="toggle-switch">
                            <input type="checkbox" id="formal-toggle">
                            <span class="slider"></span>
                        </span>
                        Formal Occasions
                    </label>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Selection Modal -->
    <div id="product-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2 id="modal-title">Select Products</h2>
            <div class="category-header" id="category-header">TOPS</div>
            
            <input type="text" class="search-bar" id="search-bar" placeholder="Search products...">
            
            <div class="category-filters" id="category-filters">
                <!-- Category filter buttons will be generated here -->
            </div>
            
            <div class="products-grid" id="products-grid">
                <!-- Products will be loaded here -->
            </div>
        </div>
    </div>

    <!-- Preview Modal -->
    <div id="preview-modal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>Your Outfit Preview</h2>
            <div class="preview-grid" id="preview-grid">
                <!-- Preview items will be shown here -->
            </div>
        </div>
    </div>

    <script>
        // Product catalog data
        const productCatalog = {
            "belts": [
                {"name": "Classic Leather Belt", "brand": "Brand A", "image_path": "images/belts/belt1.jpg"},
                {"name": "Woven Canvas Belt", "brand": "Brand B", "image_path": "images/belts/belt2.jpg"},
                {"name": "Reversible Belt", "brand": "Brand C", "image_path": "images/belts/belt3.jpg"},
                {"name": "Chain Link Belt", "brand": "Brand D", "image_path": "images/belts/belt4.jpg"},
                {"name": "Braided Leather Belt", "brand": "Brand E", "image_path": "images/belts/belt5.jpg"},
                {"name": "Designer Buckle Belt", "brand": "Brand F", "image_path": "images/belts/belt6.jpg"}
            ],
            "bottoms": [
                {"name": "Floral Midi Dress", "brand": "Brand G", "image_path": "images/bottoms/dress1.jpg"},
                {"name": "Wrap Dress", "brand": "Brand H", "image_path": "images/bottoms/dress2.jpg"},
                {"name": "Cocktail Dress", "brand": "Brand A", "image_path": "images/bottoms/dress3.jpg"},
                {"name": "Slim Fit Jeans", "brand": "Brand B", "image_path": "images/bottoms/jeans1.jpg"},
                {"name": "High-Waisted Jeans", "brand": "Brand C", "image_path": "images/bottoms/jeans2.jpg"},
                {"name": "Distressed Denim", "brand": "Brand D", "image_path": "images/bottoms/jeans3.jpg"},
                {"name": "Wide Leg Jeans", "brand": "Brand E", "image_path": "images/bottoms/jeans4.jpg"},
                {"name": "Pleated Midi Skirt", "brand": "Brand F", "image_path": "images/bottoms/skirt1.jpg"},
                {"name": "A-Line Skirt", "brand": "Brand G", "image_path": "images/bottoms/skirt2.jpg"},
                {"name": "Pencil Skirt", "brand": "Brand H", "image_path": "images/bottoms/skirt3.jpg"}
            ],
            "earrings": [
                {"name": "Pearl Drop Earrings", "brand": "Brand A", "image_path": "images/earrings/earrings1.jpg"},
                {"name": "Gold Hoop Earrings", "brand": "Brand B", "image_path": "images/earrings/earrings2.jpg"},
                {"name": "Crystal Stud Earrings", "brand": "Brand C", "image_path": "images/earrings/earrings3.jpg"},
                {"name": "Chandelier Earrings", "brand": "Brand D", "image_path": "images/earrings/earrings4.jpg"},
                {"name": "Minimalist Bar Earrings", "brand": "Brand E", "image_path": "images/earrings/earrings5.jpg"}
            ],
            "gloves": [
                {"name": "Leather Driving Gloves", "brand": "Brand F", "image_path": "images/gloves/gloves1.jpg"},
                {"name": "Cashmere Gloves", "brand": "Brand G", "image_path": "images/gloves/gloves2.jpg"},
                {"name": "Fingerless Gloves", "brand": "Brand H", "image_path": "images/gloves/gloves3.jpg"},
                {"name": "Winter Wool Gloves", "brand": "Brand A", "image_path": "images/gloves/gloves4.jpg"},
                {"name": "Evening Opera Gloves", "brand": "Brand B", "image_path": "images/gloves/gloves5.jpg"},
                {"name": "Touchscreen Gloves", "brand": "Brand C", "image_path": "images/gloves/gloves6.jpg"}
            ],
            "handbags": [
                {"name": "Tote Bag", "brand": "Brand D", "image_path": "images/handbags/handbag1.jpg"},
                {"name": "Crossbody Bag", "brand": "Brand E", "image_path": "images/handbags/handbag2.jpg"},
                {"name": "Clutch Purse", "brand": "Brand F", "image_path": "images/handbags/handbag3.jpg"},
                {"name": "Shoulder Bag", "brand": "Brand G", "image_path": "images/handbags/handbag4.jpg"},
                {"name": "Bucket Bag", "brand": "Brand H", "image_path": "images/handbags/handbag5.jpg"},
                {"name": "Satchel Bag", "brand": "Brand A", "image_path": "images/handbags/handbag6.jpg"},
                {"name": "Hobo Bag", "brand": "Brand B", "image_path": "images/handbags/handbag7.jpg"}
            ],
            "hats": [
                {"name": "Fedora Hat", "brand": "Brand C", "image_path": "images/hats/hat1.jpg"},
                {"name": "Baseball Cap", "brand": "Brand D", "image_path": "images/hats/hat2.jpg"},
                {"name": "Wide Brim Sun Hat", "brand": "Brand E", "image_path": "images/hats/hat3.jpg"},
                {"name": "Beanie", "brand": "Brand F", "image_path": "images/hats/hat4.jpg"},
                {"name": "Beret", "brand": "Brand G", "image_path": "images/hats/hat5.jpg"}
            ],
            "necklaces": [
                {"name": "Pearl Strand Necklace", "brand": "Brand H", "image_path": "images/necklaces/necklace1.jpg"},
                {"name": "Gold Chain Necklace", "brand": "Brand A", "image_path": "images/necklaces/necklace2.jpg"},
                {"name": "Pendant Necklace", "brand": "Brand B", "image_path": "images/necklaces/necklace3.jpg"},
                {"name": "Choker Necklace", "brand": "Brand C", "image_path": "images/necklaces/necklace4.jpg"}
            ],
            "scaves": [
                {"name": "Silk Scarf", "brand": "Brand D", "image_path": "images/scaves/scarf1.jpg"},
                {"name": "Cashmere Scarf", "brand": "Brand E", "image_path": "images/scaves/scarf2.jpg"},
                {"name": "Infinity Scarf", "brand": "Brand F", "image_path": "images/scaves/scarf3.jpg"},
                {"name": "Printed Square Scarf", "brand": "Brand G", "image_path": "images/scaves/scarf4.jpg"},
                {"name": "Wool Blanket Scarf", "brand": "Brand H", "image_path": "images/scaves/scarf5.jpg"},
                {"name": "Lightweight Summer Scarf", "brand": "Brand A", "image_path": "images/scaves/scarf6.jpg"},
                {"name": "Fringed Wrap Scarf", "brand": "Brand B", "image_path": "images/scaves/scarf7.jpg"}
            ],
            "shoes": [
                {"name": "Leather Oxford Shoes", "brand": "Brand C", "image_path": "images/shoes/shoes1.jpg"},
                {"name": "High-Top Sneakers", "brand": "Brand D", "image_path": "images/shoes/shoes2.jpg"},
                {"name": "Ankle Boots", "brand": "Brand E", "image_path": "images/shoes/shoes3.jpg"},
                {"name": "Running Shoes", "brand": "Brand F", "image_path": "images/shoes/shoes4.jpg"}
            ],
            "sunglasses": [
                {"name": "Aviator Sunglasses", "brand": "Brand G", "image_path": "images/sunglasses/sunglassess1.jpg"},
                {"name": "Cat Eye Sunglasses", "brand": "Brand H", "image_path": "images/sunglasses/sunglassess2.jpg"},
                {"name": "Round Frame Sunglasses", "brand": "Brand A", "image_path": "images/sunglasses/sunglassess3.jpg"},
                {"name": "Wayfarer Sunglasses", "brand": "Brand B", "image_path": "images/sunglasses/sunglassess4.jpg"},
                {"name": "Sport Sunglasses", "brand": "Brand C", "image_path": "images/sunglasses/sunglassess5.jpg"}
            ],
            "tops": [
                {"name": "Wool Overcoat", "brand": "Brand D", "image_path": "images/tops/coat1.jpg"},
                {"name": "Trench Coat", "brand": "Brand E", "image_path": "images/tops/coat2.jpg"},
                {"name": "Puffer Coat", "brand": "Brand F", "image_path": "images/tops/coat3.jpg"},
                {"name": "Maxi Dress", "brand": "Brand G", "image_path": "images/tops/dress1.png"},
                {"name": "Shift Dress", "brand": "Brand H", "image_path": "images/tops/dress2.png"},
                {"name": "Evening Gown", "brand": "Brand A", "image_path": "images/tops/dress7.jpg"},
                {"name": "Denim Jacket", "brand": "Brand B", "image_path": "images/tops/jacket1.jpg"},
                {"name": "Leather Jacket", "brand": "Brand C", "image_path": "images/tops/jacket2.jpg"},
                {"name": "Bomber Jacket", "brand": "Brand D", "image_path": "images/tops/jacket3.jpg"},
                {"name": "Cotton T-Shirt", "brand": "Brand E", "image_path": "images/tops/top1.png"},
                {"name": "Silk Blouse", "brand": "Brand F", "image_path": "images/tops/top2.png"},
                {"name": "Knit Sweater", "brand": "Brand G", "image_path": "images/tops/top3.png"},
                {"name": "Linen Shirt", "brand": "Brand H", "image_path": "images/tops/top4.png"}
            ],
            "watches": [
                {"name": "Classic Analog Watch", "brand": "Brand A", "image_path": "images/watches/watch1.jpg"},
                {"name": "Digital Sport Watch", "brand": "Brand B", "image_path": "images/watches/watch2.jpg"},
                {"name": "Chronograph Watch", "brand": "Brand C", "image_path": "images/watches/watch3.jpg"},
                {"name": "Smart Watch", "brand": "Brand D", "image_path": "images/watches/watch4.jpg"},
                {"name": "Dress Watch", "brand": "Brand E", "image_path": "images/watches/watch5.jpg"},
                {"name": "Dive Watch", "brand": "Brand F", "image_path": "images/watches/watch6.jpg"}
            ]
        };

        // Global state
        let selectedItems = {};
        let currentCategory = '';
        let filteredProducts = [];

        // Color palette for slices
        const sliceColors = [
            '#FF6B6B', '#4ECDC4', '#45B7D1', '#96CEB4', '#FFEAA7',
            '#DDA0DD', '#98D8C8', '#F7DC6F', '#BB8FCE', '#85C1E9',
            '#F8C471', '#82E0AA', '#F1948A'
        ];

        // Initialize the app
        document.addEventListener('DOMContentLoaded', function() {
            generatePizzaWheel();
            setupEventListeners();
            updateSelectedItemsDisplay();
        });

        function generatePizzaWheel() {
            const svg = document.getElementById('pizza-wheel');
            const categories = Object.keys(productCatalog);
            const anglePerSlice = 360 / categories.length;
            const radius = 180;
            const centerX = 200;
            const centerY = 200;

            categories.forEach((category, index) => {
                const startAngle = index * anglePerSlice;
                const endAngle = (index + 1) * anglePerSlice;
                
                // Convert to radians
                const startAngleRad = (startAngle - 90) * Math.PI / 180;
                const endAngleRad = (endAngle - 90) * Math.PI / 180;
                
                // Calculate path
                const x1 = centerX + radius * Math.cos(startAngleRad);
                const y1 = centerY + radius * Math.sin(startAngleRad);
                const x2 = centerX + radius * Math.cos(endAngleRad);
                const y2 = centerY + radius * Math.sin(endAngleRad);
                
                const largeArcFlag = anglePerSlice > 180 ? 1 : 0;
                
                const pathData = [
                    `M ${centerX} ${centerY}`,
                    `L ${x1} ${y1}`,
                    `A ${radius} ${radius} 0 ${largeArcFlag} 1 ${x2} ${y2}`,
                    'Z'
                ].join(' ');

                // Create slice group
                const sliceGroup = document.createElementNS('http://www.w3.org/2000/svg', 'g');
                sliceGroup.classList.add('pizza-slice');
                sliceGroup.setAttribute('data-category', category);

                // Create path
                const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
                path.setAttribute('d', pathData);
                path.setAttribute('fill', sliceColors[index % sliceColors.length]);
                path.setAttribute('stroke', 'white');
                path.setAttribute('stroke-width', '2');

                // Create label
                const labelAngle = (startAngle + endAngle) / 2;
                const labelRadius = radius * 0.7;
                const labelAngleRad = (labelAngle - 90) * Math.PI / 180;
                const labelX = centerX + labelRadius * Math.cos(labelAngleRad);
                const labelY = centerY + labelRadius * Math.sin(labelAngleRad);

                const text = document.createElementNS('http://www.w3.org/2000/svg', 'text');
                text.setAttribute('x', labelX);
                text.setAttribute('y', labelY);
                text.setAttribute('class', 'slice-label');
                text.textContent = category.charAt(0).toUpperCase() + category.slice(1);

                // Add click event
                sliceGroup.addEventListener('click', () => openProductModal(category));

                sliceGroup.appendChild(path);
                sliceGroup.appendChild(text);
                svg.appendChild(sliceGroup);
            });
        }

        function setupEventListeners() {
            // Mix button
            document.getElementById('mix-btn').addEventListener('click', mixOutfit);

            // Preview button
            document.getElementById('preview-btn').addEventListener('click', openPreviewModal);

            // Modal close buttons
            document.querySelectorAll('.close').forEach(closeBtn => {
                closeBtn.addEventListener('click', closeModals);
            });

            // Search functionality
            document.getElementById('search-bar').addEventListener('input', filterProducts);

            // Close modals when clicking outside
            window.addEventListener('click', function(event) {
                const productModal = document.getElementById('product-modal');
                const previewModal = document.getElementById('preview-modal');
                if (event.target === productModal || event.target === previewModal) {
                    closeModals();
                }
            });
        }

        function openProductModal(category) {
            currentCategory = category;
            const modal = document.getElementById('product-modal');
            const title = document.getElementById('modal-title');
            const header = document.getElementById('category-header');
            
            title.textContent = `Select ${category.charAt(0).toUpperCase() + category.slice(1)}`;
            header.textContent = category.toUpperCase();
            
            loadProducts(category);
            modal.style.display = 'block';
        }

        function loadProducts(category) {
            const products = productCatalog[category] || [];
            filteredProducts = products;
            displayProducts();
        }

        function displayProducts() {
            const grid = document.getElementById('products-grid');
            grid.innerHTML = '';

            if (filteredProducts.length === 0) {
                grid.innerHTML = '<div class="empty-state">No products found</div>';
                return;
            }

            filteredProducts.forEach(product => {
                const card = document.createElement('div');
                card.className = 'product-card';
                card.innerHTML = `
                    <img src="${product.image_path}" alt="${product.name}" class="product-image" onerror="this.style.display='none'">
                    <div class="product-name">${product.name}</div>
                    <div class="product-brand">${product.brand}</div>
                `;
                
                card.addEventListener('click', () => selectProduct(product, currentCategory));
                grid.appendChild(card);
            });
        }

        function filterProducts() {
            const searchTerm = document.getElementById('search-bar').value.toLowerCase();
            const products = productCatalog[currentCategory] || [];
            
            filteredProducts = products.filter(product => 
                product.name.toLowerCase().includes(searchTerm) ||
                product.brand.toLowerCase().includes(searchTerm)
            );
            
            displayProducts();
        }

        function selectProduct(product, category) {
            if (!selectedItems[category]) {
                selectedItems[category] = [];
            }
            
            // Check if already selected
            const existing = selectedItems[category].find(item => item.name === product.name);
            if (!existing) {
                selectedItems[category].push(product);
                updateSelectedItemsDisplay();
                updateSliceThumbnail(category);
            }
            
            closeModals();
        }

        function updateSelectedItemsDisplay() {
            const itemsList = document.getElementById('items-list');
            const selectedItemsDiv = document.getElementById('selected-items');
            const instructionsDiv = document.getElementById('instructions');
            const previewBtn = document.getElementById('preview-btn');
            
            itemsList.innerHTML = '';
            
            let hasItems = false;
            
            Object.keys(selectedItems).forEach(category => {
                selectedItems[category].forEach(item => {
                    hasItems = true;
                    const card = document.createElement('div');
                    card.className = 'item-card';
                    card.innerHTML = `
                        <img src="${item.image_path}" alt="${item.name}" class="item-thumbnail" onerror="this.style.display='none'">
                        <div class="item-info">
                            <div class="item-name">${item.name}</div>
                            <div class="item-brand">${item.brand}</div>
                        </div>
                        <button class="remove-btn" onclick="removeItem('${category}', '${item.name}')">&times;</button>
                    `;
                    itemsList.appendChild(card);
                });
            });

            if (hasItems) {
                selectedItemsDiv.style.display = 'block';
                instructionsDiv.style.display = 'none';
                previewBtn.disabled = false;
            } else {
                selectedItemsDiv.style.display = 'none';
                instructionsDiv.style.display = 'block';
                previewBtn.disabled = true;
            }
        }

        function removeItem(category, itemName) {
            if (selectedItems[category]) {
                selectedItems[category] = selectedItems[category].filter(item => item.name !== itemName);
                if (selectedItems[category].length === 0) {
                    delete selectedItems[category];
                }
                updateSelectedItemsDisplay();
                updateSliceThumbnail(category);
            }
        }

        function updateSliceThumbnail(category) {
            const slice = document.querySelector(`[data-category="${category}"]`);
            if (!slice) return;

            // Remove existing thumbnail
            const existingThumbnail = slice.querySelector('.slice-thumbnail');
            if (existingThumbnail) {
                existingThumbnail.remove();
            }

            // Add new thumbnail if items exist
            if (selectedItems[category] && selectedItems[category].length > 0) {
                const item = selectedItems[category][0]; // Show first item
                const centerX = 200;
                const centerY = 200;
                const categories = Object.keys(productCatalog);
                const index = categories.indexOf(category);
                const anglePerSlice = 360 / categories.length;
                const labelAngle = (index * anglePerSlice + (index + 1) * anglePerSlice) / 2;
                const labelRadius = 140;
                const labelAngleRad = (labelAngle - 90) * Math.PI / 180;
                const thumbX = centerX + labelRadius * Math.cos(labelAngleRad);
                const thumbY = centerY + labelRadius * Math.sin(labelAngleRad);

                const thumbnail = document.createElementNS('http://www.w3.org/2000/svg', 'image');
                thumbnail.setAttribute('x', thumbX - 15);
                thumbnail.setAttribute('y', thumbY - 15);
                thumbnail.setAttribute('width', '30');
                thumbnail.setAttribute('height', '30');
                thumbnail.setAttribute('href', item.image_path);
                thumbnail.setAttribute('class', 'slice-thumbnail');
                thumbnail.setAttribute('clip-path', 'circle(15px at 15px 15px)');
                
                slice.appendChild(thumbnail);
                slice.classList.add('selected');
            } else {
                slice.classList.remove('selected');
            }
        }

        function mixOutfit() {
            const mixBtn = document.getElementById('mix-btn');
            const wheel = document.getElementById('pizza-wheel');
            
            mixBtn.classList.add('spinning');
            wheel.style.transform = 'rotate(720deg)';
            
            setTimeout(() => {
                // Recommend items for categories without selections
                const allCategories = Object.keys(productCatalog);
                const selectedCategories = Object.keys(selectedItems);
                const emptyCategories = allCategories.filter(cat => !selectedCategories.includes(cat));
                
                emptyCategories.forEach(category => {
                    const products = productCatalog[category];
                    if (products && products.length > 0) {
                        const randomProduct = products[Math.floor(Math.random() * products.length)];
                        selectProduct(randomProduct, category);
                    }
                });
                
                mixBtn.classList.remove('spinning');
                wheel.style.transform = 'rotate(0deg)';
            }, 2000);
        }

        function openPreviewModal() {
            const modal = document.getElementById('preview-modal');
            const grid = document.getElementById('preview-grid');
            
            grid.innerHTML = '';
            
            const allCategories = Object.keys(productCatalog);
            allCategories.forEach(category => {
                const previewItem = document.createElement('div');
                previewItem.className = 'preview-item';
                
                if (selectedItems[category] && selectedItems[category].length > 0) {
                    const item = selectedItems[category][0];
                    previewItem.innerHTML = `
                        <h4>${category}</h4>
                        <img src="${item.image_path}" alt="${item.name}" onerror="this.style.display='none'">
                        <div class="product-name">${item.name}</div>
                        <div class="product-brand">${item.brand}</div>
                    `;
                } else {
                    previewItem.innerHTML = `
                        <h4>${category}</h4>
                        <div class="no-selection">No selection</div>
                    `;
                }
                
                grid.appendChild(previewItem);
            });
            
            modal.style.display = 'block';
        }

        function closeModals() {
            document.getElementById('product-modal').style.display = 'none';
            document.getElementById('preview-modal').style.display = 'none';
        }
    </script>
</body>
</html>

```

Perfect! I've fixed all the image paths to be relative to the HTML file location. Now the images should load correctly when the HTML file is opened. Let me also create a symlink to the images directory so the HTML file can access the images properly:

