package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

wxID_USER_Index = 1000

-------------------------------------------------------------------------------
-- Resource
-------------------------------------------------------------------------------

function os.isfile(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function dump_table(data)
	for k,v in pairs(data) do
		print( k, v )
	end
end

function GetMenuBitmap(name,size)
 if name == "exit" then
  return wx.wxArtProvider.GetBitmap(wx.wxART_QUIT, wx.wxART_MENU, wx.wxSize(size, size))
 end
 if name == "help" then
  return wx.wxArtProvider.GetBitmap(wx.wxART_HELP, wx.wxART_MENU, wx.wxSize(size, size))
 end
end

function GetToolBitmap(name,size)
 if name == "exit" then
  return wx.wxArtProvider.GetBitmap(wx.wxART_QUIT, wx.wxART_TOOLBAR, wx.wxSize(size, size))
 end
 if name == "help" then
  return wx.wxArtProvider.GetBitmap(wx.wxART_HELP, wx.wxART_TOOLBAR, wx.wxSize(size, size))
 end
end

function GetBitmap(xpm_table)
     return wx.wxBitmap(xpm_table)
end
	
function GetBitmapFile( filename )
	if os.isfile( filename ) then
		return wx.wxBitmap( filename, wx.wxBITMAP_TYPE_ANY )
	else
		return nil
	end
end

function GetIcon(name)
     local icon = wx.wxIcon()
	 if type(name) == "string" then
		icon:CopyFromBitmap(wx.wxBitmap(name))
	 end
     return icon
end

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
            if type(m.Value) == "table" then
                submenu = Menu( parent, m.Value )
                menu:Append( submenu, m.Name ) 
            end  
            if type(m.Value) == "function" then
                item = wx.wxMenuItem( menu, wxID_USER_Index, m.Name, "", wx.wxITEM_NORMAL )
    if m.Icon ~= nil then
     item:SetBitmap(GetMenuBitmap(m.Icon,16))
    end
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
-- ToolBar
-------------------------------------------------------------------------------
--[[
    control:AddTool(wx.wxID_ANY, "A tool 1", bmp, "Help for a tool 1", wx.wxITEM_NORMAL)
    control:AddTool(wx.wxID_ANY, "A tool 2", bmp, "Help for a tool 2", wx.wxITEM_NORMAL)
    control:AddSeparator()
    control:AddCheckTool(wx.wxID_ANY, "A check tool 1", bmp, wx.wxNullBitmap, "Short help for checktool 1", "Long help for checktool ")
    control:AddCheckTool(wx.wxID_ANY, "A check tool 2", bmp, wx.wxNullBitmap, "Short help for checktool 2", "Long help for checktool 2")
    AddControl("wxToolBar", control)
]]
function CreateToolBar(parent,toolbar_table)
 local flags = wx.wxTB_FLAT + wx.wxTB_HORIZONTAL + wx.wxTB_TEXT
 local toolbar = parent:CreateToolBar( flags, wx.wxID_ANY )
    for i, m in ipairs(toolbar_table) do
  local tool
  local icon
  local tooltip
  local name = m.Name
  if m.Name ~= nil and m.Name == '-' then
   toolbar:AddSeparator()
  else
   if m.Icon == nil then icon = wx.NullBitmap else icon = GetToolBitmap(m.Icon,32) end
   if m_ToolTip == nil then tooltip = "" else tooltip = m.ToolTip end
   if m.Name == nil then
    flags = flags + wx.wxTB_TEXT
    name = ""
   end
   tool = toolbar:AddTool(wxID_USER_Index, name, icon, tooltip, wx.wxITEM_NORMAL)
  
   if m.ToolTip ~= nil then toolbar:SetToolShortHelp( wxID_USER_Index, m.ToolTip) end
   if m.Value == nil then tool:Enable( false ) else 
    toolbar:Connect( wxID_USER_Index, wx.wxEVT_COMMAND_TOOL_CLICKED, m.Value )
   end
   wxID_USER_Index = wxID_USER_Index + 1
  end
    end
    toolbar:Realize()
 
--[[
    local toolbar = wx.wxToolBar(parent, ID_TOOLBAR, wx.wxDefaultPosition, wx.wxDefaultSize)
    for i, m in ipairs(toolbar_table) do
  local tool = toolbar:AddTool(wx.wxID_ANY, m.Name, m.Icon, m.ToolTip, wx.wxITEM_NORMAL)
    end
    return toolbar
 ]]
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

function InitItemContainer(newCtrl)
	newCtrl.Clear  = function() return newCtrl.ctrl:Clear() end
	newCtrl.Append = function(value) return newCtrl.ctrl:Append(value) end
	newCtrl.Insert = function(value,index) return newCtrl.ctrl:Insert(value,index) end
	newCtrl.Delete = function(index) return newCtrl.ctrl:Delete(index) end
	newCtrl.Select = function(index) return newCtrl.ctrl:Select(index) end
	newCtrl.GetCount  = function() return newCtrl.ctrl:GetCount() end
	newCtrl.GetSelection  = function() return newCtrl.ctrl:GetSelection() end
	newCtrl.GetString = function(index) return newCtrl.ctrl:GetString(index) end
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

function StaticBitmap(parent,ctrl) --TODO: Te be tested
	local label = {}
	local flag = wx.wxALIGN_CENTER
	local bitmap = wx.Bitmap( ctrl.data, wx.BITMAP_TYPE_ANY )
	label.ctrl = wx.wxStaticText( parent, wx.wxID_ANY, bitmap,
					wx.wxDefaultPosition, wx.wxDefaultSize, flag) --wx.wxSize(-1,50)
	label.ctrl.Bind( wx.EVT_SIZE, function(ctrl,event) 
			event:Skip()
		end )
	label.proportion = 0
	label.expand = false
	label.border = 1
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

function BitmapButton(parent,ctrl) --TODO: To be tested
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
 
	local dropTarget = wx.wxLuaFileDropTarget();
	dropTarget.OnDropFiles = function(self, x, y, filenames)
		text.ctrl:Clear()
		for i = 1, #filenames do
			if i >= 2 then text.ctrl:AppendText(';') end
			text.ctrl:AppendText(filenames[i])    
		end
		return true
	end
	text.ctrl:SetDropTarget(dropTarget)
	text.Clear = function() text.ctrl:Clear() end
	text.AppendText = function(data) text.ctrl:AppendText(data) end 
	return text 
end

function MLTextCtrl(parent,ctrl)
	local text = {}
    text.ctrl = wx.wxTextCtrl(parent, wxID_USER_Index, ctrl.data,
				wx.wxDefaultPosition, wx.wxDefaultSize,
				wx.wxTE_MULTILINE+wx.wxTE_DONTWRAP) 
    text.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1
	InitCtrl(text)  
    return text
end

function StyledText(parent,ctrl)
	local stc = {}
	local style = 0
	local name = "wxStyledTextCtrl"
    stc.ctrl = wxstc.wxStyledTextCtrl(parent, wxID_USER_Index, 
				wx.wxDefaultPosition, wx.wxDefaultSize, style, name ) 
    stc.id = wxID_USER_Index
	wxID_USER_Index = wxID_USER_Index + 1 
	
	stc.enableLineNumber = function()
        stc.ctrl:SetMargins(0, 0)
        stc.ctrl:SetMarginType(1, wxstc.wxSTC_MARGIN_NUMBER)
        stc.ctrl:SetMarginMask(2, wxstc.wxSTC_MASK_FOLDERS)
        stc.ctrl:SetMarginSensitive(2, True)
        stc.ctrl:SetMarginWidth(1, 32) -- 2,25
        stc.ctrl:SetMarginWidth(2, 16) -- 2,25	
	end
	
	stc.enableLineNumber();
	
	return stc
end

function Choice(parent,ctrl)
	local newCtrl = { }
	local items = { }
	local value = nil
	if ctrl.items ~= nil then items = ctrl.items end
	if ctrl.value ~= nil then value = ctrl.value end
	newCtrl.ctrl = wx.wxChoice( parent, wxID_USER_Index, 
					wx.wxDefaultPosition, wx.wxDefaultSize, 
					items, 0, wx.wxDefaultValidator)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    if value ~= nil then newCtrl.ctrl:SetSelection(value) end
	if ctrl.handler ~= nil then
		parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_CHOICE_SELECTED, ctrl.handler )
	end      
    InitCtrl(newCtrl) 	
	InitItemContainer(newCtrl)
	newCtrl.GetValue = function() return newCtrl.ctrl:GetCurrentSelection() end
	newCtrl.GetText  = function() return newCtrl.ctrl:GetString(newCtrl.ctrl:GetCurrentSelection()) end
	return newCtrl
