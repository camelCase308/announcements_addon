local function CreateFadingAnnouncement(message)
    local startTime = CurTime()
    local duration = 5 -- Duration in seconds
    local chatPanel = nil
    
    -- Find the chat panel
    timer.Simple(0.1, function()
        for _, v in pairs(vgui.GetWorldPanel():GetChildren()) do
            if v:GetClassName() == "RichText" then
                chatPanel = v
                break
            end
        end
        
        if IsValid(chatPanel) then
            local originalPaint = chatPanel.Paint
            local lastLine = chatPanel:GetNumLines() - 1
            
            chatPanel.Paint = function(self, w, h)
                originalPaint(self, w, h)
                
                local elapsed = CurTime() - startTime
                local progress = elapsed / duration
                local alpha = math.Clamp(1 - progress, 0, 1)
                
                -- Calculate color based on progress
                local r = Lerp(progress, 0, 0)   -- Black to Blue transition
                local g = Lerp(progress, 0, 0)
                local b = Lerp(progress, 0, 255)
                
                chatPanel:SetFontInternal("ChatFont")
                chatPanel:SetTextColor(Color(r, g, b, 255 * alpha))
                
                if elapsed >= duration then
                    chatPanel.Paint = originalPaint
                    chatPanel:RemoveLine(lastLine)
                end
            end
        end
    end)
end

net.Receive("SendAnnouncement", function()
    local message = net.ReadString()
    chat.AddText(ANNOUNCEMENT.Color, ANNOUNCEMENT.Prefix, Color(255, 255, 255), " " .. message)
    CreateFadingAnnouncement(message)
end)
