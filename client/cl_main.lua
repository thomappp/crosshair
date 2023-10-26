function CROSSHAIR:Thread()

    self:Load()

    MainMenu = RageUI.CreateMenu("Réticule", "Modifer le reticule");
    ColorMenu = RageUI.CreateSubMenu(MainMenu, "Réticule", "Couleur predefinies");
    CrossMenu = RageUI.CreateSubMenu(MainMenu, "Réticule", "Reticules predefinies");
    CrosshairActive = true

    CreateThread(function()
        while true do
            
            local PlayerWait = 5

            if IsAimCamActive() then
                if CrosshairActive then
                    if not self:IsCrosshairBasic() then
                        self:DrawCrosshair()
                        HideHudComponentThisFrame(14)
                    end
                else
                    HideHudComponentThisFrame(14)
                end
            end

            if RageUI.Visible(MainMenu) or
                RageUI.Visible(ColorMenu) or
                RageUI.Visible(CrossMenu) or
                RageUI.Visible(RegisteredMenu) then
                    
                if self:IsCrosshairBasic() then
                    ShowHudComponentThisFrame(14)
                else
                    self:DrawCrosshair()
                end
            end

            Wait(PlayerWait)
        end
    end)

    function RageUI.PoolMenus:CreatorMenu()
        MainMenu:IsVisible(function(Items)

            Items:CheckBox("Réticule actif", nil, CrosshairActive, { IsDisabled = false }, function(onSelected, IsChecked)
                if (onSelected) then
                    CrosshairActive = IsChecked
                end
            end)

            Items:AddList("Réticule", CROSSHAIR.Cross.Table, CROSSHAIR.Cross.Index, "Chosir le réticule actif", { IsDisabled = false }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.Cross.Index = Index
                end
            end)

            local CanUseButton = CROSSHAIR:IsCrosshairBasic()

            Items:AddSeparator("~y~Paramètres")

            Items:CheckBox("Point", nil, CROSSHAIR.Dot, { IsDisabled = false }, function(onSelected, IsChecked)
                if (onSelected) then
                    CROSSHAIR.Dot = IsChecked
                end
            end)

            Items:AddList("Epaisseur", CROSSHAIR.Thicknesses.Table, CROSSHAIR.Thicknesses.Index, "Modifier l'épaisseur du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.Thicknesses.Index = Index
                end
            end)

            Items:AddList("Largeur", CROSSHAIR.Widths.Table, CROSSHAIR.Widths.Index, "Modifier la largeur du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.Widths.Index = Index
                end
            end)

            Items:AddList("Décalage", CROSSHAIR.Offsets.Table, CROSSHAIR.Offsets.Index, "Modifier le décalage du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.Offsets.Index = Index
                end
            end)

            Items:AddButton("Réticules prédéfinies", "Liste des réticules prédéfinies", { IsDisabled = CanUseButton, RightLabel = "→" }, function(onSelected)
            end, CrossMenu)

            Items:AddSeparator("~y~Couleur")

            Items:AddList("Rouge", CROSSHAIR.ColorR.Table, CROSSHAIR.ColorR.Index, "Modifier le spectre rouge du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.ColorR.Index = Index
                end
            end)

            Items:AddList("Vert", CROSSHAIR.ColorG.Table, CROSSHAIR.ColorG.Index, "Modifier le spectre vert du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.ColorG.Index = Index
                end
            end)

            Items:AddList("Bleu", CROSSHAIR.ColorB.Table, CROSSHAIR.ColorB.Index, "Modifier le spectre bleu du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.ColorB.Index = Index
                end
            end)

            Items:AddList("Opacité", CROSSHAIR.ColorA.Table, CROSSHAIR.ColorA.Index, "Modifier l'opacité du réticule", { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.ColorA.Index = Index
                end
            end)

            Items:AddButton("Couleurs prédéfinies", "Liste des couleurs prédéfinies", { IsDisabled = CanUseButton, RightLabel = "→" }, function(onSelected)
            end, ColorMenu)

        end, function()
        end)

        ColorMenu:IsVisible(function(Items)

            for i = 1, #CROSSHAIR.Colors do

                local Color = CROSSHAIR.Colors[i]

                Items:AddButton(Color.Name, nil, { IsDisabled = false }, function(onSelected)
                    if (onSelected) then
                        CROSSHAIR.ColorR.Index = Color.R
                        CROSSHAIR.ColorG.Index = Color.G
                        CROSSHAIR.ColorB.Index = Color.B
                    end
                end)
            end

        end, function()
        end)

        CrossMenu:IsVisible(function(Items)

            for i = 1, #CROSSHAIR.Preset do

                local Cross = CROSSHAIR.Preset[i]

                Items:AddButton(Cross.Name, nil, { IsDisabled = false }, function(onSelected)
                    if (onSelected) then
                        CROSSHAIR.Dot = Cross.Dot
                        CROSSHAIR.Thicknesses.Index = Cross.Thickness
                        CROSSHAIR.Widths.Index = Cross.Width
                        CROSSHAIR.Offsets.Index = Cross.Offset
                    end
                end)
            end

        end, function()
        end)
    end

    Keys.Register("F10", "F10", "Menu Réticule", function()
        RageUI.Visible(MainMenu, not RageUI.Visible(MainMenu))
    end)

    AddEventHandler("onResourceStop", function(ResourceName)
        if ResourceName == GetCurrentResourceName() then
            if not self:IsCrosshairBasic() then
                self:Text("~y~Le réticule customisé a été désactivé.")
            end
        end
    end)
end

AddEventHandler("onResourceStart", function(ResourceName)
    if ResourceName == GetCurrentResourceName() then
        CROSSHAIR:Thread()
    end
end)