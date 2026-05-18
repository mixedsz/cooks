-- Cooking Flow System
-- Each recipe can have a cookingFlow which defines a sequence of cooking steps
-- Each step has:
--   label: The text to display during the progress bar
--   time: Duration of this step in seconds
--   position: Where to display the progress bar ("bottom", "middle", etc)
--   skillCheck: Whether this step requires a skill check
--     enabled: Whether the skill check is enabled for this step
--     difficulty: "easy", "medium", or "medium" 
--     inputs: Array of keys required for the skill check

Config.Recipes = {
    -- BBQ Grill Recipes
    bbq_burger = {
        label = "BBQ Burger",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_beef", count = 1 },
            { item = "flake_burger_bun", count = 1 },
        },
        resultItems = {
            { item = "flake_bbq_burger", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing patty...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling patty...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Assembling burger...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_steak = {
        label = "BBQ Steak",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_steak", count = 1 },
        },
        resultItems = {
            { item = "flake_cooked_steak", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Seasoning steak...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Searing steak...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Flipping steak...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Finishing steak...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_fancy_steak = {
        label = "Fancy Steak",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_steak", count = 1 },
            { item = "flake_butter", count = 1 },
            { item = "flake_herbs", count = 1 },
        },
        resultItems = {
            { item = "flake_fancy_steak", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing steak...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Searing steak...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Basting with butter...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Resting steak...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_ribs = {
        label = "BBQ Ribs",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_pork_ribs", count = 1 },
            { item = "flake_bbq_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_bbq_ribs", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Seasoning ribs...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Slow cooking ribs...",
                time = 15,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding BBQ sauce...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_chicken = {
        label = "BBQ Chicken",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_chicken", count = 1 },
            { item = "flake_bbq_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_bbq_chicken", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing chicken...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling chicken...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding sauce...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_sausages = {
        label = "BBQ Sausages",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_sausages", count = 2 },
        },
        resultItems = {
            { item = "flake_bbq_sausages", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Grilling sausages...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Turning sausages...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_vegetables = {
        label = "Grilled Vegetables",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_bell_pepper", count = 2 },
            { item = "flake_zucchini", count = 1 },
            { item = "flake_eggplant", count = 1 },
        },
        resultItems = {
            { item = "flake_grilled_vegetables", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing vegetables...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling vegetables...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_corn = {
        label = "Grilled Corn",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_corn", count = 1 },
            { item = "flake_butter", count = 1 },
        },
        resultItems = {
            { item = "flake_grilled_corn", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing corn...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Grilling corn...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding butter...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_fish = {
        label = "Grilled Fish",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_fish", count = 1 },
            { item = "flake_lemon", count = 1 },
        },
        resultItems = {
            { item = "flake_grilled_fish", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing fish...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling fish...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding lemon...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_shrimp = {
        label = "Grilled Shrimp",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_raw_shrimp", count = 4 },
            { item = "flake_garlic", count = 1 },
        },
        resultItems = {
            { item = "flake_grilled_shrimp", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing shrimp...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling shrimp...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    bbq_pork = {
        label = "BBQ Pulled Pork",
        appliance = "bbq",
        requiredItems = {
            { item = "flake_pork_shoulder", count = 1 },
            { item = "flake_bbq_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_pulled_pork", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating grill...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Preparing pork...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Slow cooking pork...",
                time = 15,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Pulling and saucing...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    -- Microwave Recipes
    microwave_popcorn = {
        label = "Microwave Popcorn",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_popcorn_bag", count = 1 },
        },
        resultItems = {
            { item = "flake_popcorn", count = 1 },
        },
        cookingFlow = {
            {
                label = "Placing popcorn in microwave...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Setting timer...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving popcorn...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_tv_dinner = {
        label = "TV Dinner",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_frozen_dinner", count = 1 },
        },
        resultItems = {
            { item = "flake_tv_dinner", count = 1 },
        },
        cookingFlow = {
            {
                label = "Removing packaging...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Piercing film...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Heating dinner...",
                time = 15,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring contents...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_ramen = {
        label = "Microwave Ramen",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_ramen_noodles", count = 1 },
            { item = "flake_water", count = 1 },
        },
        resultItems = {
            { item = "flake_ramen", count = 1 },
        },
        cookingFlow = {
            {
                label = "Adding water...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving ramen...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring noodles...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_oatmeal = {
        label = "Microwave Oatmeal",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_oatmeal", count = 1 },
            { item = "flake_water", count = 1 },
        },
        resultItems = {
            { item = "flake_cooked_oatmeal", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing ingredients...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving oatmeal...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring oatmeal...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_mug_cake = {
        label = "Mug Cake",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_cake_mix", count = 1 },
            { item = "flake_milk", count = 1 },
        },
        resultItems = {
            { item = "flake_microwave_chocolate_mug_cake", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing ingredients...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Microwaving cake...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_eggs = {
        label = "Scrambled Eggs",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_egg", count = 2 },
            { item = "flake_milk", count = 1 },
        },
        resultItems = {
            { item = "flake_scrambled_eggs", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing eggs...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Microwaving eggs...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring eggs...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_baked_potato = {
        label = "Baked Potato",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_potato", count = 1 },
        },
        resultItems = {
            { item = "flake_baked_potato", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing potato...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving potato...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_quesadilla = {
        label = "Quesadilla",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_tortilla", count = 2 },
            { item = "flake_cheese", count = 1 },
        },
        resultItems = {
            { item = "flake_quesadilla", count = 1 },
        },
        cookingFlow = {
            {
                label = "Assembling quesadilla...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Microwaving quesadilla...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_hot_chocolate = {
        label = "Hot Chocolate",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_milk", count = 1 },
            { item = "flake_chocolate", count = 1 },
        },
        resultItems = {
            { item = "flake_hot_chocolate", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing ingredients...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving chocolate...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring chocolate...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_mac_cheese = {
        label = "Mac and Cheese",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_macaroni", count = 1 },
            { item = "flake_cheese", count = 1 },
            { item = "flake_milk", count = 1 },
        },
        resultItems = {
            { item = "flake_microwave_mac_cheese", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing ingredients...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Microwaving mac and cheese...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring mac and cheese...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    microwave_soup = {
        label = "Microwave Soup",
        appliance = "microwave",
        requiredItems = {
            { item = "flake_soup_mix", count = 1 },
            { item = "flake_water", count = 1 },
        },
        resultItems = {
            { item = "flake_soup", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing ingredients...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Microwaving soup...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Stirring soup...",
                time = 2,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@mp_player_intmenu@key_fob@",
            clip = "fob_click",
        },
    },
    stove_pasta = {
        label = "Pasta Dish",
        appliance = "stove",
        requiredItems = {
            { item = "flake_pasta", count = 1 },
            { item = "flake_tomato", count = 2 },
        },
        resultItems = {
            { item = "flake_pasta_dish", count = 1 },
        },
        cookingFlow = {
            {
                label = "Boiling water...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Cooking pasta...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Making sauce...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Mixing pasta and sauce...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_risotto = {
        label = "Mushroom Risotto",
        appliance = "stove",
        requiredItems = {
            { item = "flake_rice", count = 1 },
            { item = "flake_mushroom", count = 2 },
        },
        resultItems = {
            { item = "flake_risotto", count = 1 },
        },
        cookingFlow = {
            {
                label = "Heating broth...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Sautéing mushrooms...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Stirring risotto...",
                time = 15,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding finishing touches...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    juicer_smoothie = {
        label = "Fruit Smoothie",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_banana", count = 1 },
            { item = "flake_strawberry", count = 2 },
        },
        resultItems = {
            { item = "flake_smoothie", count = 1 },
        },
        cookingFlow = {
            {
                label = "Adding fruits...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Adding ice...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Blending smoothie...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Pouring smoothie...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_orange_juice = {
        label = "Orange Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_orange", count = 3 },
        },
        resultItems = {
            { item = "flake_orange_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing oranges...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing oranges...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_apple_juice = {
        label = "Apple Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_apple", count = 3 },
        },
        resultItems = {
            { item = "flake_apple_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing apples...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing apples...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_carrot_juice = {
        label = "Carrot Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_carrot", count = 4 },
        },
        resultItems = {
            { item = "flake_carrot_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing carrots...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing carrots...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_tomato_juice = {
        label = "Tomato Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_tomato", count = 4 },
        },
        resultItems = {
            { item = "flake_tomato_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing tomatoes...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing tomatoes...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_grape_juice = {
        label = "Grape Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_grapes", count = 2 },
        },
        resultItems = {
            { item = "flake_grape_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing grapes...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing grapes...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_pineapple_juice = {
        label = "Pineapple Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_pineapple", count = 1 },
        },
        resultItems = {
            { item = "flake_pineapple_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing pineapple...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing pineapple...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_watermelon_juice = {
        label = "Watermelon Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_watermelon", count = 1 },
        },
        resultItems = {
            { item = "flake_watermelon_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing watermelon...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing watermelon...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_celery_juice = {
        label = "Celery Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_celery", count = 3 },
        },
        resultItems = {
            { item = "flake_celery_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing celery...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing celery...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    juicer_beet_juice = {
        label = "Beet Juice",
        appliance = "juicer",
        requiredItems = {
            { item = "flake_beet", count = 2 },
        },
        resultItems = {
            { item = "flake_beet_juice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing beets...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Juicing beets...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        animation = {
            dict = "mp_safehousebeer@",
            clip = "enter",
        },
    },
    fryer_fish_and_chips = {
        label = "Fish and Chips",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_raw_fish", count = 1 },
            { item = "flake_potato", count = 2 },
        },
        resultItems = {
            { item = "flake_fish_and_chips", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing fish...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cutting potatoes...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying fish...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying chips...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    -- Stove Recipes
    stove_omelette = {
        label = "Omelette",
        appliance = "stove",
        requiredItems = {
            { item = "flake_egg", count = 3 },
            { item = "flake_cheese", count = 1 },
        },
        resultItems = {
            { item = "flake_omelette", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating pan...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Mixing eggs...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking omelette...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding cheese...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_pancakes = {
        label = "Pancakes",
        appliance = "stove",
        requiredItems = {
            { item = "flake_pancake_mix", count = 1 },
            { item = "flake_milk", count = 1 },
            { item = "flake_egg", count = 1 },
        },
        resultItems = {
            { item = "flake_pancakes", count = 1 },
        },
        cookingFlow = {
            {
                label = "Mixing batter...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking pancakes...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Flipping pancakes...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_stir_fry = {
        label = "Stir Fry",
        appliance = "stove",
        requiredItems = {
            { item = "flake_rice", count = 1 },
            { item = "flake_vegetables", count = 2 },
            { item = "flake_soy_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_stir_fry", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating wok...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Cooking rice...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Stir frying vegetables...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding sauce...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_curry = {
        label = "Curry",
        appliance = "stove",
        requiredItems = {
            { item = "flake_rice", count = 1 },
            { item = "flake_curry_paste", count = 1 },
            { item = "flake_coconut_milk", count = 1 },
        },
        resultItems = {
            { item = "flake_curry", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating pot...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Cooking rice...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Making curry sauce...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Combining ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_soup = {
        label = "Homemade Soup",
        appliance = "stove",
        requiredItems = {
            { item = "flake_vegetables", count = 3 },
            { item = "flake_chicken_stock", count = 1 },
        },
        resultItems = {
            { item = "flake_homemade_soup", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing vegetables...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Making stock...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Simmering soup...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_steak = {
        label = "Pan-Seared Steak",
        appliance = "stove",
        requiredItems = {
            { item = "flake_raw_steak", count = 1 },
            { item = "flake_butter", count = 1 },
        },
        resultItems = {
            { item = "flake_pan_seared_steak", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating pan...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Seasoning steak...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Searing steak...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding butter...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_fried_rice = {
        label = "Fried Rice",
        appliance = "stove",
        requiredItems = {
            { item = "flake_rice", count = 1 },
            { item = "flake_egg", count = 2 },
            { item = "flake_soy_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_rice", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preheating wok...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Cooking eggs...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying rice...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Adding sauce...",
                time = 3,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_crepes = {
        label = "Crepes",
        appliance = "stove",
        requiredItems = {
            { item = "flake_flour", count = 1 },
            { item = "flake_milk", count = 1 },
            { item = "flake_egg", count = 2 },
        },
        resultItems = {
            { item = "flake_crepes", count = 1 },
        },
        cookingFlow = {
            {
                label = "Making batter...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking crepes...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Flipping crepes...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    stove_quiche = {
        label = "Quiche",
        appliance = "stove",
        requiredItems = {
            { item = "flake_pie_crust", count = 1 },
            { item = "flake_egg", count = 3 },
            { item = "flake_cheese", count = 1 },
        },
        resultItems = {
            { item = "flake_quiche", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing crust...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Making filling...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Baking quiche...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    -- Fryer Recipes
    fryer_fish_and_chips = {
        label = "Fish and Chips",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_raw_fish", count = 1 },
            { item = "flake_potato", count = 2 },
        },
        resultItems = {
            { item = "flake_fish_and_chips", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing fish...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cutting potatoes...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying fish...",
                time = 12,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying chips...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_chicken_wings = {
        label = "Fried Chicken Wings",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_chicken_wings", count = 4 },
            { item = "flake_flour", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_chicken_wings", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing wings...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating wings...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying wings...",
                time = 10,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_onion_rings = {
        label = "Onion Rings",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_onion", count = 2 },
            { item = "flake_flour", count = 1 },
        },
        resultItems = {
            { item = "flake_onion_rings", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing onions...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating rings...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying rings...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_mozzarella_sticks = {
        label = "Mozzarella Sticks",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_mozzarella", count = 2 },
            { item = "flake_breadcrumbs", count = 1 },
        },
        resultItems = {
            { item = "flake_mozzarella_sticks", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing cheese...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating sticks...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying sticks...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_chicken_nuggets = {
        label = "Chicken Nuggets",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_chicken_breast", count = 1 },
            { item = "flake_breadcrumbs", count = 1 },
        },
        resultItems = {
            { item = "flake_chicken_nuggets", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing chicken...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating nuggets...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying nuggets...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_spring_rolls = {
        label = "Spring Rolls",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_spring_roll_wrapper", count = 2 },
            { item = "flake_vegetables", count = 2 },
        },
        resultItems = {
            { item = "flake_spring_rolls", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing filling...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Wrapping rolls...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying rolls...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_calamari = {
        label = "Fried Calamari",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_squid", count = 1 },
            { item = "flake_flour", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_calamari", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing squid...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating calamari...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying calamari...",
                time = 8,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_shrimp = {
        label = "Fried Shrimp",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_raw_shrimp", count = 4 },
            { item = "flake_breadcrumbs", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_shrimp", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing shrimp...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating shrimp...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying shrimp...",
                time = 6,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_cheese_curds = {
        label = "Cheese Curds",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_cheese_curds", count = 1 },
            { item = "flake_flour", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_cheese_curds", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing curds...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = false
                }
            },
            {
                label = "Coating curds...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying curds...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },
    fryer_okra = {
        label = "Fried Okra",
        appliance = "fryer",
        requiredItems = {
            { item = "flake_okra", count = 3 },
            { item = "flake_cornmeal", count = 1 },
        },
        resultItems = {
            { item = "flake_fried_okra", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing okra...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Coating okra...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Frying okra...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "anim@amb@business@weed@weed_inspecting_lo_med_hi@",
            clip = "weed_crouch_checkingleaves_idle_01_inspector",
        },
    },

    -- Griddle 

    griddle_salmon = {
        label = "Grilled Salmon",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_salmon", count = 1 },
            { item = "flake_butter", count = 1 },
        },
        resultItems = {
            { item = "flake_salmon", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing salmon...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning salmon...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Grilling salmon...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    griddle_beef_stir_fry = {
        label = "Beef Stir Fry",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_beef", count = 1 },
            { item = "flake_vegetables", count = 2 },
        },
        resultItems = {
            { item = "flake_bstirfry", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Beef...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning Beef...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Beef Stir Fry...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    griddle_chicken_sandwich = {
        label = "Chicken Sandwich",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_chicken", count = 1 },
            { item = "flake_vegetables", count = 2 },
            
        },
        resultItems = {
            { item = "flake_chickensand", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Chicken...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning Chicken...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Chicken Sandwich...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    griddle_beef_fried_rice = {
        label = "Beef Fried Rice",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_beef", count = 1 },
            { item = "flake_rice", count = 1 },
            { item = "flake_soy_sauce", count = 1 },
            { item = "flake_vegetables", count = 2 },
            
        },
        resultItems = {
            { item = "flake_bffriedrice", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Beef...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning Beef...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Beef Fried Rice...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    griddle_chicken_fried_rice = {
        label = "Chicken Fried Rice",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_chicken", count = 1 },
            { item = "flake_rice", count = 1 },
            { item = "flake_soy_sauce", count = 1 },
            { item = "flake_vegetables", count = 2 },
            
        },
        resultItems = {
            { item = "flake_ckfriedrice", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Chicken...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning Chicken...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Chicken Fried Rice...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    griddle_pepper_shrimp = {
        label = "Pepper Shrimp",
        appliance = "griddle",
        requiredItems = {
            { item = "flake_raw_shrimp", count = 1 },
            { item = "flake_pepper", count = 1 },
            { item = "flake_vegetables", count = 1 },
            { item = "flake_rice", count = 1 },

        },
        resultItems = {
            { item = "flake_pepshrimp", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Shrimp...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Seasoning Shrimp...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Pepper Shrimp...",
                time = 7,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "medium",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    -- TOASTER RECIPES
    toaster_toast = {
        label = "Toast",
        appliance = "toaster",
        requiredItems = {
            { item = "flake_bread", count = 1 },
            { item = "flake_butter", count = 1 },
        },
        resultItems = {
            { item = "flake_toast", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Bread...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Toast...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    toaster_waffle = {
        label = "Waffle",
        appliance = "toaster",
        requiredItems = {
            { item = "flake_frozewaff", count = 1 },
            { item = "flake_butter", count = 1 },
            { item = "flake_syrup", count = 1 },
        },
        resultItems = {
            { item = "flake_waffle", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Waffle...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Cooking Waffle...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    toaster_toasti = {
        label = "Cheese Toastie",
        appliance = "toaster",
        requiredItems = {
            { item = "flake_bread", count = 1 },
            { item = "flake_cheese", count = 1 },
            { item = "flake_butter", count = 1 },
        },
        resultItems = {
            { item = "flake_toasti", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Toastie...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Toasting...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    
    toaster_hamtoastie = {
        label = "Ham Toastie",
        appliance = "toaster",
        requiredItems = {
            { item = "flake_bread", count = 1 },
            { item = "flake_hamslice", count = 1 },
            { item = "flake_cheese", count = 1 },
        },
        resultItems = {
            { item = "flake_hamtoastie", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ham Toastie...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Toasting...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },


    -- PROCESSOR RECIPES

    processor_applesauce = {
        label = "Apple Sauce",
        appliance = "processor",
        requiredItems = {
            { item = "flake_apple", count = 1 },
            { item = "flake_sugar", count = 1 },
            { item = "flake_applejuice", count = 1 },
        },
        resultItems = {
            { item = "flake_applesauce", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    
    processor_nanacream = {
        label = "Banana Cream",
        appliance = "processor",
        requiredItems = {
            { item = "flake_banana", count = 1 },
            { item = "flake_choccream", count = 1 },
            { item = "flake_berrycream", count = 1 },
        },
        resultItems = {
            { item = "flake_nanacream", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    
    processor_berrycream = {
        label = "Berry Cream",
        appliance = "processor",
        requiredItems = {
            { item = "flake_strawberry", count = 1 },
            { item = "flake_milk", count = 1 },
            { item = "flake_ice", count = 1 },
        },
        resultItems = {
            { item = "flake_berrycream", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    
    processor_choccream = {
        label = "Chocolate Cream",
        appliance = "processor",
        requiredItems = {
            { item = "flake_cocoapod", count = 1 },
            { item = "flake_milk", count = 1 },
            { item = "flake_ice", count = 1 },
        },
        resultItems = {
            { item = "flake_choccream", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    
    processor_bpudding = {
        label = "Banana Pudding",
        appliance = "processor",
        requiredItems = {
            { item = "flake_banana", count = 1 },
            { item = "flake_vaniwafers", count = 1 },
            { item = "flake_pudding", count = 1 },
        },
        resultItems = {
            { item = "flake_bpudding", count = 2 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    pizzaoven_chicken_pesto_pizza = {
        label = "Chicken Pesto Pizza",
        appliance = "pizzaoven",
        requiredItems = {
            { item = "flake_pizza_dough", count = 1 },
            { item = "flake_pesto_sauce", count = 1 },
        },
        resultItems = {
            { item = "flake_chicken_pesto_pizza", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

    pizzaoven_meatlovers_pizza = {
        label = "Meatlovers Pizza",
        appliance = "pizzaoven",
        requiredItems = {
            { item = "flake_pizza_dough", count = 1 },
            { item = "flake_chicken_breast", count = 1 },
            { item = "flake_pepperoni", count = 1 },
        },
        resultItems = {
            { item = "flake_meatlovers_pizza", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    pizzaoven_pepperoni_pizza = {
        label = "Pepperoni Pizza",
        appliance = "pizzaoven",
        requiredItems = {
            { item = "flake_pizza_dough", count = 1 },
            { item = "flake_pepperoni", count = 1 },
        },
        resultItems = {
            { item = "flake_pepperoni_pizza", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },
    pizzaoven_pineapple_pizza = {
        label = "Pineapple Pizza",
        appliance = "pizzaoven",
        requiredItems = {
            { item = "flake_pizza_dough", count = 1 },
            { item = "flake_pineapple", count = 1 },
        },
        resultItems = {
            { item = "flake_pineapple_pizza", count = 1 },
        },
        cookingFlow = {
            {
                label = "Preparing Ingredients...",
                time = 5,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            },
            {
                label = "Processing...",
                time = 4,
                position = "bottom",
                skillCheck = {
                    enabled = true,
                    difficulty = "easy",
                    inputs = {"w", "a", "s", "d"}
                }
            }
        },
        failedResultItems = {
            { item = "flake_burnt_food", count = 1 },
        },
        animation = {
            dict = "amb@prop_human_bbq@male@idle_a",
            clip = "idle_b",
        },
    },

}