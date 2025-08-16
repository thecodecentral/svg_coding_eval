# Designing the outfit mixer prototype
_Exported on 8/16/2025 at 14:22:38 PDT from Cursor (1.4.2)_

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

I'll first inspect the product catalog and the available images to design the SVG pizza slices and product thumbnails.

Creating the single-page prototype with an SVG wheel, side panels, modal picker, and interactions. I'll inline the product catalog JSON and wire up functional toggles and the mix/preview behaviors, then save it as `outfit-mixer.html`.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Outfit Mixer — X</title>
  <style>
    :root {
      --bg: #0f0f10;
      --fg: #f5f6f7;
      --muted: #b9bcc2;
      --ink: #111114;
      --panel: #151619;
      --panel-2: #191a1e;
      --gold: #c8a96b;
      --accent: #7d8aff;
      --danger: #ff6b6b;
      --ok: #27d3a6;
      --ring: #2a2c31;
      --ring-2: #202227;
      --shadow: 0 10px 30px rgba(0,0,0,0.35), 0 6px 12px rgba(0,0,0,0.25);
      --radius: 14px;
    }
    * { box-sizing: border-box; }
    html, body { height: 100%; }
    body {
      margin: 0;
      background: linear-gradient(135deg, #0b0b0c, #16171b 40%, #0e0f12);
      color: var(--fg);
      font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      overflow: hidden;
    }

    .shell {
      display: grid;
      grid-template-columns: 360px 1fr 320px;
      gap: 18px;
      height: 100vh;
      padding: 18px 18px 22px;
    }
    .panel {
      background: linear-gradient(180deg, var(--panel), var(--panel-2));
      border: 1px solid #1f2126;
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      overflow: hidden;
      position: relative;
    }
    .panel-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 16px 18px;
      border-bottom: 1px solid #23252b;
      background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0));
    }
    .panel-title {
      letter-spacing: 0.12em;
      font-size: 12px;
      text-transform: uppercase;
      color: var(--muted);
    }
    .left-body, .right-body {
      height: calc(100% - 54px);
      overflow: auto;
      padding: 16px 18px 18px;
    }
    .center-body { height: 100%; position: relative; }

    /* Left: instructions / selections card flip */
    .flip {
      perspective: 1200px;
      height: 100%;
    }
    .flip-inner {
      position: relative;
      width: 100%;
      height: 100%;
      transform-style: preserve-3d;
      transition: transform 700ms cubic-bezier(.2,.7,.2,1);
    }
    .flip.show-preview .flip-inner { transform: rotateY(180deg); }
    .flip-face {
      position: absolute;
      inset: 0;
      backface-visibility: hidden;
      padding: 0 18px 18px;
    }
    .flip-face.back { transform: rotateY(180deg); }
    .instructions {
      color: var(--muted);
      line-height: 1.6;
      padding-top: 4px;
    }
    .instructions b { color: var(--fg); }
    .cta-row { display: flex; gap: 10px; margin-top: 14px; }
    .btn {
      appearance: none; border: 0; cursor: pointer; border-radius: 999px;
      padding: 10px 14px; color: #0c0d10; background: var(--fg); font-weight: 600;
      transition: transform .12s ease, box-shadow .2s ease, background .2s ease;
      box-shadow: 0 6px 18px rgba(255,255,255,.08);
    }
    .btn:hover { transform: translateY(-1px); }
    .btn:active { transform: translateY(0); }
    .btn.secondary { background: #22252d; color: var(--fg); border: 1px solid #2a2d35; }
    .btn.ghost { background: transparent; color: var(--muted); border: 1px solid #2a2d35; }
    .btn.gold { background: var(--gold); color: #151515; }

    .selections { display: none; }
    .selections.visible { display: block; }

    .sel-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .sel-table th, .sel-table td { padding: 8px 6px; border-bottom: 1px solid #24262c; }
    .sel-table th { text-align: left; font-size: 12px; color: var(--muted); font-weight: 600; letter-spacing: .06em; text-transform: uppercase; }
    .thumb { width: 44px; height: 44px; border-radius: 8px; object-fit: cover; border: 1px solid #2a2d35; }
    .remove { color: var(--danger); background: transparent; border: 0; cursor: pointer; font-weight: 700; }

    .preview-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; padding-top: 12px; }
    .preview-grid img { width: 100%; aspect-ratio: 1/1; object-fit: cover; border-radius: 10px; border: 1px solid #2a2d35; box-shadow: 0 4px 14px rgba(0,0,0,0.25); }

    /* Center: Wheel */
    .wheel-wrap { position: absolute; inset: 0; display: grid; place-items: center; }
    .wheel { width: 720px; height: 720px; }
    .wheel .bg-ring { fill: url(#ringGrad); }
    .slice { cursor: pointer; transition: transform 220ms cubic-bezier(.2,.7,.2,1), filter .2s ease; }
    .slice:hover { filter: brightness(1.05); }
    .slice.disabled { opacity: .25; cursor: not-allowed; }
    .slice-label { font-size: 12px; fill: var(--muted); text-anchor: middle; letter-spacing: .12em; text-transform: uppercase; }
    .slice-picked { pointer-events: none; }
    .slice-picked image { filter: drop-shadow(0 2px 10px rgba(0,0,0,.35)); }
    .badge {
      font-size: 11px; fill: #0e0f12; font-weight: 800;
      paint-order: stroke; stroke: rgba(0,0,0,.45); stroke-width: 6;
    }

    .mix-btn {
      position: absolute; width: 180px; height: 180px; border-radius: 50%;
      background: radial-gradient(ellipse at 30% 30%, #ffffff, #cfcfd6 60%, #b5b7c2);
      color: #0d0f12; display: grid; place-items: center; font-weight: 800; letter-spacing: .14em;
      box-shadow: 0 14px 40px rgba(0,0,0,.5), inset 0 6px 10px rgba(255,255,255,.25);
      border: 8px solid #e8e9ef; text-transform: uppercase;
      transition: transform .18s ease;
      user-select: none;
    }
    .mix-btn:hover { transform: translateY(-2px); }
    .mixing .mix-btn { animation: pulse 1s ease infinite; }
    @keyframes pulse { 0%,100%{ transform: scale(1); } 50%{ transform: scale(1.04); } }
    .spin { animation: spin 1.4s cubic-bezier(.2,.7,.2,1); }
    @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(720deg); } }

    /* Right: toggles */
    .toggle-row { display: flex; align-items: center; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #24262c; }
    .toggle-row:last-child { border-bottom: 0; }
    .toggle-row label { color: var(--fg); font-weight: 600; }
    .subtle { color: var(--muted); font-size: 12px; }
    .switch { position: relative; display: inline-block; width: 44px; height: 26px; }
    .switch input { display: none; }
    .slider { position: absolute; cursor: pointer; inset: 0; background: #32343b; transition: .2s; border-radius: 999px; border: 1px solid #2b2d35; }
    .slider:before { position: absolute; content: ""; height: 20px; width: 20px; left: 3px; top: 50%; transform: translateY(-50%); background: #bfc2cf; transition: .2s; border-radius: 50%; box-shadow: inset 0 2px 3px rgba(0,0,0,.3); }
    input:checked + .slider { background: var(--ok); }
    input:checked + .slider:before { left: 21px; background: #0f1416; }
    .right-section { margin-bottom: 16px; }
    .right-section h4 { margin: 14px 0 6px; font-size: 12px; letter-spacing: .12em; text-transform: uppercase; color: var(--muted); }

    /* Modal picker */
    .modal {
      position: absolute; inset: 0; display: none; align-items: center; justify-content: center; backdrop-filter: blur(6px);
      background: rgba(15,16,20,.45);
    }
    .modal.visible { display: flex; }
    .modal-card {
      width: 860px; max-height: 78vh; overflow: hidden; border-radius: 16px;
      background: linear-gradient(180deg, #14161a, #101216); border: 1px solid #282a31; box-shadow: var(--shadow);
      display: flex; flex-direction: column;
    }
    .modal-head { display: flex; align-items: center; gap: 10px; padding: 12px 14px; border-bottom: 1px solid #24262c; }
    .modal-body { padding: 14px; overflow: auto; }
    .modal-actions { padding: 12px 14px; border-top: 1px solid #24262c; display: flex; justify-content: space-between; }
    .modal-close { background: transparent; color: var(--muted); border: 0; font-weight: 700; cursor: pointer; }
    .input { background: #0f1115; color: var(--fg); border: 1px solid #262931; border-radius: 10px; padding: 10px 12px; }
    .select { background: #0f1115; color: var(--fg); border: 1px solid #262931; border-radius: 10px; padding: 10px 12px; }

    .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 12px; }
    .card { background: #121419; border: 1px solid #24262c; border-radius: 12px; overflow: hidden; transition: transform .12s ease, box-shadow .2s ease; }
    .card:hover { transform: translateY(-2px); box-shadow: 0 12px 30px rgba(0,0,0,.35); }
    .card img { width: 100%; height: 160px; object-fit: cover; display: block; }
    .card .meta { padding: 10px; }
    .card .meta .name { font-weight: 700; }
    .card .meta .brand { color: var(--muted); font-size: 12px; }
    .card .pick { width: 100%; background: var(--gold); border: 0; padding: 8px; font-weight: 800; cursor: pointer; }

    /* Category pills near wheel */
    .cat-pills { position: absolute; inset: 0; pointer-events: none; }
    .cat-pill { position: absolute; padding: 6px 10px; background: rgba(255,255,255,.04); border: 1px solid rgba(255,255,255,.08); border-radius: 999px; font-size: 11px; letter-spacing: .12em; text-transform: uppercase; color: var(--muted); backdrop-filter: blur(4px); box-shadow: var(--shadow); }

    .footer-note { position: absolute; bottom: 10px; left: 50%; transform: translateX(-50%); color: var(--muted); font-size: 12px; opacity: .7; }
  </style>
</head>
<body>
  <div class="shell">
    <div class="panel left">
      <div class="panel-header">
        <div class="panel-title">Outfit Mixer — X</div>
        <div>
          <button id="previewBtn" class="btn ghost" title="Preview outfit">Preview</button>
        </div>
      </div>
      <div class="left-body">
        <div class="flip" id="flip">
          <div class="flip-inner">
            <div class="flip-face front">
              <div id="instructions" class="instructions">
                <p>
                  Meet <b>Outfit Mixer</b>. Spin into style: click any slice on the wheel to pick a piece. Hover slices pop with a subtle lift. When you’ve chosen a few items, hit <b>Mix</b> to auto-complete the rest.
                </p>
                <p>
                  You can also toggle categories on the right to enable or disable slots. Remove picks from the table once you change your mind.
                </p>
                <div class="cta-row">
                  <button id="startPicking" class="btn gold">Start mixing</button>
                  <button id="clearAll" class="btn secondary">Clear all</button>
                </div>
              </div>
              <div id="selections" class="selections">
                <table class="sel-table" id="selTable">
                  <thead>
                    <tr>
                      <th>Item</th>
                      <th>Category</th>
                      <th>Brand</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody id="selBody"></tbody>
                </table>
              </div>
            </div>
            <div class="flip-face back">
              <div style="display:flex;align-items:center;justify-content:space-between;padding:12px 0 0 0;">
                <div class="panel-title">Preview</div>
                <button id="closePreview" class="btn ghost">Back</button>
              </div>
              <div class="preview-grid" id="previewGrid"></div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="panel center">
      <div class="center-body">
        <div class="wheel-wrap">
          <svg class="wheel" viewBox="-400 -400 800 800" id="wheelSvg" aria-label="Outfit wheel">
            <defs>
              <radialGradient id="ringGrad" cx="50%" cy="50%" r="70%">
                <stop offset="0%" stop-color="#17181d"/>
                <stop offset="70%" stop-color="#14161a"/>
                <stop offset="100%" stop-color="#101216"/>
              </radialGradient>
              <clipPath id="sliceClipOuter">
                <circle cx="0" cy="0" r="320"/>
              </clipPath>
            </defs>
            <g id="ringBg">
              <circle r="340" fill="#0d0e12"/>
              <circle r="330" fill="#0f1115"/>
              <circle class="bg-ring" r="320"/>
              <circle r="140" fill="#0d0f12" stroke="#1c1e23" stroke-width="1"/>
              <circle r="132" fill="#0f1115"/>
            </g>
            <g id="slices"></g>
            <g id="picks" class="slice-picked"></g>
          </svg>
          <div class="cat-pills" id="catPills"></div>
          <div class="mix-btn" id="mixBtn">Mix</div>
          <div class="footer-note">Hover to pop a slice · Click to choose · Center to auto-mix</div>
        </div>
      </div>
    </div>

    <div class="panel right">
      <div class="panel-header">
        <div class="panel-title">Filters & Toggles</div>
        <div class="subtle">Display only</div>
      </div>
      <div class="right-body">
        <div class="right-section">
          <h4>Gender</h4>
          <div class="toggle-row">
            <label class="subtle">Neutral</label>
            <label class="switch"><input type="checkbox" id="genderToggle"><span class="slider"></span></label>
          </div>
          <div class="subtle" id="genderLabel" style="margin-top:8px;">Mixing style: Neutral</div>
        </div>
        <div class="right-section">
          <h4>Enable/Disable Slots</h4>
          <div id="slotToggles"></div>
        </div>
        <div class="right-section">
          <h4>Quick Actions</h4>
          <div class="cta-row">
            <button id="enableAll" class="btn secondary">Enable all</button>
            <button id="disableAll" class="btn secondary">Disable all</button>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Picker Modal -->
  <div class="modal" id="pickerModal" aria-hidden="true">
    <div class="modal-card">
      <div class="modal-head">
        <select id="categorySelect" class="select"></select>
        <input id="keywordInput" class="input" placeholder="Search name or brand..." style="flex:1"/>
        <button id="modalCloseBtn" class="modal-close">Close</button>
      </div>
      <div class="modal-body">
        <div class="grid" id="productGrid"></div>
      </div>
      <div class="modal-actions">
        <div class="subtle">Click a card to add. You can add multiple from the same category.</div>
        <button id="modalDoneBtn" class="btn gold">Done</button>
      </div>
    </div>
  </div>

  <!-- Inline catalog data (copied from product_catalog.json) -->
  <script id="catalog-data" type="application/json">{
  "belts": [
    { "name": "Classic Leather Belt", "brand": "Brand A", "image_path": "images/belts/belt1.jpg" },
    { "name": "Woven Canvas Belt", "brand": "Brand B", "image_path": "images/belts/belt2.jpg" },
    { "name": "Reversible Belt", "brand": "Brand C", "image_path": "images/belts/belt3.jpg" },
    { "name": "Chain Link Belt", "brand": "Brand D", "image_path": "images/belts/belt4.jpg" },
    { "name": "Braided Leather Belt", "brand": "Brand E", "image_path": "images/belts/belt5.jpg" },
    { "name": "Designer Buckle Belt", "brand": "Brand F", "image_path": "images/belts/belt6.jpg" }
  ],
  "bottoms": [
    { "name": "Floral Midi Dress", "brand": "Brand G", "image_path": "images/bottoms/dress1.jpg" },
    { "name": "Wrap Dress", "brand": "Brand H", "image_path": "images/bottoms/dress2.jpg" },
    { "name": "Cocktail Dress", "brand": "Brand A", "image_path": "images/bottoms/dress3.jpg" },
    { "name": "Slim Fit Jeans", "brand": "Brand B", "image_path": "images/bottoms/jeans1.jpg" },
    { "name": "High-Waisted Jeans", "brand": "Brand C", "image_path": "images/bottoms/jeans2.jpg" },
    { "name": "Distressed Denim", "brand": "Brand D", "image_path": "images/bottoms/jeans3.jpg" },
    { "name": "Wide Leg Jeans", "brand": "Brand E", "image_path": "images/bottoms/jeans4.jpg" },
    { "name": "Pleated Midi Skirt", "brand": "Brand F", "image_path": "images/bottoms/skirt1.jpg" },
    { "name": "A-Line Skirt", "brand": "Brand G", "image_path": "images/bottoms/skirt2.jpg" },
    { "name": "Pencil Skirt", "brand": "Brand H", "image_path": "images/bottoms/skirt3.jpg" }
  ],
  "earrings": [
    { "name": "Pearl Drop Earrings", "brand": "Brand A", "image_path": "images/earrings/earrings1.jpg" },
    { "name": "Gold Hoop Earrings", "brand": "Brand B", "image_path": "images/earrings/earrings2.jpg" },
    { "name": "Crystal Stud Earrings", "brand": "Brand C", "image_path": "images/earrings/earrings3.jpg" },
    { "name": "Chandelier Earrings", "brand": "Brand D", "image_path": "images/earrings/earrings4.jpg" },
    { "name": "Minimalist Bar Earrings", "brand": "Brand E", "image_path": "images/earrings/earrings5.jpg" }
  ],
  "gloves": [
    { "name": "Leather Driving Gloves", "brand": "Brand F", "image_path": "images/gloves/gloves1.jpg" },
    { "name": "Cashmere Gloves", "brand": "Brand G", "image_path": "images/gloves/gloves2.jpg" },
    { "name": "Fingerless Gloves", "brand": "Brand H", "image_path": "images/gloves/gloves3.jpg" },
    { "name": "Winter Wool Gloves", "brand": "Brand A", "image_path": "images/gloves/gloves4.jpg" },
    { "name": "Evening Opera Gloves", "brand": "Brand B", "image_path": "images/gloves/gloves5.jpg" },
    { "name": "Touchscreen Gloves", "brand": "Brand C", "image_path": "images/gloves/gloves6.jpg" }
  ],
  "handbags": [
    { "name": "Tote Bag", "brand": "Brand D", "image_path": "images/handbags/handbag1.jpg" },
    { "name": "Crossbody Bag", "brand": "Brand E", "image_path": "images/handbags/handbag2.jpg" },
    { "name": "Clutch Purse", "brand": "Brand F", "image_path": "images/handbags/handbag3.jpg" },
    { "name": "Shoulder Bag", "brand": "Brand G", "image_path": "images/handbags/handbag4.jpg" },
    { "name": "Bucket Bag", "brand": "Brand H", "image_path": "images/handbags/handbag5.jpg" },
    { "name": "Satchel Bag", "brand": "Brand A", "image_path": "images/handbags/handbag6.jpg" },
    { "name": "Hobo Bag", "brand": "Brand B", "image_path": "images/handbags/handbag7.jpg" }
  ],
  "hats": [
    { "name": "Fedora Hat", "brand": "Brand C", "image_path": "images/hats/hat1.jpg" },
    { "name": "Baseball Cap", "brand": "Brand D", "image_path": "images/hats/hat2.jpg" },
    { "name": "Wide Brim Sun Hat", "brand": "Brand E", "image_path": "images/hats/hat3.jpg" },
    { "name": "Beanie", "brand": "Brand F", "image_path": "images/hats/hat4.jpg" },
    { "name": "Beret", "brand": "Brand G", "image_path": "images/hats/hat5.jpg" }
  ],
  "necklaces": [
    { "name": "Pearl Strand Necklace", "brand": "Brand H", "image_path": "images/necklaces/necklace1.jpg" },
    { "name": "Gold Chain Necklace", "brand": "Brand A", "image_path": "images/necklaces/necklace2.jpg" },
    { "name": "Pendant Necklace", "brand": "Brand B", "image_path": "images/necklaces/necklace3.jpg" },
    { "name": "Choker Necklace", "brand": "Brand C", "image_path": "images/necklaces/necklace4.jpg" }
  ],
  "scaves": [
    { "name": "Silk Scarf", "brand": "Brand D", "image_path": "images/scaves/scarf1.jpg" },
    { "name": "Cashmere Scarf", "brand": "Brand E", "image_path": "images/scaves/scarf2.jpg" },
    { "name": "Infinity Scarf", "brand": "Brand F", "image_path": "images/scaves/scarf3.jpg" },
    { "name": "Printed Square Scarf", "brand": "Brand G", "image_path": "images/scaves/scarf4.jpg" },
    { "name": "Wool Blanket Scarf", "brand": "Brand H", "image_path": "images/scaves/scarf5.jpg" },
    { "name": "Lightweight Summer Scarf", "brand": "Brand A", "image_path": "images/scaves/scarf6.jpg" },
    { "name": "Fringed Wrap Scarf", "brand": "Brand B", "image_path": "images/scaves/scarf7.jpg" }
  ],
  "shoes": [
    { "name": "Leather Oxford Shoes", "brand": "Brand C", "image_path": "images/shoes/shoes1.jpg" },
    { "name": "High-Top Sneakers", "brand": "Brand D", "image_path": "images/shoes/shoes2.jpg" },
    { "name": "Ankle Boots", "brand": "Brand E", "image_path": "images/shoes/shoes3.jpg" },
    { "name": "Running Shoes", "brand": "Brand F", "image_path": "images/shoes/shoes4.jpg" }
  ],
  "sunglasses": [
    { "name": "Aviator Sunglasses", "brand": "Brand G", "image_path": "images/sunglasses/sunglassess1.jpg" },
    { "name": "Cat Eye Sunglasses", "brand": "Brand H", "image_path": "images/sunglasses/sunglassess2.jpg" },
    { "name": "Round Frame Sunglasses", "brand": "Brand A", "image_path": "images/sunglasses/sunglassess3.jpg" },
    { "name": "Wayfarer Sunglasses", "brand": "Brand B", "image_path": "images/sunglasses/sunglassess4.jpg" },
    { "name": "Sport Sunglasses", "brand": "Brand C", "image_path": "images/sunglasses/sunglassess5.jpg" }
  ],
  "tops": [
    { "name": "Wool Overcoat", "brand": "Brand D", "image_path": "images/tops/coat1.jpg" },
    { "name": "Trench Coat", "brand": "Brand E", "image_path": "images/tops/coat2.jpg" },
    { "name": "Puffer Coat", "brand": "Brand F", "image_path": "images/tops/coat3.jpg" },
    { "name": "Maxi Dress", "brand": "Brand G", "image_path": "images/tops/dress1.png" },
    { "name": "Shift Dress", "brand": "Brand H", "image_path": "images/tops/dress2.png" },
    { "name": "Evening Gown", "brand": "Brand A", "image_path": "images/tops/dress7.jpg" },
    { "name": "Denim Jacket", "brand": "Brand B", "image_path": "images/tops/jacket1.jpg" },
    { "name": "Leather Jacket", "brand": "Brand C", "image_path": "images/tops/jacket2.jpg" },
    { "name": "Bomber Jacket", "brand": "Brand D", "image_path": "images/tops/jacket3.jpg" },
    { "name": "Cotton T-Shirt", "brand": "Brand E", "image_path": "images/tops/top1.png" },
    { "name": "Silk Blouse", "brand": "Brand F", "image_path": "images/tops/top2.png" },
    { "name": "Knit Sweater", "brand": "Brand G", "image_path": "images/tops/top3.png" },
    { "name": "Linen Shirt", "brand": "Brand H", "image_path": "images/tops/top4.png" }
  ],
  "watches": [
    { "name": "Classic Analog Watch", "brand": "Brand A", "image_path": "images/watches/watch1.jpg" },
    { "name": "Digital Sport Watch", "brand": "Brand B", "image_path": "images/watches/watch2.jpg" },
    { "name": "Chronograph Watch", "brand": "Brand C", "image_path": "images/watches/watch3.jpg" },
    { "name": "Smart Watch", "brand": "Brand D", "image_path": "images/watches/watch4.jpg" },
    { "name": "Dress Watch", "brand": "Brand E", "image_path": "images/watches/watch5.jpg" },
    { "name": "Dive Watch", "brand": "Brand F", "image_path": "images/watches/watch6.jpg" }
  ]
}</script>

  <script>
    const state = {
      catalog: {},
      categories: [],
      categoryLabels: {},
      enabled: new Set(),
      selections: {}, // { category: [product, ...] }
      gender: 'Neutral',
      currentSlice: null,
    };

    const $ = (sel, root=document) => root.querySelector(sel);
    const $$ = (sel, root=document) => Array.from(root.querySelectorAll(sel));

    function prettyLabel(key) {
      const map = {
        scaves: 'scarves',
      };
      return (map[key] || key).replace(/_/g,' ').replace(/\b\w/g, c => c.toUpperCase());
    }

    function loadCatalog() {
      const text = document.getElementById('catalog-data').textContent;
      const json = JSON.parse(text);
      state.catalog = json;
      state.categories = Object.keys(json);
      state.categories.forEach(k => state.categoryLabels[k] = prettyLabel(k));
      state.enabled = new Set(state.categories);
    }

    function polarToCartesian(r, angleDeg) {
      const rad = angleDeg * Math.PI / 180;
      return { x: r * Math.cos(rad), y: r * Math.sin(rad) };
    }

    function describeDonutSlice(cx, cy, rOuter, rInner, startAngle, endAngle) {
      const startOuter = polarToCartesian(rOuter, startAngle);
      const endOuter = polarToCartesian(rOuter, endAngle);
      const startInner = polarToCartesian(rInner, endAngle);
      const endInner = polarToCartesian(rInner, startAngle);
      const largeArc = endAngle - startAngle <= 180 ? 0 : 1;
      return [
        `M ${startOuter.x} ${startOuter.y}`,
        `A ${rOuter} ${rOuter} 0 ${largeArc} 1 ${endOuter.x} ${endOuter.y}`,
        `L ${startInner.x} ${startInner.y}`,
        `A ${rInner} ${rInner} 0 ${largeArc} 0 ${endInner.x} ${endInner.y}`,
        'Z'
      ].join(' ');
    }

    function buildWheel() {
      const svg = document.getElementById('slices');
      svg.innerHTML = '';
      const picksLayer = document.getElementById('picks');
      picksLayer.innerHTML = '';
      const pills = document.getElementById('catPills');
      pills.innerHTML = '';

      const count = state.categories.length;
      const step = 360 / count;
      const rOuter = 320, rInner = 150; // donut band
      const midRadius = 260; // for image/pill positioning

      state.categories.forEach((cat, i) => {
        const startAngle = -90 + i * step;
        const endAngle = startAngle + step;
        const midAngle = (startAngle + endAngle) / 2;
        const pathD = describeDonutSlice(0, 0, rOuter, rInner, startAngle+1, endAngle-1);

        const group = document.createElementNS('http://www.w3.org/2000/svg', 'g');
        group.classList.add('slice');
        group.dataset.category = cat;
        if (!state.enabled.has(cat)) group.classList.add('disabled');

        const path = document.createElementNS('http://www.w3.org/2000/svg', 'path');
        path.setAttribute('d', pathD);
        const hue = (i * 37) % 360;
        path.setAttribute('fill', `hsl(${hue} 16% 16% / 1)`);
        path.setAttribute('stroke', `hsl(${hue} 18% 24% / 1)`);
        path.setAttribute('stroke-width', '1');
        group.appendChild(path);

        // hover pop: translate along mid-angle
        const dx = Math.cos(midAngle * Math.PI/180) * 14;
        const dy = Math.sin(midAngle * Math.PI/180) * 14;
        group.addEventListener('mouseenter', () => {
          if (group.classList.contains('disabled')) return;
          group.style.transform = `translate(${dx}px, ${dy}px)`;
        });
        group.addEventListener('mouseleave', () => { group.style.transform = ''; });
        group.addEventListener('click', () => {
          if (group.classList.contains('disabled')) return;
          openPicker(cat);
        });

        svg.appendChild(group);

        // Category labels on the ring
        const labelPos = polarToCartesian(290, midAngle);
        const label = document.createElementNS('http://www.w3.org/2000/svg', 'text');
        label.setAttribute('x', labelPos.x.toFixed(1));
        label.setAttribute('y', labelPos.y.toFixed(1));
        label.setAttribute('class', 'slice-label');
        label.textContent = state.categoryLabels[cat];
        svg.appendChild(label);

        // Category pill outside wheel
        const pillPos = polarToCartesian(midRadius + 90, midAngle);
        const pill = document.createElement('div');
        pill.className = 'cat-pill';
        pill.textContent = state.categoryLabels[cat];
        pill.style.left = `${400 + pillPos.x - 30}px`;
        pill.style.top = `${400 + pillPos.y - 12}px`;
        pills.appendChild(pill);

        // If there are picks already, render thumbnail(s)
        renderSlicePicks(cat, midAngle);
      });
    }

    function renderSlicePicks(category, midAngle) {
      const picksLayer = document.getElementById('picks');
      // remove existing for this category
      $$("[data-pick-cat='"+category+"']", picksLayer).forEach(el => el.remove());

      const items = state.selections[category] || [];
      if (!items.length) return;

      const baseR = 250;
      const iconSize = 64;
      const dx = Math.cos(midAngle * Math.PI/180) * baseR;
      const dy = Math.sin(midAngle * Math.PI/180) * baseR;

      const group = document.createElementNS('http://www.w3.org/2000/svg', 'g');
      group.dataset.pickCat = category;
      group.setAttribute('transform', `translate(${dx - iconSize/2}, ${dy - iconSize/2})`);

      const img = document.createElementNS('http://www.w3.org/2000/svg', 'image');
      img.setAttributeNS('http://www.w3.org/1999/xlink', 'href', items[items.length-1].image_path);
      img.setAttribute('width', iconSize);
      img.setAttribute('height', iconSize);
      img.setAttribute('clip-path', 'url(#sliceClipOuter)');
      img.setAttribute('style', 'border-radius: 12px');
      group.appendChild(img);

      if (items.length > 1) {
        const badge = document.createElementNS('http://www.w3.org/2000/svg', 'text');
        badge.setAttribute('x', iconSize - 8);
        badge.setAttribute('y', 16);
        badge.setAttribute('class', 'badge');
        badge.textContent = `+${items.length-1}`;
        group.appendChild(badge);
      }

      picksLayer.appendChild(group);
    }

    // Modal picker
    function openPicker(category) {
      state.currentSlice = category;
      const modal = document.getElementById('pickerModal');
      modal.classList.add('visible');

      const select = document.getElementById('categorySelect');
      select.innerHTML = '';
      state.categories.forEach(cat => {
        const opt = document.createElement('option');
        opt.value = cat; opt.textContent = state.categoryLabels[cat];
        if (cat === category) opt.selected = true;
        select.appendChild(opt);
      });
      buildProductGrid();
    }
    function closePicker() {
      document.getElementById('pickerModal').classList.remove('visible');
      state.currentSlice = null;
    }
    function buildProductGrid() {
      const grid = document.getElementById('productGrid');
      grid.innerHTML = '';
      const select = document.getElementById('categorySelect');
      const kw = document.getElementById('keywordInput').value.trim().toLowerCase();
      const cat = select.value || state.categories.find(c => c.includes('tops')) || state.categories[0];
      const list = (state.catalog[cat] || []).filter(p =>
        !kw || p.name.toLowerCase().includes(kw) || p.brand.toLowerCase().includes(kw)
      );

      list.forEach((p) => {
        const card = document.createElement('div');
        card.className = 'card';
        card.innerHTML = `
          <img src="${p.image_path}" alt="${p.name}">
          <div class="meta">
            <div class="name">${p.name}</div>
            <div class="brand">${p.brand}</div>
          </div>
          <button class="pick">Add</button>
        `;
        card.querySelector('.pick').addEventListener('click', () => {
          addSelection(select.value, p);
        });
        grid.appendChild(card);
      });
    }

    function addSelection(category, product) {
      if (!state.selections[category]) state.selections[category] = [];
      state.selections[category].push(product);
      refreshSelectionsUI();
      // render thumbnail on wheel
      const idx = state.categories.indexOf(category);
      const step = 360 / state.categories.length;
      const startAngle = -90 + idx * step;
      const endAngle = startAngle + step;
      const midAngle = (startAngle + endAngle) / 2;
      renderSlicePicks(category, midAngle);
    }

    function removeSelection(category, index) {
      if (!state.selections[category]) return;
      state.selections[category].splice(index, 1);
      if (state.selections[category].length === 0) delete state.selections[category];
      refreshSelectionsUI();
      // rerender wheel pick for that category
      const idx = state.categories.indexOf(category);
      const step = 360 / state.categories.length;
      const startAngle = -90 + idx * step;
      const endAngle = startAngle + step;
      const midAngle = (startAngle + endAngle) / 2;
      renderSlicePicks(category, midAngle);
    }

    function refreshSelectionsUI() {
      const hasAny = Object.values(state.selections).some(arr => arr && arr.length);
      document.getElementById('instructions').style.display = hasAny ? 'none' : 'block';
      const sel = document.getElementById('selections');
      sel.classList.toggle('visible', hasAny);
      const body = document.getElementById('selBody');
      body.innerHTML = '';

      Object.entries(state.selections).forEach(([cat, items]) => {
        items.forEach((p, i) => {
          const tr = document.createElement('tr');
          tr.innerHTML = `
            <td><div style="display:flex;align-items:center;gap:10px"><img class="thumb" src="${p.image_path}" alt="${p.name}"><div><div style="font-weight:700">${p.name}</div><div class="subtle">${state.categoryLabels[cat]}</div></div></div></td>
            <td>${state.categoryLabels[cat]}</td>
            <td class="subtle">${p.brand}</td>
            <td style="text-align:right"><button class="remove">Remove</button></td>
          `;
          tr.querySelector('.remove').addEventListener('click', () => removeSelection(cat, i));
          body.appendChild(tr);
        });
      });

      // preview grid
      const grid = document.getElementById('previewGrid');
      grid.innerHTML = '';
      Object.values(state.selections).flat().forEach(p => {
        const img = document.createElement('img');
        img.src = p.image_path; img.alt = p.name; grid.appendChild(img);
      });
    }

    function buildToggles() {
      const holder = document.getElementById('slotToggles');
      holder.innerHTML = '';
      state.categories.forEach(cat => {
        const row = document.createElement('div');
        row.className = 'toggle-row';
        row.innerHTML = `
          <label>${state.categoryLabels[cat]}</label>
          <label class="switch"><input type="checkbox" checked data-cat="${cat}"><span class="slider"></span></label>
        `;
        row.querySelector('input').addEventListener('change', (e) => {
          const enabled = e.target.checked;
          if (enabled) state.enabled.add(cat); else state.enabled.delete(cat);
          // toggle slice class
          const slice = $(`.slice[data-category="${cat}"]`);
          if (slice) slice.classList.toggle('disabled', !enabled);
        });
        holder.appendChild(row);
      });
    }

    function mixOutfit() {
      const center = document.querySelector('.wheel-wrap');
      center.classList.add('mixing');
      const svg = document.getElementById('wheelSvg');
      svg.classList.add('spin');
      setTimeout(() => {
        svg.classList.remove('spin');
        center.classList.remove('mixing');
      }, 1400);

      state.categories.forEach(cat => {
        if (!state.enabled.has(cat)) return;
        const already = (state.selections[cat] || []).length > 0;
        if (already) return;
        const list = state.catalog[cat] || [];
        if (!list.length) return;
        // seed influenced by gender toggle: simple offset
        const offset = state.gender === 'Neutral' ? 0 : (state.gender === 'Feminine' ? 1 : 2);
        const idx = (Math.floor(Math.random() * list.length) + offset) % list.length;
        addSelection(cat, list[idx]);
      });
    }

    function clearAll() {
      state.selections = {};
      refreshSelectionsUI();
      buildWheel();
    }

    function setupEvents() {
      document.getElementById('mixBtn').addEventListener('click', mixOutfit);
      document.getElementById('startPicking').addEventListener('click', () => openPicker('tops'));
      document.getElementById('clearAll').addEventListener('click', clearAll);
      document.getElementById('previewBtn').addEventListener('click', () => {
        document.getElementById('flip').classList.add('show-preview');
      });
      document.getElementById('closePreview').addEventListener('click', () => {
        document.getElementById('flip').classList.remove('show-preview');
      });
      document.getElementById('modalCloseBtn').addEventListener('click', closePicker);
      document.getElementById('modalDoneBtn').addEventListener('click', closePicker);
      document.getElementById('categorySelect').addEventListener('change', buildProductGrid);
      document.getElementById('keywordInput').addEventListener('input', buildProductGrid);

      document.getElementById('genderToggle').addEventListener('change', (e) => {
        state.gender = e.target.checked ? 'Feminine' : 'Neutral';
        document.getElementById('genderLabel').textContent = `Mixing style: ${state.gender}`;
      });

      document.getElementById('enableAll').addEventListener('click', () => {
        state.categories.forEach(cat => state.enabled.add(cat));
        buildToggles();
        buildWheel();
      });
      document.getElementById('disableAll').addEventListener('click', () => {
        state.categories.forEach(cat => state.enabled.delete(cat));
        buildToggles();
        buildWheel();
      });
    }

    // Init
    loadCatalog();
    setupEvents();
    buildToggles();
    buildWheel();
  </script>
</body>
</html>


```

Built the full single-file prototype with an SVG wheel, picker modal, left selection table, and right panel toggles. I'll quickly check for any linter diagnostics for the new HTML file.

- Implemented `outfit-mixer.html`:
  - SVG “pizza” wheel with hover pop animation, category labels and outside category pills; thumbnails render on slices when selected, with “+n” badge for multiple picks in same category.
  - Left panel: instructions → auto-switches to a selections table with thumbnails, names, brands, remove action. Flip-card “Preview” shows a grid of selected items.
  - Center “Mix” button spins the wheel and auto-fills enabled, unselected categories; uses a simple gender-influenced randomness.
  - Right panel: functional toggles for gender and per-slot enable/disable; quick enable/disable all.
  - Modal picker: category dropdown, keyword search, and product grid; clicking “Add” appends to that category’s selections.
  - Catalog inlined from `product_catalog.json`. Images referenced from `images/`.

- Notes:
  - Multiple items per category are supported; the slice shows the latest pick with a `+n` badge. The table and preview show all.
  - Preview uses a polished grid; can be evolved into a mannequin/stacked composite later.