end

function ComboBox(parent,ctrl)
	local newCtrl = { }
	local items = { }
	local value = ""
	if ctrl.items ~= nil then items = ctrl.items end
	if ctrl.value ~= nil then value = ctrl.value end
	newCtrl.ctrl = wx.wxComboBox( parent, wxID_USER_Index, value,
					wx.wxDefaultPosition, wx.wxDefaultSize, 
					items, 0, wx.wxDefaultValidator)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
	if ctrl.handler ~= nil then
		parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_COMBOBOX_SELECTED, ctrl.handler )
	end      
    InitCtrl(newCtrl) 	
	InitItemContainer(newCtrl)
	newCtrl.GetValue = function() return newCtrl.ctrl:GetValue() end
	newCtrl.GetText  = function() return newCtrl.ctrl:GetValue() end
	return newCtrl
end


function ListBox(parent,ctrl)
	local newCtrl = { }
	local items = { }
	local value = ""
	if ctrl.items ~= nil then items = ctrl.items end
	if ctrl.value ~= nil then value = ctrl.value end
	newCtrl.ctrl = wx.wxListBox( parent, wxID_USER_Index, 
					wx.wxDefaultPosition, wx.wxDefaultSize, 
					items, 0, wx.wxDefaultValidator)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
	if ctrl.handler ~= nil then
		parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_LISTBOX_SELECTED, ctrl.handler )
	end      
    InitCtrl(newCtrl) 	
	InitItemContainer(newCtrl)
	newCtrl.GetValue = function() return newCtrl.ctrl:GetValue() end
	newCtrl.IsSelected = function(index) return newCtrl.ctrl:IsSelected(index) end
	return newCtrl
