-- Configuration
ANNOUNCEMENT = ANNOUNCEMENT or {}
ANNOUNCEMENT.Color = Color(0, 150, 255) -- Color for the prefix
ANNOUNCEMENT.Prefix = "[Announcement]"

local function CreateCenterAnnouncement(message)
    if IsValid(ANNOUNCEMENT.Panel) then
        ANNOUNCEMENT.Panel:Remove()
    end

    -- Play UI sound
    surface.PlaySound("garrysmod/ui_click.wav")

    surface.CreateFont("AnnouncementFont", {
        font = "Roboto Bold",
        size = 46,
        weight = 1000,
        antialias = true,
        blursize = 0,
        scanlines = 2,
        shadow = true,
    })

    local message = string.upper(message)
    surface.SetFont("AnnouncementFont")
    local textWidth, textHeight = surface.GetTextSize(message)
    
    local panel = vgui.Create("DPanel")
    ANNOUNCEMENT.Panel = panel
    
    local padding = 40
    local startTime = CurTime()
    local duration = 5
    local colorSpeed = 2
    
    panel:SetSize(textWidth + padding * 2, 80)
    panel:SetPos((ScrW() - (textWidth + padding * 2))/2, ScrH() * 0.3)
    panel:MakePopup()
    panel:SetKeyboardInputEnabled(false)
    panel:SetMouseInputEnabled(false)
    
    function panel:Paint(w, h)
        local elapsed = CurTime() - startTime
        local progress = elapsed / duration
        
        -- Fancy gradient background
        surface.SetDrawColor(40, 40, 40, 230)
        surface.DrawRect(0, 0, w, h)
        
        -- Top gradient
        local gradient = Material("vgui/gradient-d")
        surface.SetMaterial(gradient)
        surface.SetDrawColor(100, 100, 100, 100)
        surface.DrawTexturedRect(0, 0, w, h/2)
        
        -- Bottom gradient
        surface.SetDrawColor(20, 20, 20, 180)
        surface.DrawTexturedRect(0, h/2, w, h/2)
        
        -- Edge highlight
        surface.SetDrawColor(150, 150, 150, 50)
        surface.DrawOutlinedRect(0, 0, w, h, 1)
        surface.DrawOutlinedRect(1, 1, w-2, h-2, 1)
        
        -- Text effects
        local textX, textY = w/2, h/2
        local r = Lerp(progress, 0, 0)
        local g = Lerp(progress, 150, 0)
        local b = Lerp(progress, 255, 0)
        
        -- Glow effect
        local glowColor = Color(r, g, b, 40)
        for i = 1, 4 do
            draw.SimpleText(message, "AnnouncementFont", textX+i, textY+i, glowColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText(message, "AnnouncementFont", textX-i, textY-i, glowColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        
        -- Main text with enhanced outline
        draw.SimpleText(message, "AnnouncementFont", textX+2, textY+2, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(message, "AnnouncementFont", textX, textY, Color(r, g, b, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        if elapsed >= duration then
            self:Remove()
        end
    end
end

local function DisplayAnnouncement(message)
    chat.AddText(
        Color(255, 100, 100), "[Announcement] ",
        Color(255, 255, 255), message
    )
end

net.Receive("SendAnnouncement", function()
    local message = net.ReadString()
    if message then
        DisplayAnnouncement(message)
        surface.PlaySound("buttons/button15.wav")
    end
end)

net.Receive("SendAnnouncement", function()
    local message = net.ReadString()
    
    local announcement = vgui.Create("DNotify")
    announcement:SetPos(ScrW() * 0.3, 10)
    announcement:SetSize(ScrW() * 0.4, 50)
    
    local bg = announcement:Add("DPanel")
    bg:Dock(FILL)
    bg:SetBackgroundColor(Color(0, 0, 0, 0))
    
    local timeElapsed = 0
    local displayTime = 5
    
    bg.Paint = function(self, w, h)
        timeElapsed = timeElapsed + FrameTime()
        local progress = timeElapsed / displayTime
        
        draw.SimpleText(message, "DermaLarge", w/2, h/2, ANNOUNCEMENT.Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        if progress >= 1 then
            announcement:Remove()
        end
        
        return true
    end
    
    announcement:SetLife(displayTime)
end)
