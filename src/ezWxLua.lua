package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

wxID_USER_Index = 1000

-------------------------------------------------------------------------------
-- Event Table
-------------------------------------------------------------------------------

__ctrl_table = {}
__ctrl_event = {

    StaticText = {
        ctor = function(parent,id,layoutCtrl)
                    return wx.wxStaticText( parent, id, layoutCtrl.label,
                            wx.wxDefaultPosition,wx.wxDefaultSize,0) end,
    },
    Button = {
        ctor = function(parent,id,layoutCtrl)
                    return wx.wxButton( parent, id, layoutCtrl.label,
                            wx.wxDefaultPosition,wx.wxDefaultSize,0) end,
        ev = wx.wxEVT_COMMAND_BUTTON_CLICKED
    },
    ToggleButton = {
        ctor = function(parent,id,layoutCtrl)
                    return wx.wxToggleButton( parent, id, layoutCtrl.label,
                            wx.wxDefaultPosition,wx.wxDefaultSize) end,
        ev = wx.wxEVT_COMMAND_TOGGLEBUTTON_CLICKED
    },
    CheckBox = {
        ctor = function(parent,id,layoutCtrl)
                    return wx.wxCheckBox( parent, id, layoutCtrl.label,
                            wx.wxDefaultPosition,wx.wxDefaultSize) end,
        ev = wx.wxEVT_COMMAND_CHECKBOX_CLICKED
    },
    Choice = {
        ctor = function(parent,id,layoutCtrl)
                if not layoutCtrl.items then layoutCtrl.items = {} end
                ctrl = wx.wxChoice( parent, id,
                        wx.wxDefaultPosition,wx.wxDefaultSize,
                        layoutCtrl.items, 0, wx.wxDefaultValidator)
                    if layoutCtrl.value then
                        ctrl:SetSelection(layoutCtrl.value)
                    end
                return ctrl end,
        ev = wx.wxEVT_COMMAND_CHOICE_SELECTED
    },
    ComboBox = {
        ctor = function(parent,id,layoutCtrl)
            if not layoutCtrl.items then layoutCtrl.items = {} end
            if not layoutCtrl.value then layoutCtrl.value = "" end
            ctrl = wx.wxComboBox( parent, id, layoutCtrl.value,
                    wx.wxDefaultPosition,wx.wxDefaultSize,
                    layoutCtrl.items, 0, wx.wxDefaultValidator)
                return ctrl end,
        ev = wx.wxEVT_COMMAND_COMBOBOX_SELECTED
    },
    ListBox = {
        ctor = function(parent,id,layoutCtrl)
            if not layoutCtrl.items then layoutCtrl.items = {} end
            ctrl = wx.wxListBox( parent, id, 
                    wx.wxDefaultPosition,wx.wxDefaultSize,
                    layoutCtrl.items, 0, wx.wxDefaultValidator)
                return ctrl end,
        ev = wx.wxEVT_COMMAND_LISTBOX_SELECTED
    },    
    CheckListBox = {
        ctor = function(parent,id,layoutCtrl)
            if not layoutCtrl.items then layoutCtrl.items = {} end
            ctrl = wx.wxCheckListBox( parent, id, 
                    wx.wxDefaultPosition,wx.wxDefaultSize,
                    layoutCtrl.items, 0, wx.wxDefaultValidator)
                return ctrl end,
        ev = wx.wxEVT_COMMAND_CHECKLISTBOX_TOGGLED
    },
    RadioBox = {
        ctor = function(parent,id,layoutCtrl)
                if not layoutCtrl.items then layoutCtrl.items = {} end
                ctrl = wx.wxRadioBox( parent, id, layoutCtrl.label, 
                        wx.wxDefaultPosition,wx.wxDefaultSize,
                        layoutCtrl.items, 0, wx.wxRA_SPECIFY_ROWS, wx.wxDefaultValidator)
                    if layoutCtrl.value then
                        ctrl:SetSelection(layoutCtrl.value)
                    end
                return ctrl end,
        ev = wx.wxEVT_COMMAND_RADIOBOX_SELECTED
    },       
--[[
    if layoutCtrl.check then
        newCtrl.ctrl = wx.wxCheckListBox( parent, wxID_USER_Index, 
                        wx.wxDefaultPosition, wx.wxDefaultSize, 
                        items, 0, wx.wxDefaultValidator)
        newCtrl.IsChecked = function(index) return newCtrl.ctrl:IsChecked(index) end
    else
        newCtrl.ctrl = wx.wxListBox( parent, wxID_USER_Index, 
                        wx.wxDefaultPosition, wx.wxDefaultSize, 
                        items, 0, wx.wxDefaultValidator)
    end
    ]]   
}