end

function ListCtrl(parent)
    local list = { }
    list.ctrl = wx.wxListCtrl(parent, wxID_USER_Index,
                  wx.wxDefaultPosition, wx.wxDefaultSize,
                  wx.wxLC_REPORT +wx.wxBORDER_SUNKEN)
    list.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(list)
  
 local dropTarget = wx.wxLuaFileDropTarget();
 dropTarget.OnDropFiles = function(self, x, y, filenames)
   for i = 1, #filenames do
    list.ctrl:InsertItem(list.ctrl:GetItemCount()+1, filenames[i])    
   end
   return true
  end
 list.ctrl:SetDropTarget(dropTarget)
 
    --list:SetImageList(listImageList, wx.wxIMAGE_LIST_SMALL)
    list.col = 0
    list.row = 0
    
 list.Clear = function() list.ctrl:ClearAll() end
 list.Set = function( row, col, label )
  list.ctrl:SetItem( row, col, label)
 end
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
-- Container
-------------------------------------------------------------------------------

function Panel(parent,content)
    local panel = { }
    panel.ctrl = wx.wxPanel( parent, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, wx.wxTAB_TRAVERSAL )
    panel.ctrl:SetSizer( Layout( panel.ctrl,content).ctrl )
    panel.ctrl:Layout()
    return panel
end

function BoxPanel(parent,content)
    local vbox = VBox()
    local panel = Panel(parent,content)
    panel.expand = true
    panel.proportion = 1
    vbox.Add(panel)
    vbox.expand = true
    vbox.proportion = 1
    return vbox
end

function SplitterWindow(parent,content,direction)
	local swin = { }
    swin.ctrl = wx.wxSplitterWindow( parent, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, 0 --[[wx.wxSP_3D]] )
    local left_panel = Panel( swin.ctrl, content.children[1] )
    local right_panel = Panel( swin.ctrl, content.children[2] )
    if direction == 'horizontal' then
		swin.ctrl:SplitHorizontally( left_panel.ctrl, right_panel.ctrl, 0 )
	else
		swin.ctrl:SplitVertically( left_panel.ctrl, right_panel.ctrl, 0 )
	end
    return swin
end

function VerticalWindow(parent,content)
	return SplitterWindow(parent,content,'vertical')
end

function HorizontalWindow(parent,content)
	return SplitterWindow(parent,content,'horizontal')
