surface.CreateFont("DefaultContext", {
    font = "Arial",
    size = ScrH() * 0.032,
    weight = 500,
    antialiasing = true
})

surface.CreateFont("TitleContext", {
    font = "Arial",
    size = ScrH() * 0.05,
    weight = 500,
    antialiasing = true
})

local frame
local playermodel

local function openMenu()
    frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() * 0.25, ScrH() * 1)
    frame:SetPos(ScrW() * 0.75, ScrH() * 0)
    frame:SetTitle("")
    frame:MakePopup()
    frame:ShowCloseButton(false)
    frame:SetDraggable(false)

    function frame:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 230))
        draw.SimpleText(LocalPlayer():getDarkRPVar("rpname"), "TitleContext", ScrW() * 0.13, ScrH() * 0.01, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER)
        draw.RoundedBox(0, ScrW() * 0.03, ScrH() * 0.38, ScrW() * 0.2, ScrH() * 0.003, Color(255, 255, 255, 255))
        surface.SetMaterial(Material("materials/kontext_menu/briefcase.png"))
        surface.DrawTexturedRect(ScrW() * 0.035, ScrH() * 0.39, ScrW() * 0.03, ScrH() * 0.05)
        draw.SimpleText(LocalPlayer():getDarkRPVar("job"), "DefaultContext", ScrW() * 0.07, ScrH() * 0.402, Color(255, 255, 255, 255))
        surface.SetMaterial(Material("materials/kontext_menu/money.png"))
        surface.DrawTexturedRect(ScrW() * 0.037, ScrH() * 0.45, ScrW() * 0.025, ScrH() * 0.04)
        draw.SimpleText(DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money")), "DefaultContext", ScrW() * 0.07, ScrH() * 0.457, Color(255, 255, 255, 255))
        draw.RoundedBox(0, ScrW() * 0.03, ScrH() * 0.72, ScrW() * 0.2, ScrH() * 0.003, Color(255, 255, 255, 255))
    end

    playermodel = vgui.Create("DModelPanel", frame)
    playermodel:SetSize(ScrW() * 0.2, ScrH() * 0.4)
    playermodel:SetPos(ScrW() * 0.03, ScrH() * 0)
    playermodel:SetModel(LocalPlayer():GetModel())

    local button1 = vgui.Create("DButton", frame)
    button1:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button1:SetPos(ScrW() * 0.035, ScrH() * 0.51)
    button1:SetText(KontextMenu.Button1Text)
    button1:SetFont("DefaultContext")
    button1:SetTextColor(Color(255, 255, 255, 255))

    function button1:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button1.DoClick = function()
        RunConsoleCommand("say", "/drop")
    end

    local button2 = vgui.Create("DButton", frame)
    button2:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button2:SetPos(ScrW() * 0.035, ScrH() * 0.56)
    button2:SetText(KontextMenu.Button2Text)
    button2:SetFont("DefaultContext")
    button2:SetTextColor(Color(255, 255, 255, 255))

    function button2:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button2.DoClick = function()
        local button2Panel = vgui.Create("DFrame")
        button2Panel:SetSize(ScrW() * 0.15, ScrH() * 0.2)
        button2Panel:SetPos(ScrW() * 0.425, ScrH() * 0.425)
        button2Panel:MoveTo(ScrW() * 0.425, ScrH() * 0.35, 1, 0, 0.2)
        button2Panel:SetTitle("")
        button2Panel:MakePopup()
        button2Panel:ShowCloseButton(false)
        button2Panel:SetDraggable(false)

        local money = LocalPlayer():getDarkRPVar("money")

        if (money >= 9999999999) then
            money = "Too much $"
        end

        function button2Panel:Paint(w, h)
            draw.RoundedBox(5, 0, 0, w, h, Color(27, 27, 29, 250))
            draw.RoundedBox(0, ScrW() * 0, ScrH() * 0, ScrW() * 0, ScrH() * 0, Color(255, 255, 255, 255))
            surface.SetMaterial(Material("materials/kontext_menu/money.png"))
            surface.DrawTexturedRect(ScrW() * 0.02, ScrH() * 0.04, ScrW() * 0.025, ScrH() * 0.04)
            draw.SimpleText(money, "DefaultContext", ScrW() * 0.05, ScrH() * 0.045, Color(255, 255, 255, 255))
        end

        local button2Close = vgui.Create("DButton", button2Panel)
        button2Close:SetSize(ScrW() * 0.025, ScrH() * 0.03)
        button2Close:SetPos(ScrW() * 0.13, ScrH() * 0)
        button2Close:SetText("X")
        button2Close:SetFont("DefaultContext")
        button2Close:SetTextColor(Color(255, 255, 255, 255))

        function button2Close:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 0))
        end

        button2Close.DoClick = function()
            button2Panel:Remove()
        end

        local button2Amount = vgui.Create("DTextEntry", button2Panel)
        button2Amount:SetSize(ScrW() * 0.1, ScrH() * 0.03)
        button2Amount:SetPos(ScrW() * 0.025, ScrH() * 0.1)
        button2Amount:SetNumeric(true)
        button2Amount.OnGetFocus = function(self) if self:GetText() == "Enter amount" then self:SetText("") end end
        button2Amount.OnLoseFocus = function(self) if self:GetText() == "" then self:SetText("Enter amount") end end

        local button2Drop = vgui.Create("DButton", button2Panel)
        button2Drop:SetSize(ScrW() * 0.1, ScrH() * 0.04)
        button2Drop:SetPos(ScrW() * 0.025, ScrH() * 0.15)
        button2Drop:SetText(KontextMenu.Button2Text)
        button2Drop:SetFont("DefaultContext")
        button2Drop:SetTextColor(Color(255, 255, 255, 255))

        function button2Drop:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
            surface.SetDrawColor(Color(255, 255, 255, 255))
            surface.DrawOutlinedRect(0, 0, w, h)
        end

        button2Drop.DoClick = function()
            if button2Amount:GetValue() == "" || button2Amount:GetValue() == "Enter Amount" then return end
            RunConsoleCommand("say", "/dropmoney " ..button2Amount:GetValue())
            button2Panel:Remove()
        end
    end

    local button3 = vgui.Create("DButton", frame)
    button3:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button3:SetPos(ScrW() * 0.035, ScrH() * 0.61)
    button3:SetText(KontextMenu.Button3Text)
    button3:SetFont("DefaultContext")
    button3:SetTextColor(Color(255, 255, 255, 255))

    function button3:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button3.DoClick = function()
        RunConsoleCommand("simple_thirdperson_enable_toggle")
    end

    local button4 = vgui.Create("DButton", frame)
    button4:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button4:SetPos(ScrW() * 0.035, ScrH() * 0.66)
    button4:SetText(KontextMenu.Button4Text)
    button4:SetFont("DefaultContext")
    button4:SetTextColor(Color(255, 255, 255, 255))

    function button4:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button4.DoClick = function()
        RunConsoleCommand("stopsound")
    end

    local button5 = vgui.Create("DButton", frame)
    button5:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button5:SetPos(ScrW() * 0.035, ScrH() * 0.74)
    button5:SetText(KontextMenu.Button5Text)
    button5:SetFont("DefaultContext")
    button5:SetTextColor(Color(255, 255, 255, 255))

    function button5:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button5.DoClick = function()
        gui.OpenURL(KontextMenu.Button5Link)
    end

    local button6 = vgui.Create("DButton", frame)
    button6:SetSize(ScrW() * 0.19, ScrH() * 0.04)
    button6:SetPos(ScrW() * 0.035, ScrH() * 0.79)
    button6:SetText(KontextMenu.Button6Text)
    button6:SetFont("DefaultContext")
    button6:SetTextColor(Color(255, 255, 255, 255))

    function button6:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    button6.DoClick = function()
        gui.OpenURL(KontextMenu.Button6Link)
    end

    if KontextMenu.Button7Enable then
        local button7 = vgui.Create("DButton", frame)
        button7:SetSize(ScrW() * 0.19, ScrH() * 0.04)
        button7:SetPos(ScrW() * 0.035, ScrH() * 0.84)
        button7:SetText(KontextMenu.Button7Text)
        button7:SetFont("DefaultContext")
        button7:SetTextColor(Color(255, 255, 255, 255))

        function button7:Paint(w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(27, 27, 29, 200))
        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.DrawOutlinedRect(0, 0, w, h)
        end

        button7.DoClick = function()
            RunConsoleCommand("say", KontextMenu.Button7Command)
            frame:Remove()
        end
    end
end

hook.Add("OnContextMenuOpen", "KontextOpen", function()
    openMenu()
    return false
end)

hook.Add("OnContextMenuClose", "KontextClose", function()
    if IsValid(frame) then frame:Remove() end
    return false
end)