function dump_ctrl_event()
    for k,v in pairs(__ctrl_event) do
        for k1, v1 in pairs(v) do
            print( k, k1, v1 )
        end
    end
end

function CreateControl(parent,layoutCtrl)
    local newCtrl = {}
    
    if layoutCtrl and __ctrl_event[layoutCtrl.name] then

        newCtrl.id = wxID_USER_Index
        wxID_USER_Index = wxID_USER_Index + 1

        newCtrl.ctrl = __ctrl_event[layoutCtrl.name].ctor(parent, newCtrl.id, layoutCtrl)
 
        if layoutCtrl.handler and __ctrl_event[layoutCtrl.name].ev then
            parent:Connect(newCtrl.id, __ctrl_event[layoutCtrl.name].ev, layoutCtrl.handler )
        end

        if layoutCtrl.tooltip then
            newCtrl.ctrl:SetToolTip(wx.wxToolTip(layoutCtrl.tooltip))   
        end

        if layoutCtrl.menu then
            local menu = Menu(newCtrl.ctrl,layoutCtrl.menu)
            newCtrl.ctrl:Connect(wx.wxEVT_RIGHT_DOWN, function(event) 
                    newCtrl.ctrl:PopupMenu( menu, event:GetPosition() )
                end ) 
        end

        newCtrl.proportion = 0 
        newCtrl.expand = true 
        newCtrl.border = 1 
        if layoutCtrl.layout then
            if layoutCtrl.layout.proportion then newCtrl.proportion = layoutCtrl.layout.proportion end
            if layoutCtrl.layout.expand then newCtrl.expand = layoutCtrl.layout.expand end
            if layoutCtrl.layout.border then newCtrl.border = layoutCtrl.layout.border end
        end

        if layoutCtrl.name == "Choice" or layoutCtrl.name == "ComboBox" or
            layoutCtrl.name == "ListBox" or layoutCtrl.name == "CheckListBox" or
            layoutCtrl.name == "RadioBox" 
        then
            newCtrl.Clear  = function() return newCtrl.ctrl:Clear() end
            newCtrl.Append = function(value) return newCtrl.ctrl:Append(value) end
            newCtrl.Insert = function(value,index) return newCtrl.ctrl:Insert(value,index) end
            newCtrl.Delete = function(index) return newCtrl.ctrl:Delete(index) end
            newCtrl.Select = function(index) return newCtrl.ctrl:Select(index) end
            newCtrl.GetCount  = function() return newCtrl.ctrl:GetCount() end
            newCtrl.GetSelection  = function() return newCtrl.ctrl:GetSelection() end
            newCtrl.GetString = function(index) return newCtrl.ctrl:GetString(index) end
            if layoutCtrl.name == "Choice" or layoutCtrl.name == "RadioBox" then
                newCtrl.GetValue = function() return newCtrl.ctrl:GetSelection() end
                newCtrl.GetText  = function() return newCtrl.ctrl:GetString(newCtrl.ctrl:GetSelection()) end
            end
            if layoutCtrl.name == "ComboBox" then
                newCtrl.GetValue = function() return newCtrl.ctrl:GetValue() end
                newCtrl.GetText  = function() return newCtrl.ctrl:GetValue() end
            end
            if layoutCtrl.name == "ComboBox" then
                newCtrl.GetValue = function() return newCtrl.ctrl:GetValue() end
                newCtrl.GetText  = function() return newCtrl.ctrl:GetValue() end
            end
            if layoutCtrl.name == "ListBox" then
                newCtrl.IsSelected = function(i) return newCtrl.ctrl:IsSelected(i) end
            end
            if layoutCtrl.name == "CheckListBox" then
                newCtrl.IsSelected = function(i) return newCtrl.ctrl:IsSelected(i) end
                newCtrl.IsChecked = function(i) return newCtrl.ctrl:IsChecked(i) end
            end
        end
    end
    return newCtrl
