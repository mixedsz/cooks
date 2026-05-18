# fsg_cooking — Installation Guide

## Dependencies

Install and ensure these resources start **before** `fsg_cooking`:

| Resource | Where to get it |
|---|---|
| `ox_lib` | https://github.com/overextended/ox_lib/releases |
| `ox_target` | https://github.com/overextended/ox_target/releases |
| `ox_inventory` | https://github.com/overextended/ox_inventory/releases |
| `oxmysql` | https://github.com/overextended/oxmysql/releases |
| `object_gizmo` | https://github.com/overextended/object_gizmo/releases |
| `es_extended` **or** `qb-core` | Your framework |

Add them to your `server.cfg` in this order:

```
ensure oxmysql
ensure ox_lib
ensure ox_target
ensure ox_inventory
ensure object_gizmo
ensure es_extended   # or qb-core
ensure fsg_cooking
```

---

## 1. Database

The script creates its table automatically on first start when
`Config.Database.AutoExecuteSQL = true` (the default).

If you prefer to run it manually, execute `install/fsg_cooking.sql`
against your database before starting the resource.

---

## 2. ox_inventory items

Open `ox_inventory/data/items.lua` and paste the contents of
`install/ox_inventory_items.lua` **inside** the `return { }` table.

Example structure in `items.lua`:

```lua
return {
    -- ... existing items ...

    -- ── fsg_cooking items ──
    ['fsg_stove'] = {
        label  = 'Portable Stove',
        weight = 5000,
        stack  = false,
        close  = true,
        description = 'A portable gas stove.',
    },
    -- ... rest of fsg_cooking items ...
}
```

All item images should be placed in `ox_inventory/web/images/` as
`<item_name>.png` (e.g. `fsg_stove.png`).  Without images ox_inventory
falls back to a placeholder — the script will still work.

---

## 3. Configuration

Edit the files in `fsg_cooking/config/` before starting:

### `config/config.lua` — key options

| Option | Default | Description |
|---|---|---|
| `Config.Framework` | `'auto'` | `'esx'`, `'qbcore'`, or `'auto'` |
| `Config.ShopMenu` | `'ui'` | `'ui'` = custom NUI, `'ox'` = ox_lib context menu |
| `Config.Debug` | `false` | Enables debug prints |
| `Config.PersistentProps.Enabled` | `true` | Save/load placed props across restarts |
| `Config.PersistentProps.SaveInterval` | `600` | Seconds between auto-saves |
| `Config.Database.AutoExecuteSQL` | `true` | Auto-create the DB table on start |

### `config/stores.lua`

Define shop locations, NPC peds, blips, and which items each store sells.
Each item entry needs `item` (inventory name), `label`, and `price`.

### `config/recipes.lua`

Cooking recipes. Each recipe defines:
- `label` — display name
- `appliance` — which appliance type it uses
- `requiredItems` — `{ { item = 'fsg_egg', count = 2 }, ... }`
- `resultItems` — items given on success
- `failedResultItems` — items given on failure (e.g. `fsg_burnt_food`)
- `cookTime` — milliseconds
- `successRate` — 0–100

### `config/appliances.lua`

Defines the placeable cooking appliances (props that players can place
using the item from their inventory).

### `config/decorations.lua`

Defines decoration props (chairs, tables, coolers) that players can
place for ambiance.

---

## 4. Give starter items (optional)

To give a player appliances for testing, use the ox_inventory give
command in your server console:

```
# Give a player (server id 1) a portable stove
oxinventory:giveitem 1 fsg_stove 1

# Give cooking ingredients
oxinventory:giveitem 1 fsg_egg 6
oxinventory:giveitem 1 fsg_milk 2
oxinventory:giveitem 1 fsg_butter 1
```

---

## 5. Verify everything works

1. Start your server and check the console for errors from `fsg_cooking`.
2. Give yourself a `fsg_stove` item and use it from your inventory.
3. Place the stove using the gizmo, then walk up to it and press the
   interact key (default E / ox_target).
4. Select a recipe, confirm you have the ingredients, and start cooking.
5. Visit a shop NPC location to test purchasing ingredients.
