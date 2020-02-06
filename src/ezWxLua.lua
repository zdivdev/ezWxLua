package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")

wxID_USER_Index = 1000

-------------------------------------------------------------------------------
-- Event
-------------------------------------------------------------------------------

--[[
wxEVT_COMMAND_MENU_SELECTED
wxEVT_COMMAND_TOOL_CLICKED
wxEVT_COMMAND_TOOL_ENTER
wxEVT_COMMAND_TOOL_RCLICKED

wxEVT_COMMAND_TEXT_COPY
wxEVT_COMMAND_TEXT_CUT
wxEVT_COMMAND_TEXT_PASTE

wxEVT_COMMAND_LIST_BEGIN_DRAG
wxEVT_COMMAND_LIST_BEGIN_RDRAG
wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT
wxEVT_COMMAND_LIST_COL_CLICK
wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS
wxEVT_COMMAND_LIST_DELETE_ITEM
wxEVT_COMMAND_LIST_END_LABEL_EDIT
!%wxchkver_2_6 %wxEventType wxEVT_COMMAND_LIST_GET_INFO // EVT_LIST_GET_INFO(id, fn );
!%wxchkver_2_6 %wxEventType wxEVT_COMMAND_LIST_SET_INFO // EVT_LIST_SET_INFO(id, fn );
 wxEVT_COMMAND_LIST_INSERT_ITEM
 wxEVT_COMMAND_LIST_ITEM_ACTIVATED
 wxEVT_COMMAND_LIST_ITEM_DESELECTED
 wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK
 wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK
 wxEVT_COMMAND_LIST_ITEM_SELECTED
 wxEVT_COMMAND_LIST_KEY_DOWN
 wxEVT_COMMAND_LIST_CACHE_HINT
 wxEVT_COMMAND_LIST_COL_RIGHT_CLICK
 wxEVT_COMMAND_LIST_COL_BEGIN_DRAG
 wxEVT_COMMAND_LIST_COL_DRAGGING
 wxEVT_COMMAND_LIST_COL_END_DRAG

]]

-------------------------------------------------------------------------------
-- Resource
-------------------------------------------------------------------------------
--[[
    image = wx.Image(stream, wx.BITMAP_TYPE_ANY) # wx.ImageFromStream for legacy wx
    bitmap = wx.Bitmap(image) # wx.BitmapFromImage for legacy wx

]]
--[[
#define_string wxART_TOOLBAR
#define_string wxART_MENU
#define_string wxART_FRAME_ICON
#define_string wxART_CMN_DIALOG
#define_string wxART_HELP_BROWSER
#define_string wxART_MESSAGE_BOX
#define_string wxART_BUTTON
#define_string wxART_OTHER

#define_string wxART_ADD_BOOKMARK
#define_string wxART_DEL_BOOKMARK
#define_string wxART_HELP_SIDE_PANEL
#define_string wxART_HELP_SETTINGS
#define_string wxART_HELP_BOOK
#define_string wxART_HELP_FOLDER
#define_string wxART_HELP_PAGE
#define_string wxART_GO_BACK
#define_string wxART_GO_FORWARD
#define_string wxART_GO_UP
#define_string wxART_GO_DOWN
#define_string wxART_GO_TO_PARENT
#define_string wxART_GO_HOME
#define_string wxART_FILE_OPEN
#define_string wxART_FILE_SAVE
#define_string wxART_FILE_SAVE_AS
#define_string wxART_PRINT
#define_string wxART_HELP
#define_string wxART_TIP
#define_string wxART_REPORT_VIEW
#define_string wxART_LIST_VIEW
#define_string wxART_NEW_DIR
#define_string wxART_HARDDISK
#define_string wxART_FLOPPY
#define_string wxART_CDROM
#define_string wxART_REMOVABLE
#define_string wxART_FOLDER
#define_string wxART_FOLDER_OPEN
#define_string wxART_GO_DIR_UP
#define_string wxART_EXECUTABLE_FILE
#define_string wxART_NORMAL_FILE
#define_string wxART_TICK_MARK
#define_string wxART_CROSS_MARK
#define_string wxART_ERROR
#define_string wxART_QUESTION
#define_string wxART_WARNING
#define_string wxART_INFORMATION
#define_string wxART_MISSING_IMAGE
#define_string wxART_COPY
#define_string wxART_CUT
#define_string wxART_PASTE
#define_string wxART_DELETE
#define_string wxART_NEW
#define_string wxART_UNDO
#define_string wxART_REDO
#define_string wxART_QUIT
#define_string wxART_FIND
#define_string wxART_FIND_AND_REPLACE
]]


