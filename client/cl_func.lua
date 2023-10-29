function CROSSHAIR:Text(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

function CROSSHAIR:IsCrosshairBasic()
    return self.CrossMode.Index == 1
end

function CROSSHAIR:Load()
    for i = 1, 255 do
        table.insert(self.ColorR.Table, i)
        table.insert(self.ColorG.Table, i)
        table.insert(self.ColorB.Table, i)
        table.insert(self.ColorA.Table, i)
    end

    for i = 1, #self.Thicknesses.Table do
        table.insert(self.Thicknesses.Menu, i)
    end

    for i = 1, #self.Widths.Table do
        table.insert(self.Widths.Menu, i)
    end

    for i = 1, #self.Offsets.Table do
        table.insert(self.Offsets.Menu, i)
    end
end

function CROSSHAIR:DrawCrosshair()

    local Ratio = GetAspectRatio()

    local Red = self.ColorR.Index
    local Green = self.ColorG.Index
    local Blue = self.ColorB.Index
    local Alpha = self.ColorA.Index
    local Width = self.Widths.Table[self.Widths.Index]
    local Offset = self.Offsets.Table[self.Offsets.Index]
    local Thickness = self.Thicknesses.Table[self.Thicknesses.Index]

    if self.Left then
        DrawRect(0.5 + Offset + Width / 2, 0.5, Width, Thickness, Red, Green, Blue, Alpha)
    end

    if self.Right then
        DrawRect(0.5 - Offset - Width / 2, 0.5, Width, Thickness, Red, Green, Blue, Alpha)
    end
    
    if self.Top then
        DrawRect(0.5, 0.5 - (Offset * Ratio) - (Width * Ratio) / 2, Thickness / Ratio, Width * Ratio, Red, Green, Blue, Alpha)
    end

    if self.Bottom then
        DrawRect(0.5, 0.5 + (Offset * Ratio) + (Width * Ratio) / 2, Thickness / Ratio, Width * Ratio, Red, Green, Blue, Alpha)
    end

    if self.Dot then
        DrawRect(0.5, 0.5, (Thickness / 2), (Thickness / 2) * Ratio, Red, Green, Blue, Alpha)
    end
end