end

--[[
%wxEventType wxEVT_COMMAND_SPINCTRL_UPDATED // EVT_SPINCTRL(id, fn );
%wxEventType wxEVT_COMMAND_SLIDER_UPDATED // EVT_SLIDER(winid, func );
%wxEventType wxEVT_COMMAND_RADIOBUTTON_SELECTED // EVT_RADIOBUTTON(winid, func );
%wxEventType wxEVT_COMMAND_RADIOBOX_SELECTED // EVT_RADIOBOX(winid, func );
%wxEventType wxEVT_COMMAND_CHECKLISTBOX_TOGGLED // EVT_CHECKLISTBOX(winid, func );
%wxEventType wxEVT_COMMAND_LISTBOX_DOUBLECLICKED // EVT_LISTBOX_DCLICK(winid, func );
%wxEventType wxEVT_COMMAND_LISTBOX_SELECTED // EVT_LISTBOX(winid, func );
%wxEventType wxEVT_COMMAND_COMBOBOX_SELECTED // EVT_COMBOBOX(winid, func );
%wxEventType wxEVT_COMMAND_CHOICE_SELECTED // EVT_CHOICE(winid, func );
%wxEventType wxEVT_COMMAND_CHECKBOX_CLICKED // EVT_CHECKBOX(winid, func );
%wxEventType  // EVT_BUTTON(winid, func );
%wxchkver_2_4 %wxEventType wxEVT_COMMAND_TOGGLEBUTTON_CLICKED // EVT_TOGGLEBUTTON(id, fn );         
]]

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
        if type(m.Name) == "string" then 
            if type(m.Value) == "table" then
                local submenu = Menu( parent, m.Value )
                menu:Append( submenu, m.Name ) 
            end  
            if type(m.Value) == "function" then
                local item = wx.wxMenuItem( menu, wxID_USER_Index, m.Name, "", wx.wxITEM_NORMAL )
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
-- Controls
-------------------------------------------------------------------------------

function InitCtrl(newCtrl,layoutCtrl)
    
    if newCtrl.proportion == nil then newCtrl.proportion = 0 end
    if newCtrl.expand == nil then newCtrl.expand = true end
    if newCtrl.border == nil then newCtrl.border = 1 end
    newCtrl.SetLayoutParam = function( proportion, expand, border )
        newCtrl.proportion = proportion
        newCtrl.expand = expand
        newCtrl.border = border
    end 
    if layoutCtrl and layoutCtrl.tooltip then
        newCtrl.ctrl:SetToolTip(wx.wxToolTip(layoutCtrl.tooltip))   
    end
    if layoutCtrl and layoutCtrl.menu then
        local menu = Menu(newCtrl.ctrl,layoutCtrl.menu)
        newCtrl.ctrl:Connect(wx.wxEVT_RIGHT_DOWN, function(event) 
                newCtrl.ctrl:PopupMenu( menu, event:GetPosition() )
            end ) 
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

function StaticText(parent,layoutCtrl)
    local newCtrl = {}
    newCtrl.ctrl = wx.wxStaticText( parent, wx.wxID_ANY, layoutCtrl.label,
                    wx.wxDefaultPosition, wx.wxDefaultSize) --wx.wxSize(-1,50)
    newCtrl.proportion = 0
    newCtrl.expand = false
    newCtrl.border = 1
    return newCtrl
