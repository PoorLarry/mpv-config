local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function apply_proxy()
local path = mp.get_property("path")
if not path or not path:find("^%a+://") then return end

    -- Xác định đường dẫn file config
    local conf_path = mp.command_native({"expand-path", "~~/script-opts/proxy_domain.conf"})
    local f = io.open(conf_path, "r")
    if not f then return end

        for line in f:lines() do
            -- Bỏ qua dòng trống hoặc comment (bắt đầu bằng #)
            if line:match("^%s*[^#].+=.+$") then
                local domain, proxy_url = line:match("^%s*(.-)%s*=%s*(.-)%s*$")

                if domain and proxy_url and string.find(path, domain) then
                    -- Áp dụng proxy theo cách "local" bạn thích
                    mp.set_property("file-local-options/ytdl-raw-options", "proxy=" .. proxy_url)
                    mp.set_property("file-local-options/http-proxy", proxy_url)

                    msg.info("Kích hoạt Proxy cho " .. domain .. " -> " .. proxy_url)
                    mp.osd_message("Proxy: " .. proxy_url, 5)
                    f:close()
                    return
                    end
                    end
                    end
                    f:close()
                    end

                    mp.register_event("start-file", apply_proxy)
