package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

wxID_USER_Index = 1000

-------------------------------------------------------------------------------
-- Dialogs
-------------------------------------------------------------------------------

function Message(parent,caption,message)
    return wx.wxMessageBox( message, caption, wx.wxOK + wx.wxCENTRE, parent, -1, -1 )
end

function OpenFileDialog(parent,defaultDir,multiple,save)
    local style = 0
	if save == nil or save == False then
		style = wx.wxFD_OPEN + wx.wxFD_FILE_MUST_EXIST 
	else 
		style = wx.xFD_SAVE + wx.wxFD_OVERWRITE_PROMPT
	end
	if multiple ~= nil and multiple == true then
		style = style + wx.wxFD_MULTIPLE 
	end
    if defaultDir == nil then 
		defaultDir = "" 
	end
    local dlg = wx.wxFileDialog(parent,"Choose a file",defaultDir,"","*.*",style)
    local rv = dlg:ShowModal()
	print( rv, wx.wxID_OK )
    if rv == wx.wxID_OK then
		--[[
        if multiple == true then
            files = []
            for file in dlg.GetFilenames():
                files.append( os.path.join(dlg.GetDirectory(), file) )
            return files
        else:]]
        return dlg:GetDirectory() .. "\\" .. dlg:GetFilename()
	end
    return nil	
end

-------------------------------------------------------------------------------
-- Menu
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- StatusBar
-------------------------------------------------------------------------------

function StatusBar(parent,count)
    return parent:CreateStatusBar( count, 0, wxID_STATUS )
end

-------------------------------------------------------------------------------
-- Misc
-------------------------------------------------------------------------------

function SetToolTip(ctrl)
end

-------------------------------------------------------------------------------
-- Controls
-------------------------------------------------------------------------------

function InitCtrl(ctrl,handler)
	if ctrl.proportion == nil then ctrl.proportion = 0 end
	if ctrl.expand == nil then ctrl.expand = true end
	if ctrl.border == nil then ctrl.border = 1 end
	ctrl.SetLayoutParam = function( proportion, expand, border )
		ctrl.proportion = proportion
		ctrl.expand = expand
		ctrl.border = border
	end	
end

function StaticText(parent,ctrl)
	local label = {}
	label.ctrl = wx.wxStaticText( parent, wx.wxID_ANY, ctrl.data,
					wx.wxDefaultPosition, wx.wxDefaultSize) --wx.wxSize(-1,50)
	ctrl.proportion = 0
	ctrl.expand = false
	ctrl.border = 1
	return label
end

function Button(parent,ctrl)
	local button = {}
	button.ctrl = wx.wxButton( parent, wxID_USER_Index, ctrl.data,
					wx.wxDefaultPosition, wx.wxDefaultSize)
	button.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(button)    
	if ctrl.handler ~= nil then
		parent:Connect(button.id, wx.wxEVT_COMMAND_BUTTON_CLICKED, ctrl.handler )
	end						
	return button
end

function BitmapButton(parent,ctrl)
	local button = {}
	button.ctrl = wx.wxBitmapButton( parent, wxID_USER_Index, ctrl.data,
					wx.wxDefaultPosition, wx.wxDefaultSize)
	wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(button) 
	return button	
end

function TextCtrl(parent,ctrl)
	local text = {}
    text.ctrl = wx.wxTextCtrl(parent, wxID_USER_Index, ctrl.data,
				wx.wxDefaultPosition, wx.wxDefaultSize,
				wx.wxTE_PROCESS_ENTER ) 
    text.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1
	InitCtrl(text)	
	text.Clear = function() 
		text.ctrl:Clear()
	end
	text.AppendText = function(data)
		text.ctrl:AppendText(data)
	end
	return text	
end

function MLTextCtrl(parent,ctrl)
	local text = {}
    text.ctrl = wx.wxTextCtrl(splitter, wxID_USER_Index, ctrl.data,
				wx.wxDefaultPosition, wx.wxDefaultSize,
				wx.wxTE_MULTILINE+wx.wxTE_DONTWRAP)	
    text.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1
	InitCtrl(text)		
    return text
end

function ListCtrl(parent)
    local list = { }
    list.ctrl = wx.wxListCtrl(parent, wxID_USER_Index,
                  wx.wxDefaultPosition, wx.wxDefaultSize,
                  wx.wxLC_REPORT +wx.wxBORDER_SUNKEN)
    list.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(list)
	
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
    
    --if cols ~= nil then list.AddColumns( cols, colwidths ) end
 return list
end

-------------------------------------------------------------------------------
-- Sizer
-------------------------------------------------------------------------------

function BoxSizer(orient)
    local sizer = { }
    if orient == nil then orient = wx.wxVERTICAL end
    sizer.ctrl = wx.wxBoxSizer( orient )
    sizer.Add = function(child) 
        local proportion = 0
        local border = 0
        local align = wx.wxALIGN_CENTER
        local flags = align + wx.wxALL
        if child.expand ~= nil and child.expand == true then flags = flags + wx.wxEXPAND end
        if child.border ~= nil then border = child.border end 
        if child.proportion ~= nil then proportion = child.proportion end
        sizer.ctrl:Add( child.ctrl, proportion, flags, border )
    end
    sizer.AddSpacer = function(size) 
        if size == nil then size = 0 end
        sizer.ctrl:Add( 0, 0, 1, wx.wxEXPAND, 5 )
        --sizer.ctrl:AddSpacer(size)
    end
    return sizer
end

function VBox()
    return BoxSizer(wx.wxVERTICAL)
end
      
function HBox()
    return BoxSizer(wx.wxHORIZONTAL)
end

