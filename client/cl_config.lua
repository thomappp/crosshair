CROSSHAIR = {
    
    Preset = {
        {
            Name = "Basique",
            Dot = true,
            Thickness = 1,
            Width = 3,
            Offset = 3
        },

        {
            Name = "Carré",
            Dot = false,
            Thickness = 7,
            Width = 1,
            Offset = 6
        },

        {
            Name = "Rond",
            Dot = false,
            Thickness = 2,
            Width = 1,
            Offset = 10
        }
    },

    Colors = {
        { Name = "Noir", R = 1, G = 1, B = 1 },
        { Name = "Gris", R = 96, G = 96, B = 96 },
        { Name = "Blanc", R = 255, G = 255, B = 255 },
        { Name = "Rouge", R = 200, G = 1, B = 1 },
        { Name = "Rose", R = 200, G = 50, B = 150 },
        { Name = "Vert", R = 1, G = 200, B = 1 },
        { Name = "Bleu", R = 1, G = 1, B = 150 },
        { Name = "Cyan", R = 1, G = 255, B = 255 },
        { Name = "Orange", R = 255, G = 125, B = 1 },
        { Name = "Jaune", R = 255, G = 255, B = 1 }
    },
    
    Cross = { Index = 1, Table = { "Basique", "Customisé" } },

    Dot = true,
    ColorR = { Index = 255, Table = {} },
    ColorG = { Index = 255, Table = {} },
    ColorB = { Index = 255, Table = {} },
    ColorA = { Index = 255, Table = {} },

    Thicknesses = {
        Index = 1,
        Menu = {},
        Table = {
            0.002, 0.004, 0.006, 0.008, 0.01, 0.012, 0.014
        }
    },

    Widths = {
        Index = 3,
        Menu = {},
        Table = {
            0.002, 0.0025, 0.003, 0.0035, 0.004, 0.0045,
            0.005, 0.0055, 0.006, 0.0065, 0.007, 0.0075,
            0.008, 0.0085, 0.009,
        }
    },

    Offsets = {
        Index = 3,
        Menu = {},
        Table = {
            0.0, 0.0005, 0.001, 0.0015, 0.002, 0.0025, 0.003,
            0.0035, 0.004, 0.0045, 0.005, 0.0055, 0.006, 0.0065,
            0.007, 0.0075, 0.008, 0.0085, 0.009, 0.0095, 0.01
        }
    }
}