end

function StaticBitmap(parent,layoutCtrl) --TODO: Te be tested
    local newCtrl = {}
    local flag = wx.wxALIGN_CENTER
    local bitmap = wx.Bitmap( layoutCtrl.image, wx.BITMAP_TYPE_ANY )
    newCtrl.ctrl = wx.wxStaticText( parent, wx.wxID_ANY, bitmap,
                    wx.wxDefaultPosition, wx.wxDefaultSize, flag) --wx.wxSize(-1,50)
    newCtrl.ctrl.Connect( wx.EVT_SIZE, function(layoutCtrl,event) event:Skip() end )
    newCtrl.proportion = 0
    newCtrl.expand = false
    newCtrl.border = 1
    return newCtrl
end

function ToggleButton(parent,layoutCtrl)
    local newCtrl = {}
    newCtrl.ctrl = wx.wxToggleButton( parent, wxID_USER_Index, layoutCtrl.label,
                    wx.wxDefaultPosition, wx.wxDefaultSize)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(newCtrl,layoutCtrl)    
    if layoutCtrl.handler ~= nil then
        parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, layoutCtrl.handler )
    end
    newCtrl.SetValue = function(v) newCtrl.ctrl:SetValue(v) end
    newCtrl.GetValue = function() return newCtrl.ctrl:GetValue() end
    return newCtrl
end

function CheckBox(parent,layoutCtrl)
    local newCtrl = {}
    newCtrl.ctrl = wx.wxCheckBox( parent, wxID_USER_Index, layoutCtrl.label,
                    wx.wxDefaultPosition, wx.wxDefaultSize)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(newCtrl,layoutCtrl)    
    if layoutCtrl.handler ~= nil then
        parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_CHECKBOX_CLICKED, layoutCtrl.handler )
    end
    return newCtrl
end

function BitmapButton(parent,layoutCtrl) --TODO: To be tested
    local newCtrl = {}
    newCtrl.ctrl = wx.wxBitmapButton( parent, wxID_USER_Index, layoutCtrl.image,
                    wx.wxDefaultPosition, wx.wxDefaultSize)
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(button,layoutCtrl) 
    return newCtrl 
end

function TextCtrl(parent,layoutCtrl)
    local text = {}
    text.ctrl = wx.wxTextCtrl(parent, wxID_USER_Index, layoutCtrl.text,
                    wx.wxDefaultPosition, wx.wxDefaultSize,
                    wx.wxTE_PROCESS_ENTER ) 
    text.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(text,layoutCtrl) 
 
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

function MLTextCtrl(parent,layoutCtrl)
    local text = {}
    text.ctrl = wx.wxTextCtrl(parent, wxID_USER_Index, layoutCtrl.data,
                wx.wxDefaultPosition, wx.wxDefaultSize,
                wx.wxTE_MULTILINE+wx.wxTE_DONTWRAP) 
    text.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    InitCtrl(text,layoutCtrl)  
    return text
end

function StyledText(parent,layoutCtrl)
    local stc = {}
    local style = 0
    local name = "wxStyledTextCtrl"
    stc.ctrl = wxstc.wxStyledTextCtrl(parent, wxID_USER_Index, 
                wx.wxDefaultPosition, wx.wxDefaultSize, style, name ) 
    stc.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1 
    InitCtrl(stc,layoutCtrl)  
    
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

function FilePicker(parent,layoutCtrl)
    local newCtrl = {}
    local style = wx.wxFLP_DEFAULT_STYLE
    if layoutCtrl.save then
        style = style + wx.wxFLP_SAVE + wx.wxFLP_OVERWRITE_PROMPT
    else
        style = style + wx.wxFLP_OPEN
    end

    newCtrl.ctrl = wx.wxFilePickerCtrl( parent, wx.wxID_USER_Index,
                    "", "Select a file", "*.*",
                    wx.wxDefaultPosition, wx.wxDefaultSize, style )
                   
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1 
    InitCtrl(newCtrl,layoutCtrl)  
