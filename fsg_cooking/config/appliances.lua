-- Appliance Effects System
-- Each appliance can have effects that display during cooking
-- Effects configuration:
--   effects: Table of effects for the appliance 
--     [effect_type]: The type of effect (e.g., "smoke", "fire", "steam")
--       name: The particle effect name
--       offset: Position offset for the effect (vec3)
--       scale: Size scale for the effect (float)
-- An appliance can have multiple effects at once, such as both smoke and fire

Config.CookingProps = {
    bbq = {
        label = "BBQ Grill",
        model = "prop_bbq_1",
        item = "fsg_bbq_grill",
        offset = vec3(0.0, 0.0, 1.0),
        cookingPoint = vec3(0.0, 0.5, 0.5), -- Relative position for cooking
        requiredHandItem = "spatula", -- Required handheld item for cooking
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
        effects = {
            smoke = {
                name = "ent_amb_smoke_foundry",
                offset = vec3(0.0, 0.0, 0.7),
                scale = 1.5
            },
            fire = {
                name = "ent_amb_torch_fire",
                offset = vec3(0.0, 0.0, 0.7),
                scale = 0.6
            }
        },
        handProp = {
            model = "prop_fish_slice_01", -- Spatula model
            bone = 57005, -- Right hand
            offset = { x = 0.12, y = 0.0, z = 0.0 },
            rotation = { x = 0.0, y = 120.0, z = 0.0 }
        }
    },
    pizzaoven = {
        label = "Pizza Oven",
        model = "prop_bbq_3",
        item = "fsg_pizza_oven",
        offset = vec3(0.0, 0.0, 1.0),
        cookingPoint = vec3(0.0, 0.5, 0.5), -- Relative position for cooking
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
        effects = {
            smoke = {
                name = "ent_amb_smoke_foundry",
                offset = vec3(0.0, 0.0, 0.7),
                scale = 1.5
            },
            fire = {
                name = "ent_amb_torch_fire",
                offset = vec3(0.0, 0.0, 0.7),
                scale = 0.6
            }
        },
        handProp = {
            model = "prop_pizza_paddle", -- Pizza paddle
            bone = 57005, -- Right hand
            offset = { x = 0.2, y = 0.0, z = 0.0 },
            rotation = { x = 0.0, y = -40.0, z = 0.0 }
        }
    },
    microwave = {
        label = "Microwave",
        model = "prop_microwave_1",
        item = "fsg_microwave",
        offset = vec3(0.0, 0.0, 0.5),
        cookingPoint = vec3(0.0, 0.0, 0.2), -- Relative position for cooking
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
    stove = {
        label = "Stove",
        model = "prop_cooker_03",
        item = "fsg_stove",
        offset = vec3(0.0, 0.0, 1.0),
        cookingPoint = vec3(0.0, 0.5, 0.5),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
        effects = {
            steam = {
                name = "ent_amb_steam",
                offset = vec3(0.0, 0.0, 0.6),
                scale = 0.3
            },
            smoke = {
                name = "ent_amb_smoke_factory_white",
                offset = vec3(0.0, 0.0, 0.7),
                scale = 0.2
            }
        }
    },
    juicer = {
        label = "Juicer",
        model = "prop_kitch_juicer",
        item = "fsg_juicer",
        offset = vec3(0.0, 0.0, 0.5),
        cookingPoint = vec3(0.0, 0.2, 0.3),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
    -- brewer = {
    --     label = "Brewer",
    --     model = "prop_coffee_mac_02",
    --     item = "fsg_brewer",
    --     offset = vec3(0.0, 0.0, 0.5),
    --     cookingPoint = vec3(0.0, 0.1, 0.3),
    --     animation = {
    --         dict = "anim@heists@narcotics@trash",
    --         clip = "drop_front",
    --     },
    -- },
    toaster = {
        label = "Toaster",
        model = "prop_toaster_02",
        item = "fsg_toaster",
        offset = vec3(0.0, 0.0, 0.4),
        cookingPoint = vec3(0.0, 0.0, 0.2),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
    fryer = {
        label = "Fryer",
        model = "prop_copper_pan",
        item = "fsg_fryer",
        offset = vec3(0.0, 0.0, 0.3),
        cookingPoint = vec3(0.0, 0.1, 0.3),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
    griddle = {
        label = "Griddle",
        model = "prop_griddle_01",
        item = "fsg_griddle",
        offset = vec3(0.0, 0.0, 0.4),
        cookingPoint = vec3(0.0, 0.3, 0.4),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
    processor = {
        label = "Processor",
        model = "prop_foodprocess_01",
        item = "fsg_processor",
        offset = vec3(0.0, 0.0, 0.5),
        cookingPoint = vec3(0.0, 0.2, 0.3),
        animation = {
            dict = "anim@heists@narcotics@trash",
            clip = "drop_front",
        },
    },
}