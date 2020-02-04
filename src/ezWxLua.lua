package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

wxID_USER_Index = 1000

function Message(parent,caption,message)
    return wx.wxMessageBox( message, caption, wx.wxOK + wx.wxCENTRE, parent, -1, -1 )
end

function Menu(parent,menu_table)
    local menu = wx.wxMenu()
    for i, m in ipairs(menu_table) do
        local item
        if type(m.Name) == "string" then 
            if type(m.Value) == "function" then
                item = wx.wxMenuItem( menu, wxID_USER_Index, m.Name, "", wx.wxITEM_NORMAL )
                menu:Append( item )
                parent:Connect(wxID_USER_Index, wx.wxEVT_COMMAND_MENU_SELECTED, m.Value)
                wxID_USER_Index = wxID_USER_Index + 1
            end
        end  
    end    
    return menu
end

function MenuBar(parent,menubar_table)
    local menubar = wx.wxMenuBar( 0 )
    for i, m in ipairs(menubar_table) do
        local menu
        if type(m.Name) == "string" then 
            local item
            if type(m.Value) == "table" then
                menu = Menu( parent, m.Value )
                menubar:Append( menu, m.Name ) 
            end
            if type(m.Value) == "function" then
                item = wx.wxMenuItem( menubar, wxID_USER_Index, m.Name, "", wx.wxITEM_NORMAL )
                menubar:Append( item )
                parent:Connect(wxID_USER_Index, wx.wxEVT_COMMAND_MENU_SELECTED, m.Value)
                wxID_USER_Index = wxID_USER_Index + 1
            end
        end   
    end
    return menubar
end

function StatusBar(parent,count)
    return parent:CreateStatusBar( count, 0, wxID_STATUS )
end


function BoxSizer(orient)
    sizer = { }
    if orient == nil then orient = wx.VERTICAL end
    sizer.ctrl = wx.wxBoxSizer( orient )
    sizer.Add = function(child) 
        local proportion = 1
        local expand = true
        local border = 0
        local align = 0
        local flags = align
        if expand == true then flags = flags + wx.wxEXPAND end
        if border > 0 then flags = flags + wx.wxALL end
        sizer.ctrl:Add( child, proportion, flags, border )
    end
    sizer.AddSpacer = function(size) 
        local size = 0
        sizer.ctrl:AddSpacer(size)
    end
    return sizer
end

function VBox()
    return BoxSizer(wx.wxVERTICAL)
end
      
function HBox()
    return BoxSizer(wx.wxHORIZONTAL)
end
   
function ListCtrl(parent,cols,colwidths)
    local list = { }
    list.ctrl = wx.wxListCtrl(parent, wxID_USER_Index,
                  wx.wxDefaultPosition, wx.wxDefaultSize,
                  wx.wxLC_REPORT)
 wxID_USER_Index = wxID_USER_Index + 1
    
    --list:SetImageList(listImageList, wx.wxIMAGE_LIST_SMALL)
    list.col = 0
    list.row = 0
    
    list.AddColumn = function( label, size )
        list.ctrl:InsertColumn(list.col, label)
        list.ctrl:SetColumnWidth(list.col, size)
        list.col = list.col + 1
    end
    list.AddColumns = function( labels, widths )
        if labels == nil then return end
        for col = 1, #labels do
            list.ctrl:InsertColumn( col-1, labels[col])
            list.col = list.col + 1
        end
        if widths == nil then return end
        for col = 1, #widths do
            list.ctrl:SetColumnWidth(col-1, widths[col])
        end
    end    
    list.AddRow = function( row )
        list.ctrl:InsertItem( list.row, row[1] )
        for col = 2, #row do
            list.ctrl:SetItem( list.row, col-1, row[col])
        end
        list.row = list.row + 1
    end
    
    if cols ~= nil then list.AddColumns( cols, colwidths ) end
 return list
end

function Window(title, width, height) 
    
    local window = {} 
    
    window.frame = wx.wxFrame (wx.NULL, wx.wxID_ANY, title, wx.wxDefaultPosition, wx.wxSize( width, height ), wx.wxDEFAULT_FRAME_STYLE+wx.wxTAB_TRAVERSAL )
    
    window.body = VBox()
    window.frame:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
    window.frame:SetSizer(window.body.ctrl)
    window.Show = function() window.frame:Show() end
    
    window.SetMenuBar = function(menu) window.frame:SetMenuBar( MenuBar( window.frame, menu) ) end
    
    window.SetStatusBar = function(count) 
        window.StatusBar = window.frame:CreateStatusBar( count, 0, wxID_USER_Index )
        wxID_USER_Index = wxID_USER_Index + 1
    end
    window.SetStatusText = function(text,index) window.StatusBar:SetStatusText(text,index) end
    
    window.SetTimer = function(handler) 
        window.frame:Connect( wx.wxEVT_TIMER, handler )
        window.Timer = wx.wxTimer(window.frame, wxID_USER_Index) 
        wxID_USER_Index = wxID_USER_Index + 1
    end
    window.StartTimer = function(msec) window.Timer:Start(msec) end
    window.StopTimer = function() window.Timer:Stop() end
    
    window.Add = function(ctrl) 
        if type(ctrl) == "table" then
            window.body.Add(ctrl.ctrl)
        else
            window.body.Add(ctrl)
        end
    end
    
    window.ListCtrl = function(cols,colwidths) 
        return ListCtrl(window.frame,cols,colwidths) 
    end
    return window
end

--
--
--

function fnExit()
    --appWin.frame.Close()
    os.exit(0)
end

function fnAbout()
    Message( appWin.frame, "About ezWxLua", "ezWxLua V0.0.1" )
end

fnTimer_index = 0
function fnTimer()
    mainList.AddRow( {
        string.format("Time:%d", fnTimer_index),
        string.format("Diff:%d", fnTimer_index),
    } )
    appWin.SetStatusText( string.format("Timer: %d", fnTimer_index), 0 )
    fnTimer_index = fnTimer_index + 1
    if fnTimer_index > 300 then
        appWin.StopTimer()
    end
end

function main()
    local m = { 
        { Name = "File", Value = {
                { Name = "Exit" , Value = fnExit } 
            }
        },
        { Name = "도움말", Value = {
                { Name = "About", Value = fnAbout }
            }
        } 
    }    
 
    appWin = Window("ezWxLua", 600,400)
    appWin.SetMenuBar(m)
    appWin.SetStatusBar(2)
    appWin.SetStatusText("Ready",0)
    appWin.SetTimer(fnTimer)
    appWin.StartTimer(0)
    mainList = appWin.ListCtrl( { "Time", "Diff" }, { 300, 300 } )
    --mainList.AddColumns( { "Time", "Diff" }, { 300, 300 } )
    --mainList.AddColumn( "Timestamp", 200 )
    --mainList.AddColumn( "Diff Time", 200 )
    appWin.Add(mainList)
    appWin.Show()

    wx.wxGetApp():MainLoop()
end

main()  