local exit_xpm = {
"32 32 146 2 ",
"   c black",
".  c #130202",
"X  c #0D151B",
"o  c #131E27",
"O  c #581D02",
"+  c #5E2304",
"@  c #55210D",
"#  c #5A2712",
"$  c #5A2713",
"%  c #632806",
"&  c #682C09",
"*  c #6D310B",
"=  c #72350C",
"-  c #632F15",
";  c #683317",
":  c #6D371A",
">  c #723C1C",
",  c #77411E",
"<  c #774818",
"1  c #7B4A19",
"2  c #7D4621",
"3  c #294257",
"4  c #304C66",
"5  c #395B7A",
"6  c #971919",
"7  c #803710",
"8  c #C81616",
"9  c #D33B35",
"0  c #D93434",
"q  c #804E1A",
"w  c #8C4D1B",
"e  c #84521B",
"r  c #8A561C",
"t  c #8D591C",
"y  c #925D1D",
"u  c #A2551D",
"i  c #96601E",
"p  c #9A631F",
"a  c #834B22",
"s  c #8D5426",
"d  c #965B2A",
"f  c #986A2F",
"g  c #9C612D",
"h  c #A46120",
"j  c #A1662F",
"k  c #AB6723",
"l  c #B06C25",
"z  c #B77228",
"x  c #BD782B",
"c  c #A86C32",
"v  c #AE7133",
"b  c #B97B38",
"n  c #B37535",
"m  c #C37D2D",
"M  c #80694B",
"N  c #DB5C57",
"B  c #E05B5B",
"V  c #FB6E6E",
"C  c #FD7171",
"Z  c #FD7E7E",
"A  c #BF803B",
"S  c #C9822F",
"D  c #CE8732",
"F  c #C7883E",
"G  c #C2843D",
"H  c #D38B33",
"J  c #D79036",
"K  c #DF9739",
"L  c #DC9337",
"P  c #E69C3B",
"I  c #CC8C40",
"U  c #D39242",
"Y  c #41688A",
"T  c #185BC3",
"R  c #0A51DC",
"E  c #2061DE",
"W  c #0C56E9",
"Q  c #0F58E9",
"!  c #1259EA",
"~  c #185CEA",
"^  c #1D61EB",
"/  c #2566EB",
"(  c #2769EC",
")  c #2E6DEC",
"_  c #336FED",
"`  c #3C75EE",
"'  c #3F79EE",
"]  c #3672ED",
"[  c #4076E3",
"{  c #447CEE",
"}  c #497FEF",
"|  c #497CE6",
" . c #598BBD",
".. c #5F93C7",
"X. c #6198CE",
"o. c #68A0D7",
"O. c #6CA4DE",
"+. c #4F82E6",
"@. c #4C81EF",
"#. c #5A88E7",
"$. c #5286EF",
"%. c #5789EF",
"&. c #598BEF",
"*. c #5484E6",
"=. c #4289F4",
"-. c #5285F0",
";. c #5688F0",
":. c #5B8CF0",
">. c #608DE8",
",. c #6690E8",
"<. c #6C96E9",
"1. c #739AEA",
"2. c #608EF1",
"3. c #6492F1",
"4. c #6A96F2",
"5. c #6E99F2",
"6. c #739CF2",
"7. c #4DABFB",
"8. c #7CA0EC",
"9. c #7CA2F3",
"0. c #6CB2FB",
"q. c #7AB5FA",
"w. c #78B8FC",
"e. c #9E9E80",
"r. c #919282",
"t. c #9EA89C",
"y. c #FD8C8C",
"u. c #FD9494",
"i. c #FEA0A0",
"p. c #FEBBBB",
"a. c #86A8ED",
"s. c #87A9ED",
"d. c #91AFEE",
"f. c #82A6F4",
"g. c #85A9F4",
"h. c #8BADF4",
"j. c #84B1F7",
"k. c #8EB1F6",
"l. c #8BB6F8",
"z. c #8EB9F9",
"x. c #93B3F5",
"c. c #9AB8F6",
"v. c #FEC3C3",
"b. c #FECDCD",
"n. c #FED4D4",
"m. c None",
"m.m.m.m.m.m.m.m.m.P P P P P P P P P P P P P P P P P P P P P m.m.",
"m.m.m.m.m.m.m.m.m.P p p p p p p p p p g p p p p g p g f p p m.m.",
"m.m.m.m.m.m.m.m.m.P p                         o 5 X.0.=.U p m.m.",
"m.m.m.m.m.m.m.m.m.J p                 X 4 ..w.q.j.s.,.~ U p m.m.",
"m.m.m.m.m.m.m.m.m.J p         X 3  .O.q.l.k.h.g.g.9.5.~ I i m.m.",
"m.m.m.m.m.m.m.m.m.H p     Y o.q.z.c.x.x.h.h.g.f.9.9.5.~ F i m.m.",
"m.m.m.m.m.m.m.m.m.D p     7.c.c.c.x.k.h.h.g.f.9.9.6.5.~ G i m.m.",
"m.m.m.m.m.m.m.m.m.S y     7.d.x.x.k.g.g.f.9.9.6.6.6.3.^ A i m.m.",
"m.m.m.m.m.m.m.m.m.m y     7.d.h.h.g.g.g.9.6.6.6.4.4.&.~ b y m.m.",
"m.m.m.m.m.m.m.m.m.x y     7.f.h.g.g.9.9.6.6.6.4.4.3.} ~ n y m.m.",
"m.m.m.m.m.m.m.m.m.z t     7.f.g.g.9.6.6.6.6.4.4.2.2.` ~ v t m.m.",
"m.m.m.m.m.m.m.m.m.l t     7.8.9.9.6.6.5.4.4.3.3.&.:.) ~ c y m.m.",
"m.m.m.m.m.m.m.m.m.k t     7.1.9.6.6.6.4.4.3.:.:.;.@.~ ~ j t m.m.",
"m.m.m.m.m.m.m.8 m.h t     7.1.6.6.4.3.3.3.:.;.;.;._ ~ ~ g r m.m.",
"m.m.m.m.m.m.m.8 B u r     7.<.5.4.3.3.:.;.&.$.$.@./ ! ~ d r m.m.",
"m.8 8 8 8 8 8 8 p.N w     7.,.4.3.3.2.;.%.$.@.@._ ! ~ ~ s r m.m.",
"m.8 n.b.v.p.i.y.U C 9 .   7.>.3.3.:.%.$.-.@.@.' ^ ! ~ ! s e m.m.",
"m.8 b.v.i.y.C C Z C V 6   7.#.t.e.;.-.@.@.{ { / ! ~ Q ~ a q m.m.",
"m.8 v.u.C C C C C C 9 .   7.*.r.M T @.@.{ { ( ! Q ! ! Q 2 e m.m.",
"m.8 8 8 8 8 8 8 C 0 w     7.+.@.T @.} { ' ( ! ! ! Q ! ~ , e m.m.",
"m.m.m.m.m.m.m.8 0 7 a     7.| @.@.{ ' ] ( Q Q Q ! Q ! ! > q m.m.",
"m.m.m.m.m.m.m.8 m.: 2     7.| @.{ ` ) ^ Q Q Q Q ! ! Q ! : q m.m.",
"m.m.m.m.m.m.m.m.m.* 2     7.` ' ) ^ Q Q Q Q Q Q W ! ! ! ; 1 m.m.",
"m.m.m.m.m.m.m.m.m.* 1     7.E ~ W W Q Q W Q Q Q W W Q ! - 1 m.m.",
"m.m.m.m.m.m.m.m.m.% 1     7.R W W W W W Q W Q W ! W Q Q % 1 m.m.",
"m.m.m.m.m.m.m.m.m.+ <     7.R W W W W W W W W Q W W Q W $ < m.m.",
"m.m.m.m.m.m.m.m.m.+ <     7.R W W W W W W Q W W ! Q Q W $ < m.m.",
"m.m.m.m.m.m.m.m.m.O <     7.R W W W W W W W W W Q W W W O 1 m.m.",
"m.m.m.m.m.m.m.m.m.m.m.m.m.7.W W W W W W W W W W W W m.m.m.m.m.m.",
"m.m.m.m.m.m.m.m.m.m.m.m.m.7.W W W W W W W W W m.m.m.m.m.m.m.m.m.",
"m.m.m.m.m.m.m.m.m.m.m.m.m.7.W W W W W m.m.m.m.m.m.m.m.m.m.m.m.m.",
"m.m.m.m.m.m.m.m.m.m.m.m.m.m.W m.m.m.m.m.m.m.m.m.m.m.m.m.m.m.m.m."
}