end

function ListCtrl(parent,layoutCtrl)
    local newCtrl = { }
    newCtrl.ctrl = wx.wxListCtrl(parent, wxID_USER_Index,
                  wx.wxDefaultPosition, wx.wxDefaultSize,
                  wx.wxLC_REPORT + wx.wxBORDER_SUNKEN)
    newCtrl.id = wxID_USER_Index
    wxID_USER_Index = wxID_USER_Index + 1
    if layoutCtrl.handler then
        parent:Connect(newCtrl.id, wx.wxEVT_COMMAND_LIST_ITEM_SELECTED, layoutCtrl.handler )
    end        
    InitCtrl(newCtrl,layoutCtrl)
  
    local dropTarget = wx.wxLuaFileDropTarget();
    dropTarget.OnDropFiles = function(self, x, y, filenames)
        for i = 1, #filenames do
            newCtrl.ctrl:InsertItem(newCtrl.ctrl:GetItemCount()+1, filenames[i])    
        end
        return true
    end
    newCtrl.ctrl:SetDropTarget(dropTarget)
 
    --list:SetImageList(listImageList, wx.wxIMAGE_LIST_SMALL)
    newCtrl.col = 0
    newCtrl.row = 0
    
    newCtrl.Clear = function() newCtrl.ctrl:DeleteAllItems() end
    newCtrl.Set = function( row, col, label )
        newCtrl.ctrl:SetItem( row, col, label)
    end
    newCtrl.GetSelectedItems = function()
        local items = { }
        local item = -1
        while true do
            item = newCtrl.ctrl:GetNextItem(item, wx.wxLIST_NEXT_ALL, wx.wxLIST_STATE_SELECTED)
            if item == -1 then  
                break 
            end
            items[#items+1] = item
        end
        return items
    end
    newCtrl.AddColumn = function( label, size )
        newCtrl.ctrl:InsertColumn(newCtrl.col, label)
        newCtrl.ctrl:SetColumnWidth(newCtrl.col, size)
        newCtrl.col = newCtrl.col + 1
    end
    newCtrl.AddColumns = function( labels, widths )
        if labels == nil then return end
        for col = 1, #labels do
            newCtrl.ctrl:InsertColumn( col-1, labels[col])
            newCtrl.col = newCtrl.col + 1
        end
        if widths == nil then return end
        for col = 1, #widths do
            newCtrl.ctrl:SetColumnWidth(col-1, widths[col])
        end
    end    
    newCtrl.AddRow = function( row )
        newCtrl.ctrl:InsertItem( newCtrl.row, row[1] )
        for col = 2, #row do
            newCtrl.ctrl:SetItem( newCtrl.row, col-1, row[col])
        end
        newCtrl.row = newCtrl.row + 1
    end
    
    --if cols ~= nil then list.AddColumns( cols, colwidths ) end
    return newCtrl
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
                    if h.name == "StaticText" or
                       h.name == "Button" or
                       h.name == "ToggleButton" or
                       h.name == "CheckBox" or
                       h.name == "Choice" or
                       h.name == "ComboBox" or
                       h.name == "ListBox" or
                       h.name == "CheckListBox" or
                       h.name == "RadioBox" 
                    then
                        ctrl = CreateControl(parent,h)
                    elseif h.name == "TextCtrl" then
                        ctrl = TextCtrl(parent,h)
                    elseif h.name == "StyledText" then
                        ctrl = StyledText(parent,h)
                    elseif h.name == "ListCtrl" then
                        ctrl = ListCtrl(parent,h)
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
                        if ctrl.key ~= nil then __ctrl_table[ctrl.key] = ctrl end
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
    if __ctrl_table[key] ~= nil then
        return __ctrl_table[key].ctrl
    else
        return nil
    end
end

function GetCtrl(key)
    return __ctrl_table[key]
end

function Window(title,icon,layout, width, height) 
    
    window = {} 
    window.ctrl = __ctrl_table
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
        return __ctrl_table[name];
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

