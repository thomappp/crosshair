function CROSSHAIR:Thread()

    self:Load()

    MainMenu = RageUI.CreateMenu("Réticule", "Modifer le reticule");
    ColorMenu = RageUI.CreateSubMenu(MainMenu, "Réticule", "Couleur predefinies");
    FavMenu = RageUI.CreateSubMenu(MainMenu, "Réticule", "Preferences");
    CrossMenu = RageUI.CreateSubMenu(MainMenu, "Réticule", "Reticules predefinies");

    CreateThread(function()
        while true do
            
            local PlayerWait = 5

            if IsAimCamActive() then
                if self.Active then
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
                RageUI.Visible(FavMenu) or
                RageUI.Visible(CrossMenu) then
                    
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

            Items:CheckBox("Réticule actif", nil, CROSSHAIR.Active, { IsDisabled = false }, function(onSelected, IsChecked)
                if (onSelected) then
                    CROSSHAIR.Active = IsChecked
                end
            end)

            Items:AddList("Réticule", CROSSHAIR.CrossMode.Table, CROSSHAIR.CrossMode.Index, "Chosir le réticule actif", { IsDisabled = false }, function(Index, Selected, onListChange, Active)
                if (onListChange) then
                    CROSSHAIR.CrossMode.Index = Index
                end
            end)

            local CanUseButton = CROSSHAIR:IsCrosshairBasic()

            Items:AddSeparator("~y~Paramètres")

            for i = 1, #CROSSHAIR.SetMenuButtons do
                local Set = CROSSHAIR.SetMenuButtons[i]

                Items:AddList(Set.Name, CROSSHAIR[Set.Data].Menu, CROSSHAIR[Set.Data].Index, Set.Description, { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                    if (onListChange) then
                        CROSSHAIR[Set.Data].Index = Index
                    end
                end)
            end

            Items:AddButton("Préférences", nil, { IsDisabled = CanUseButton, RightLabel = "→" }, function(onSelected)
            end, FavMenu)

            Items:AddButton("Réticules prédéfinies", "Liste des réticules prédéfinies", { IsDisabled = CanUseButton, RightLabel = "→" }, function(onSelected)
            end, CrossMenu)

            Items:AddSeparator("~y~Couleurs")

            for i = 1, #CROSSHAIR.ColorMenuButtons do
                local Color = CROSSHAIR.ColorMenuButtons[i]

                Items:AddList(Color.Name, CROSSHAIR[Color.Data].Table, CROSSHAIR[Color.Data].Index, Color.Description, { IsDisabled = CanUseButton }, function(Index, Selected, onListChange, Active)
                    if (onListChange) then
                        CROSSHAIR[Color.Data].Index = Index
                    end
                end)
            end

            Items:AddButton("Couleurs prédéfinies", "Liste des couleurs prédéfinies", { IsDisabled = CanUseButton, RightLabel = "→" }, function(onSelected)
            end, ColorMenu)

        end, function()
        end)

        ColorMenu:IsVisible(function(Items)

            for i = 1, #CROSSHAIR.ColorsMenuButtons do

                local Color = CROSSHAIR.ColorsMenuButtons[i]

                Items:AddButton(Color.Name, nil, { IsDisabled = CanUseButton }, function(onSelected)
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

            for i = 1, #CROSSHAIR.PresetMenuButtons do

                local Cross = CROSSHAIR.PresetMenuButtons[i]

                Items:AddButton(Cross.Name, nil, { IsDisabled = CanUseButton }, function(onSelected)
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

        FavMenu:IsVisible(function(Items)

            Items:CheckBox("Point", "Point central", CROSSHAIR.Dot, { IsDisabled = CanUseButton }, function(onSelected, IsChecked)
                if (onSelected) then
                    if CanUseButton then return end
                    CROSSHAIR.Dot = IsChecked
                end
            end)

            for i = 1, #CROSSHAIR.FavMenuButtons do

                local Fav = CROSSHAIR.FavMenuButtons[i]

                Items:CheckBox(Fav.Name, Fav.Description, CROSSHAIR[Fav.Data], { IsDisabled = CanUseButton }, function(onSelected, IsChecked)
                    if (onSelected) then
                        CROSSHAIR[Fav.Data] = IsChecked
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