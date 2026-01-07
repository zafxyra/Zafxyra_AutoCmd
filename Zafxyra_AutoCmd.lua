script_name("Auto Chat")
script_author("ZafxyraStoreID")
script_version("AC-1.0")

require "lib.moonloader"
require "lib.sampfuncs"
local imgui = require "mimgui"
local encoding = require "encoding"
local ffi = require "ffi"

encoding.default = "CP1251"
local u8 = encoding.UTF8
local new = imgui.new

local windowState = new.bool(false)
local autoSend = new.bool(false)
local pesanInput = new.char[508]()
local sliderDelay = new.int(5)
local lastSend = os.clock()

sampRegisterChatCommand("ac", function()
    windowState[0] = not windowState[0]
end)

imgui.OnFrame(
    function() return windowState[0] end,
    function()
        imgui.Begin(u8"AUTO CHAT", windowState,
            imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoCollapse)

        imgui.Text("Auto kirim chat / command")
        imgui.Checkbox("Aktifkan Auto Chat", autoSend)
        imgui.InputText("Isi Pesan / CMD", pesanInput, 508)
        imgui.SliderInt("Delay (detik)", sliderDelay, 1, 120)

        imgui.End()
    end
)

function main()
    while not isSampAvailable() do wait(100) end
    sampAddChatMessage("[AUTO CHAT] Loaded | ketik /ac", 0xFF69B4)

    while true do
        wait(100)
        if autoSend[0] and os.clock() - lastSend >= sliderDelay[0] then
            local msg = ffi.string(pesanInput)
            if #msg > 0 then
                sampSendChat(msg)
                lastSend = os.clock()
            end
        end
    end
end