end

function Notebook(parent,content)
	local note = { }
    note.ctrl = wx.wxNotebook( parent, wx.wxID_ANY, wx.wxDefaultPosition, wx.wxDefaultSize, 0 )
    if content ~= nil and content.children ~= nil then
		for i = 1, #content.children do
			local panel = Panel( note.ctrl, content.children[i] )
			local title = tostring(i)
			if content.title ~= nil and content.title[i] ~= nil then
				title = content.title[i]
			end
			note.ctrl:AddPage( panel.ctrl, title, False ) 
		end
    end
    return note
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
            for j, h in pairs(v) do
                if type(h) == "table" then
                    local ctrl;
                    if h.name == "StaticText" then
                        ctrl = StaticText(parent,h)
                    elseif h.name == "Button" then
                        ctrl = Button(parent,h)
                    elseif h.name == "TextCtrl" then
                        ctrl = TextCtrl(parent,h)
                    elseif h.name == "StyledText" then
                        ctrl = StyledText(parent,h)
                    elseif h.name == "Choice" then
                        ctrl = Choice(parent,h)
                    elseif h.name == "ComboBox" then
                        ctrl = ComboBox(parent,h)
                    elseif h.name == "ListBox" then
                        ctrl = ListBox(parent,h)
                    elseif h.name == "ListCtrl" then
                        ctrl = ListCtrl(parent)
                    elseif h.name == "Panel" then
                        ctrl = Panel(parent,h)
                    elseif h.name == "SplitterWindow" then
                        ctrl = SplitterWindow(parent,h)
                    elseif h.name == "Notebook" then
                        ctrl = Notebook(parent,h)
                    elseif h.name == "Spacer" then
                        hbox.AddSpacer(0)
                    elseif h.name == nil then
                        for k1,v1 in pairs(h) do hbox[k1] = v1 end
                    end
                    if ctrl ~= nil then
                        if h.layout ~= nil then
                            for k1,v1 in pairs(h.layout) do ctrl[k1] = v1 end                
                        end
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
    return vbox
end

-------------------------------------------------------------------------------
-- Window
-------------------------------------------------------------------------------

function GetWxCtrl(key)
	if _ctrl_table[key] ~= nil then
		return _ctrl_table[key].ctrl
	else
		return nil
	end
end

function GetCtrl(key)
    return _ctrl_table[key]
end

function Window(title,icon,layout, width, height) 
    
    window = {} 
    _ctrl_table = {}
    window.ctrl = _ctrl_table
    window.frame = wx.wxFrame (wx.NULL, wx.wxID_ANY, title, wx.wxDefaultPosition, wx.wxSize( width, height ), wx.wxDEFAULT_FRAME_STYLE+wx.wxTAB_TRAVERSAL )
    
    window.frame:SetSizeHints( wx.wxDefaultSize, wx.wxDefaultSize )
    window.Show = function() window.frame:Show() end
    
    window.SetMenuBar = function(menu) window.frame:SetMenuBar( MenuBar( window.frame, menu) ) end
    window.SetToolBar = function(tool) CreateToolBar( window.frame, tool ) end    
    window.SetStatusBar = function(count) 
        window.StatusBar = window.frame:CreateStatusBar( count, 0, wx.wxID_ANY )
    end
    window.SetStatusText = function(text,index) window.StatusBar:SetStatusText(text,index) end

    window.SetContent = function(content) 
        --window.frame:SetSizer( Layout( window.frame, content ).ctrl )
        window.frame:SetSizer( BoxPanel( window.frame, content ).ctrl )
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

    window.SetIcon = function(name)
        window.frame:SetIcon(GetIcon(name))
    end

	window.Run = function() 
		wx.wxLocale(wx.wxLocale:GetSystemLanguage()) -- TODO
		wx.wxGetApp():MainLoop()
	end
	
    if icon ~= nil then window.SetIcon(icon) end
    
    if layout ~= nil then
        if layout.menubar   ~= nil then window.SetMenuBar(layout.menubar) end
        if layout.toolbar   ~= nil then window.SetToolBar(layout.toolbar) end
        if layout.statusbar ~= nil then window.SetStatusBar(layout.statusbar) end
        if layout.content   ~= nil then window.SetContent(layout.content) end
    end
    return window
end