function HStaticBox(parent,name) 
    local hsbox = { }
    local box = wx.wxStaticBox( parent, wx.wxID_ANY, name)
    hsbox.ctrl = wx.wxStaticBoxSizer( box, wx.wxHORIZONTAL )
    hsbox.Add = function(child) 
        hsbox.ctrl:Add( child.ctrl, 1, wx.wxEXPAND + wx.wxALL + wx.wxGROW, 1 )
    end    
    return hsbox
end

-------------------------------------------------------------------------------
-- Layout
-------------------------------------------------------------------------------

function Layout(parent,content) 
    local vbox = VBox()
    for i, v in ipairs(content) do
        local hbox = HBox()
        if type(v) == "table" then
            for j, h in ipairs(v) do
                if type(v) == "table" then
                    local ctrl;
                    if h.name == "StaticText" then
                        ctrl = StaticText(parent,h)
                    elseif h.name == "Button" then
                        ctrl = Button(parent,h)
                    elseif h.name == "TextCtrl" then
                        ctrl = TextCtrl(parent,h)
                    elseif h.name == "ListCtrl" then
                        ctrl = ListCtrl(parent)
                    elseif h.name == "Spacer" then
                        hbox.AddSpacer(0)
                    elseif h.name == nil then
                        for k1,v1 in pairs(h) do hbox[k1] = v1 end
                    end
                    if ctrl ~= nil then
                        for k1,v1 in pairs(h) do ctrl[k1] = v1 end                
                        if ctrl.key ~= nil then _ctrl_table[ctrl.key] = ctrl end
                        hbox.Add(ctrl)
                    end
                else
                    --TODO: Error Meeesage
                end
            end
        else
            --TODO: Error Meeesage
        end  
        vbox.Add(hbox)
    end  
    --[[
	local box = VBox()
	local panel = {}
	panel.ctrl = wx.wxPanel(parent, wx.wxID_ANY)
	panel.ctrl:SetSizer(vbox.ctrl)
	panel.proportion = 1
	panel.expand = true
	panel.border = 1
	box.Add(panel)
    return box]]
    return vbox
end

-------------------------------------------------------------------------------
-- Window
-------------------------------------------------------------------------------

function Window(title, width, height) 
    
    window = {} 
    _ctrl_table = {}
	window.ctrl = _ctrl_table
    window.frame = wx.wxFrame (wx.NULL, wx.wxID_ANY, title, wx.wxDefaultPosition, wx.wxSize( width, height ), wx.wxDEFAULT_FRAME_STYLE+wx.wxTAB_TRAVERSAL )
    
    window.frame:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
    window.Show = function() window.frame:Show() end
    
    window.SetMenuBar = function(menu) 
        window.frame:SetMenuBar( MenuBar( window.frame, menu) ) 
    end
    
    window.SetStatusBar = function(count) 
        window.StatusBar = window.frame:CreateStatusBar( count, 0, wxID_USER_Index )
        wxID_USER_Index = wxID_USER_Index + 1
    end
    window.SetStatusText = function(text,index) window.StatusBar:SetStatusText(text,index) end

    window.SetContent = function(content) 
        window.frame:SetSizer( Layout( window.frame, content ).ctrl )
        window.frame:Layout() --TODO: not necessary
        window.frame:Centre( wx.wxBOTH ) --TODO: not necessary
    end
    
    window.SetTimer = function(handler) 
        window.frame:Connect( wx.wxEVT_TIMER, handler )
        window.Timer = wx.wxTimer(window.frame, wxID_USER_Index) 
        wxID_USER_Index = wxID_USER_Index + 1
    end
    window.StartTimer = function(msec) window.Timer:Start(msec) end
    window.StopTimer = function() window.Timer:Stop() end  
    
	window.GetCtrl = function(name) 
		return _ctrl_table[name];
	end
	
    return window
end

-------------------------------------------------------------------------------
-- Application Example
-------------------------------------------------------------------------------

function fnExit()
    --appWin.frame.Close()
    os.exit(0)
end

function fnAbout()
    Message( appWin.frame, "About ezWxLua", "ezWxLua V0.0.1" )
end

function fnOpen()	
	local path = OpenFileDialog( appWin.frame )
	print(path)
	if path ~= nil then
		appWin.ctrl.text.Clear()
		appWin.ctrl.text.AppendText(path)
	end
end

function fnStart()	
    appWin.StartTimer(0)
end

fnTimer_index = 0
function fnTimer()
    appWin.ctrl.list.AddRow( {
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
    local menu = { 
        { Name = "File", Value = {
                { Name = "Exit" , Value = fnExit } 
            }
        },
        { Name = "도움말", Value = {
                { Name = "About", Value = fnAbout }
            }
        } 
    }    
    local content = { -- vbox
        { -- hbox
            { name="StaticText", data="  File  ", expand=true },
            { name="TextCtrl", key="text", data="Text", proportion=1, expand=true, border=1 },
            { name="Button", data="Open", handler=fnOpen, expand=true  },
			{ proportion=0, expand=true }
        },
        { -- hbox
            { name="ListCtrl", key="list", proportion=1, expand=true, border=1 },
			{ proportion=1, expand=true }
        }        ,
        { -- hbox
            { name="Spacer", expand=true },
            { name="Button", data="Start", handler=fnStart, expand=true  },
			{ proportion=0, expand=true }
        },
    }
 
    appWin = Window("ezWxLua", 600,400)
    appWin.SetMenuBar(menu)
    appWin.SetStatusBar(2)
    appWin.SetStatusText("Ready",0)
    appWin.SetTimer(fnTimer)
    appWin.SetContent(content)
    
    appWin.ctrl.list.AddColumns( { "Time", "Diff" }, { 300, 300 } )

    appWin.Show()

    wx.wxGetApp():MainLoop()
end

main()  
