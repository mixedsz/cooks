
Config.Stores = {
    {
        label = "Cooking Store",
        enabled = true,
        blip = {
            enabled = true,
            sprite = 52,
            color = 2,
            scale = 0.6,
            display = 4
        },
        ped = {
            coords = vec4(-520.9393, -855.4604, 30.2678 -0.99, 330.2374),
            model = 'a_m_m_soucent_03',
            scenario = 'WORLD_HUMAN_CLIPBOARD'
        },
        categories = {

            ["Decoration Items"] = {
                { item = 'flake_deco_table_wood', label = 'Wooden Table', price = 200 },
                { item = 'flake_deco_cooler', label = 'Cooler', price = 150 },
                { item = 'flake_deco_chair_bbq', label = 'BBQ Chair', price = 200 },
            },

            
            ["Cooking Appliances"] = {
                { item = 'flake_bbq_grill', label = 'BBQ Grill', price = 500 },
                { item = 'flake_microwave', label = 'Microwave', price = 300 },
                { item = 'flake_stove', label = 'Stove', price = 600 },
                { item = 'flake_juicer', label = 'Juicer', price = 250 },
                { item = 'flake_fryer', label = 'Fryer', price = 400 },
                { item = 'flake_pizza_oven', label = 'Pizza Oven', price = 450 },
                { item = 'flake_toaster', label = 'Toaster', price = 200 },
                { item = 'flake_griddle', label = 'Griddle', price = 350 },
                { item = 'flake_processor', label = 'Processor', price = 400 }
            },
            

            ["Meats"] = {
                -- Meats
                { item = 'flake_pork_shoulder', label = 'Pork Shoulder', price = 10 },
                { item = 'flake_pork_ribs', label = 'Pork Ribs', price = 10 },
                { item = 'flake_squid', label = 'Squid', price = 10 },
                { item = 'flake_raw_fish', label = 'Raw Fish', price = 10 },
                { item = 'flake_raw_shrimp', label = 'Raw Shrimp', price = 10 },
                { item = 'flake_raw_steak', label = 'Raw Steak', price = 10 },
                { item = 'flake_raw_beef', label = 'Raw Beef', price = 10 },
                { item = 'flake_raw_chicken', label = 'Raw Chicken', price = 8 },
                { item = 'flake_chicken_breast', label = 'Chicken Breast', price = 7 },
                { item = 'flake_raw_sausages', label = 'Raw Sausages', price = 6 },
                { item = 'flake_bacon', label = 'Bacon', price = 5 },
                { item = 'flake_ham', label = 'Ham', price = 6 },
                { item = 'flake_pepperoni', label = 'Pepperoni', price = 5 },
                { item = 'flake_raw_salmon', label = 'Raw Salmon', price = 10 },
                { item = 'flake_chicken_wings', label = 'Raw Chicken Wings', price = 7 },
                { item = 'flake_hamslice', label = 'Ham Slice', price = 5 },
            },

            ["Fruits and Vegetables"] = {
                -- Fruits
                { item = 'flake_apple', label = 'Apple', price = 2 },
                { item = 'flake_banana', label = 'Banana', price = 2 },
                { item = 'flake_strawberry', label = 'Strawberry', price = 3 },
                { item = 'flake_orange', label = 'Orange', price = 2 },
                { item = 'flake_pineapple', label = 'Pineapple', price = 4 },
                { item = 'flake_grapes', label = 'Grapes', price = 3 },
                { item = 'flake_watermelon', label = 'Watermelon', price = 4 },
                { item = 'flake_lemon', label = 'Lemon', price = 2 },

                -- Vegetables
                { item = 'flake_tomato', label = 'Tomato', price = 2 },
                { item = 'flake_onion', label = 'Onion', price = 2 },
                { item = 'flake_bell_pepper', label = 'Bell Pepper', price = 3 },
                { item = 'flake_carrot', label = 'Carrot', price = 2 },
                { item = 'flake_celery', label = 'Celery', price = 2 },
                { item = 'flake_mushroom', label = 'Mushroom', price = 3 },
                { item = 'flake_eggplant', label = 'Eggplant', price = 3 },
                { item = 'flake_corn', label = 'Corn', price = 2 },
                { item = 'flake_zucchini', label = 'Zucchini', price = 3 },
                { item = 'flake_beet', label = 'Beet', price = 2 },
                { item = 'flake_potato', label = 'Potato', price = 2 },
                { item = 'flake_okra', label = 'Okra', price = 3 },
                { item = 'flake_vegetables', label = 'Mixed Vegetables', price = 5 },
            },
            
            ["Recipe Ingredients"] = {
                -- Basic Ingredients
                { item = 'flake_flour', label = 'Flour', price = 2 },
                { item = 'flake_sugar', label = 'Sugar', price = 2 },
                { item = 'flake_salt', label = 'Salt', price = 1 },
                { item = 'flake_pepper', label = 'Pepper', price = 1 },
                { item = 'flake_butter', label = 'Butter', price = 3 },
                { item = 'flake_oil', label = 'Cooking Oil', price = 4 },
                { item = 'flake_water', label = 'Water Bottle', price = 1 },
                { item = 'flake_ice', label = 'Ice', price = 1 },
                { item = 'flake_vanilla', label = 'Vanilla Extract', price = 5 },
                { item = 'flake_burger_bun', label = 'Burger Bun', price = 5 },
                { item = 'flake_breadcrumbs', label = 'Breadcrumbs', price = 5 },
                { item = 'flake_spring_roll_wrapper', label = 'Spring Roll Wrapper', price = 5 },
                { item = 'flake_garlic', label = 'Garlic', price = 5 },
                { item = 'flake_herbs', label = 'Herbs', price = 5 },

                -- Dairy & Eggs
                { item = 'flake_milk', label = 'Milk', price = 2 },
                { item = 'flake_cream', label = 'Cream', price = 3 },
                { item = 'flake_egg', label = 'Egg', price = 1 },
                { item = 'flake_cheese', label = 'Cheese', price = 4 },
                { item = 'flake_mozzarella', label = 'Mozzarella', price = 5 },
                { item = 'flake_cornmeal', label = 'Cornmeal', price = 5 },
                { item = 'flake_cheese_curds', label = 'Cheese Curds', price = 5 },

                

                -- Bread & Grains
                { item = 'flake_bread', label = 'Bread', price = 3 },
                { item = 'flake_oatmeal', label = 'Oatmeal', price = 3 },
                { item = 'flake_bread_slice', label = 'Bread Slice', price = 1 },
                { item = 'flake_pizza_dough', label = 'Pizza Dough', price = 4 },
                { item = 'flake_tortilla', label = 'Tortilla', price = 2 },
                { item = 'flake_rice', label = 'Rice', price = 3 },
                { item = 'flake_pasta', label = 'Pasta', price = 3 },
                { item = 'flake_macaroni', label = 'Macaroni', price = 3 },
                { item = 'flake_ramen_noodles', label = 'Ramen Noodles', price = 3 },

                

                -- Sauces & Condiments
                { item = 'flake_tomato_sauce', label = 'Tomato Sauce', price = 3 },
                { item = 'flake_bbq_sauce', label = 'BBQ Sauce', price = 4 },
                { item = 'flake_soy_sauce', label = 'Soy Sauce', price = 3 },
                { item = 'flake_pesto_sauce', label = 'Pesto Sauce', price = 5 },
                { item = 'flake_curry_paste', label = 'Curry Paste', price = 4 },
                { item = 'flake_syrup', label = 'Syrup', price = 4 },
                
                -- Baking & Dessert
                { item = 'flake_pie_crust', label = 'Pie Crust', price = 4 },
                { item = 'flake_cake_mix', label = 'Cake Mix', price = 4 },
                { item = 'flake_pancake_mix', label = 'Pancake Mix', price = 4 },
                { item = 'flake_chocolate', label = 'Chocolate', price = 3 },
                { item = 'flake_cinnamon', label = 'Cinnamon', price = 3 },
                { item = 'flake_frozewaff', label = 'Frozen Waffle', price = 4 },

                -- Canned & Packaged
                { item = 'flake_coconut_milk', label = 'Coconut Milk', price = 4 },
                { item = 'flake_chicken_stock', label = 'Chicken Stock', price = 3 },
                { item = 'flake_soup_mix', label = 'Soup Mix', price = 4 },
                { item = 'flake_frozen_dinner', label = 'Frozen TV Dinner', price = 7 },

                -- Coffee & Beverages
                { item = 'flake_coffee_beans', label = 'Coffee Beans', price = 5 },
                { item = 'flake_applejuice', label = 'Apple Juice', price = 4 },
                { item = 'flake_toasti', label = 'Toastie', price = 4 },
                { item = 'flake_choccream', label = 'Chocolate Cream', price = 4 },
                { item = 'flake_berrycream', label = 'Strawberry Cream', price = 4 },
                { item = 'flake_cocoapod', label = 'Cocoa Pod', price = 4 },
                { item = 'flake_vaniwafers', label = 'Vanilla Wafers', price = 4 },
                { item = 'flake_pudding', label = 'Pudding', price = 4 },

                { item = 'flake_popcorn_bag', label = 'Microwaveable Popcorn', price = 4 },

            },
            
           
        }
    },
    -- to add multiple shops
}