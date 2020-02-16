package.cpath = package.cpath..";./?.dll;./?.so;../lib/?.so;../lib/vc_dll/?.dll;../lib/bcc_dll/?.dll;../lib/mingw_dll/?.dll;"
require("wx")
require("ezwx")

-------------------------------------------------------------------------------
-- Resource
-------------------------------------------------------------------------------

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

function fnToggle() 
    local wxCtrl = GetWxCtrl('toggle')
    if wxCtrl:GetValue() then
        wxCtrl:SetLabel('On')
    else
        wxCtrl:SetLabel('Off')
    end
end

function fnCheckBox() 
    local wxCtrl = GetWxCtrl('checkbox')
    if wxCtrl:GetValue() then
        wxCtrl:SetLabel('CheckOn')
    else
        wxCtrl:SetLabel('CheckOff')
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

function fnChoice()
    Message( appWin.frame, "About Choice", GetCtrl('choice').GetText() )
end

function fnComboBox()
    Message( appWin.frame, "About ComboBox", GetCtrl('combobox').GetText())
end

function fnListBox()
    local ctrl = GetCtrl('listbox')
    local count = ctrl.GetCount()
    local value = ""
    for i = 1, count do
        if ctrl.IsSelected(i-1) then
            value = value .. " " .. ctrl.GetString(i-1)
        end
    end
    Message( appWin.frame, "About ListBox", value)
end

function fnListCtrl()
    local ctrl = GetCtrl('list')
    local items = ctrl.GetSelectedItems()
    local value = ""
    for i = 1, #items do
        value = value .. " " .. items[i]
    end
    Message( appWin.frame, "About ListCtrl", value)
end

function fnCheckListBox()
    local ctrl = GetCtrl('checklist')
    local count = ctrl.GetCount()
    local value = ""
    for i = 1, count do
        if ctrl.IsChecked(i-1) then
            value = value .. " " .. ctrl.GetString(i-1)
        end
    end
    Message( appWin.frame, "About ListBox", value)
end

function fnRadioBox()
    local ctrl = GetCtrl('radiobox')
    Message( appWin.frame, "About RadioBox", tostring(ctrl.GetSelection()) .. " " .. ctrl.GetText())
end

function main()
    local menu = { 
        { Name = "File", Value = {
                { Name = "Exit" , Value = fnExit, Icon='exit' } 
            }
        },
        { Name = "Help", Value = {
                { Name = "About", Value = fnAbout, Icon='help' }
            }
        } 
    }    
    local tool = {
        { Name = "Exit", Value = fnExit, Icon='exit', ToolTip="Quit Program" },
        { Name = "-" },
        { Name = nil, Value = fnAbout, Icon='help', ToolTip="About this Program" },
    }
    local main_layout = { proportion=1, expand=true, border=1 } 
    local list_menu = {
        { Name = "Exit" , Value = fnExit, Icon='exit' }
    }
    local listctrl_menu = {
        { Name = "Show Selected Items" , Value = fnListCtrl }
    }    
    local left = { -- vbox
            { -- hbox
                { name="ListCtrl", key="list", menu=listctrl_menu, layout=main_layout },
                { proportion=1, expand=true }
            },
            { proportion=1, expand=true }
        }
    local right = { --vbox
            { -- hbox
                { name="StyledText", key="stc", layout=main_layout },
                { proportion=1, expand=true }
            },
            { proportion=1, expand=true }
        }
    local content = { -- vbox
        { -- hbox
            { name="StaticText", label="  File  ", expand=true },
            { name="TextCtrl", key="text", text="Text", layout=main_layout },
            { name="Button", label="Open", handler=fnOpen, expand=true  },
            { name="ToggleButton", key='toggle', label="On", handler=fnToggle, expand=true  },
            { name="CheckBox", key='checkbox', label="CheckOn", handler=fnCheckBox, expand=true  },
            { proportion=0, expand=true }
        },
        { -- hbox
            { name='Choice', key='choice', items={'apple','grape'}, value=1, handler=fnChoice },
            { name='ComboBox', key='combobox', items={'apple','grape'}, value="apple", handler=fnComboBox },
            { proportion=0, expand=true }
        },        
        { -- hbox
            { name='ListBox', key='listbox', items={'apple','grape'}, menu=list_menu, handler=fnListBox },
            { name='CheckListBox', key='checklist', items={'apple','grape'}, menu=list_menu, handler=fnCheckListBox },
            { name='RadioBox', key='radiobox', label='RadioBox', items={'apple','grape'}, value=1, menu=list_menu, handler=fnRadioBox },
            { proportion=0, expand=true }
        },
        { -- hbox
            { name="SplitterWindow", key="split", children={left, right}, layout=main_layout },
            { proportion=1, expand=true }
        },
        { -- hbox
            { name="Spacer", expand=true },
            { name="Button", label="Start", tooltip="Make dummy list data", handler=fnStart, expand=true  },
            { proportion=0, expand=true }
        },
    }
    local layout = {
        menubar = menu,
        toolbar = tool,
        statusbar = 2,
        content = content,
    }

    appWin = Window("ezWxLua",exit_xpm,layout,600,400)
    appWin.SetTimer(fnTimer)
    appWin.ctrl.list.AddColumns( { "Time", "Diff" }, { 150, 150 } )
    appWin.Show()
    appWin.Run()
end

main()  