function os.isfile(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
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
		local filename = "res32/" .. name .. '.png'
		if not os.isfile( filename ) then
			return wx.wxArtProvider.GetBitmap(wx.wxART_QUIT, wx.wxART_TOOLBAR, wx.wxSize(size, size))
		else 
			return wx.wxBitmap( filename, wx.wxBITMAP_TYPE_ANY )
            --return wx.wxBitmap(exit_xpm)
		end
	end
	if name == "help" then
		return wx.wxArtProvider.GetBitmap(wx.wxART_HELP, wx.wxART_TOOLBAR, wx.wxSize(size, size))
    end
end


function GetIcon(name)
     local icon = wx.wxIcon()
     icon:CopyFromBitmap(wx.wxBitmap(exit_xpm))
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
    
    window.SetMenuBar = function(menu) window.frame:SetMenuBar( MenuBar( window.frame, menu) ) end
    window.SetToolBar = function(tool) CreateToolBar( window.frame, tool ) end    
    window.SetStatusBar = function(count) 
        window.StatusBar = window.frame:CreateStatusBar( count, 0, wx.wxID_ANY )
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

    window.SetIcon = function(name)
        window.frame:SetIcon(GetIcon(name))
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
                { Name = "Exit" , Value = fnExit, Icon='exit' } 
            }
        },
        { Name = "도움말", Value = {
                { Name = "About", Value = fnAbout, Icon='help' }
            }
        } 
    }    
	local tool = {
		{ Name = "Exit", Value = fnExit, Icon='exit', ToolTip="Quit Program" },
		{ Name = "-" },
		{ Name = nil, Value = fnAbout, Icon='help', ToolTip="About this Program" },
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
	appWin.SetToolBar(tool)
    appWin.SetStatusBar(2)
    appWin.SetStatusText("Ready",0)
    appWin.SetTimer(fnTimer)
    appWin.SetContent(content)
    
    appWin.ctrl.list.AddColumns( { "Time", "Diff" }, { 300, 300 } )
    appWin.SetIcon("dsbw")
    appWin.Show()

    wx.wxGetApp():MainLoop()
end

main()  
