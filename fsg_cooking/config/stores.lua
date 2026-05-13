
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
                { item = 'fsg_deco_table_wood', label = 'Wooden Table', price = 200 },
                { item = 'fsg_deco_cooler', label = 'Cooler', price = 150 },
                { item = 'fsg_deco_chair_bbq', label = 'BBQ Chair', price = 200 },
            },

            
            ["Cooking Appliances"] = {
                { item = 'fsg_bbq_grill', label = 'BBQ Grill', price = 500 },
                { item = 'fsg_microwave', label = 'Microwave', price = 300 },
                { item = 'fsg_stove', label = 'Stove', price = 600 },
                { item = 'fsg_juicer', label = 'Juicer', price = 250 },
                { item = 'fsg_fryer', label = 'Fryer', price = 400 },
                { item = 'fsg_pizza_oven', label = 'Pizza Oven', price = 450 },
                { item = 'fsg_toaster', label = 'Toaster', price = 200 },
                { item = 'fsg_griddle', label = 'Griddle', price = 350 },
                { item = 'fsg_processor', label = 'Processor', price = 400 }
            },
            

            ["Meats"] = {
                -- Meats
                { item = 'fsg_pork_shoulder', label = 'Pork Shoulder', price = 10 },
                { item = 'fsg_pork_ribs', label = 'Pork Ribs', price = 10 },
                { item = 'fsg_squid', label = 'Squid', price = 10 },
                { item = 'fsg_raw_fish', label = 'Raw Fish', price = 10 },
                { item = 'fsg_raw_shrimp', label = 'Raw Shrimp', price = 10 },
                { item = 'fsg_raw_steak', label = 'Raw Steak', price = 10 },
                { item = 'fsg_raw_beef', label = 'Raw Beef', price = 10 },
                { item = 'fsg_raw_chicken', label = 'Raw Chicken', price = 8 },
                { item = 'fsg_chicken_breast', label = 'Chicken Breast', price = 7 },
                { item = 'fsg_raw_sausages', label = 'Raw Sausages', price = 6 },
                { item = 'fsg_bacon', label = 'Bacon', price = 5 },
                { item = 'fsg_ham', label = 'Ham', price = 6 },
                { item = 'fsg_pepperoni', label = 'Pepperoni', price = 5 },
                { item = 'fsg_raw_salmon', label = 'Raw Salmon', price = 10 },
                { item = 'fsg_chicken_wings', label = 'Raw Chicken Wings', price = 7 },
                { item = 'fsg_hamslice', label = 'Ham Slice', price = 5 },
            },

            ["Fruits and Vegetables"] = {
                -- Fruits
                { item = 'fsg_apple', label = 'Apple', price = 2 },
                { item = 'fsg_banana', label = 'Banana', price = 2 },
                { item = 'fsg_strawberry', label = 'Strawberry', price = 3 },
                { item = 'fsg_orange', label = 'Orange', price = 2 },
                { item = 'fsg_pineapple', label = 'Pineapple', price = 4 },
                { item = 'fsg_grapes', label = 'Grapes', price = 3 },
                { item = 'fsg_watermelon', label = 'Watermelon', price = 4 },
                { item = 'fsg_lemon', label = 'Lemon', price = 2 },

                -- Vegetables
                { item = 'fsg_tomato', label = 'Tomato', price = 2 },
                { item = 'fsg_onion', label = 'Onion', price = 2 },
                { item = 'fsg_bell_pepper', label = 'Bell Pepper', price = 3 },
                { item = 'fsg_carrot', label = 'Carrot', price = 2 },
                { item = 'fsg_celery', label = 'Celery', price = 2 },
                { item = 'fsg_mushroom', label = 'Mushroom', price = 3 },
                { item = 'fsg_eggplant', label = 'Eggplant', price = 3 },
                { item = 'fsg_corn', label = 'Corn', price = 2 },
                { item = 'fsg_zucchini', label = 'Zucchini', price = 3 },
                { item = 'fsg_beet', label = 'Beet', price = 2 },
                { item = 'fsg_potato', label = 'Potato', price = 2 },
                { item = 'fsg_okra', label = 'Okra', price = 3 },
                { item = 'fsg_vegetables', label = 'Mixed Vegetables', price = 5 },
            },
            
            ["Recipe Ingredients"] = {
                -- Basic Ingredients
                { item = 'fsg_flour', label = 'Flour', price = 2 },
                { item = 'fsg_sugar', label = 'Sugar', price = 2 },
                { item = 'fsg_salt', label = 'Salt', price = 1 },
                { item = 'fsg_pepper', label = 'Pepper', price = 1 },
                { item = 'fsg_butter', label = 'Butter', price = 3 },
                { item = 'fsg_oil', label = 'Cooking Oil', price = 4 },
                { item = 'fsg_water', label = 'Water Bottle', price = 1 },
                { item = 'fsg_ice', label = 'Ice', price = 1 },
                { item = 'fsg_vanilla', label = 'Vanilla Extract', price = 5 },
                { item = 'fsg_burger_bun', label = 'Burger Bun', price = 5 },
                { item = 'fsg_breadcrumbs', label = 'Breadcrumbs', price = 5 },
                { item = 'fsg_spring_roll_wrapper', label = 'Spring Roll Wrapper', price = 5 },
                { item = 'fsg_garlic', label = 'Garlic', price = 5 },
                { item = 'fsg_herbs', label = 'Herbs', price = 5 },

                -- Dairy & Eggs
                { item = 'fsg_milk', label = 'Milk', price = 2 },
                { item = 'fsg_cream', label = 'Cream', price = 3 },
                { item = 'fsg_egg', label = 'Egg', price = 1 },
                { item = 'fsg_cheese', label = 'Cheese', price = 4 },
                { item = 'fsg_mozzarella', label = 'Mozzarella', price = 5 },
                { item = 'fsg_cornmeal', label = 'Cornmeal', price = 5 },
                { item = 'fsg_cheese_curds', label = 'Cheese Curds', price = 5 },

                

                -- Bread & Grains
                { item = 'fsg_bread', label = 'Bread', price = 3 },
                { item = 'fsg_oatmeal', label = 'Oatmeal', price = 3 },
                { item = 'fsg_bread_slice', label = 'Bread Slice', price = 1 },
                { item = 'fsg_pizza_dough', label = 'Pizza Dough', price = 4 },
                { item = 'fsg_tortilla', label = 'Tortilla', price = 2 },
                { item = 'fsg_rice', label = 'Rice', price = 3 },
                { item = 'fsg_pasta', label = 'Pasta', price = 3 },
                { item = 'fsg_macaroni', label = 'Macaroni', price = 3 },
                { item = 'fsg_ramen_noodles', label = 'Ramen Noodles', price = 3 },

                

                -- Sauces & Condiments
                { item = 'fsg_tomato_sauce', label = 'Tomato Sauce', price = 3 },
                { item = 'fsg_bbq_sauce', label = 'BBQ Sauce', price = 4 },
                { item = 'fsg_soy_sauce', label = 'Soy Sauce', price = 3 },
                { item = 'fsg_pesto_sauce', label = 'Pesto Sauce', price = 5 },
                { item = 'fsg_curry_paste', label = 'Curry Paste', price = 4 },
                { item = 'fsg_syrup', label = 'Syrup', price = 4 },
                
                -- Baking & Dessert
                { item = 'fsg_pie_crust', label = 'Pie Crust', price = 4 },
                { item = 'fsg_cake_mix', label = 'Cake Mix', price = 4 },
                { item = 'fsg_pancake_mix', label = 'Pancake Mix', price = 4 },
                { item = 'fsg_chocolate', label = 'Chocolate', price = 3 },
                { item = 'fsg_cinnamon', label = 'Cinnamon', price = 3 },
                { item = 'fsg_frozewaff', label = 'Frozen Waffle', price = 4 },

                -- Canned & Packaged
                { item = 'fsg_coconut_milk', label = 'Coconut Milk', price = 4 },
                { item = 'fsg_chicken_stock', label = 'Chicken Stock', price = 3 },
                { item = 'fsg_soup_mix', label = 'Soup Mix', price = 4 },
                { item = 'fsg_frozen_dinner', label = 'Frozen TV Dinner', price = 7 },

                -- Coffee & Beverages
                { item = 'fsg_coffee_beans', label = 'Coffee Beans', price = 5 },
                { item = 'fsg_applejuice', label = 'Apple Juice', price = 4 },
                { item = 'fsg_toasti', label = 'Toastie', price = 4 },
                { item = 'fsg_choccream', label = 'Chocolate Cream', price = 4 },
                { item = 'fsg_berrycream', label = 'Strawberry Cream', price = 4 },
                { item = 'fsg_cocoapod', label = 'Cocoa Pod', price = 4 },
                { item = 'fsg_vaniwafers', label = 'Vanilla Wafers', price = 4 },
                { item = 'fsg_pudding', label = 'Pudding', price = 4 },

                { item = 'fsg_popcorn_bag', label = 'Microwaveable Popcorn', price = 4 },

            },
            
           
        }
    },
    -- to add multiple shops
}