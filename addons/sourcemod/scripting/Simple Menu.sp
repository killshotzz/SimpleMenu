#include <sourcemod>

public Plugin:myinfo = 
{
    name        = "Simple Menu",
    author      = "^kS",
    description = "A Menu for executing CFG's and various commands",
    version     = "1.2",
    url         = "https://github.com/ksgoescoding"
}

new Handle: g_ServerCommands
new Handle: g_MainMenu;
new Handle: g_MatchCommands;
new Handle: g_MapChanger

public OnPluginStart()
{
    RegAdminCmd("sm_srvcomms", Command_OpenMenu_ServerCommands, ADMFLAG_GENERIC|ADMFLAG_ROOT);
    RegAdminCmd("sm_main", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
    RegAdminCmd("sm_setup", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
    RegAdminCmd("sm_configs", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
    RegAdminCmd("sm_mcomms", Command_OpenMenu_MatchCommands, ADMFLAG_GENERIC|ADMFLAG_ROOT);
    RegAdminCmd("sm_mapchange", Command_OpenMenu_MapChanger, ADMFLAG_GENERIC|ADMFLAG_ROOT);

    g_ServerCommands = CreateMenu(Handler_ServerCommands);
    SetMenuTitle(g_ServerCommands, "Server Commands")
    AddMenuItem(g_ServerCommands, "1", "Practice Mode")
    AddMenuItem(g_ServerCommands, "2", "Warmup Mode")
    AddMenuItem(g_ServerCommands, "3", "Retakes Mode")
    AddMenuItem(g_ServerCommands, "4", "Deathmatch Mode")
    AddMenuItem(g_ServerCommands, "5", "Turn DM or Retake off")
    SetMenuExitBackButton(g_ServerCommands, true);

    g_MainMenu = CreateMenu(Handler_MainMenu);
    SetMenuTitle(g_MainMenu, "Main Menu")
    AddMenuItem(g_MainMenu, "1", "Match Commands")
    AddMenuItem(g_MainMenu, "2", "Server Commands")
    AddMenuItem(g_MainMenu, "3", "Change Map")

    g_MatchCommands = CreateMenu(Handler_MatchCommands);
    SetMenuTitle(g_MatchCommands, "Configs for Match Configuration")
    AddMenuItem(g_MatchCommands, "1", "Start Match (No OT)")
    AddMenuItem(g_MatchCommands, "2", "Start Match (With OT)")
    AddMenuItem(g_MatchCommands, "3", "Knife")
    AddMenuItem(g_MatchCommands, "4", "Swap Sides")
    AddMenuItem(g_MatchCommands, "5", "Coach Mode")
    SetMenuExitBackButton(g_MatchCommands, true);

    g_MapChanger = CreateMenu(Handler_MapChanger);
    SetMenuTitle(g_MapChanger, "Change Map")
    AddMenuItem(g_MapChanger, "1", "Dust 2")
    AddMenuItem(g_MapChanger, "2", "Mirage")
    AddMenuItem(g_MapChanger, "3", "Inferno")
    AddMenuItem(g_MapChanger, "4", "Overpass")
    AddMenuItem(g_MapChanger, "5", "Nuke")
    AddMenuItem(g_MapChanger, "6", "Vertigo")
    AddMenuItem(g_MapChanger, "7", "Ancient")
    AddMenuItem(g_MapChanger, "8", "Train")
    AddMenuItem(g_MapChanger, "9", "Cache")
    AddMenuItem(g_MapChanger, "10", "Office")
    AddMenuItem(g_MapChanger, "11", "Assault")
    AddMenuItem(g_MapChanger, "12", "Militia")
    SetMenuExitBackButton(g_MapChanger, true);
}


public Action:Command_OpenMenu_ServerCommands(client, argc)
{
    DisplayMenu(g_ServerCommands, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_MainMenu(client, argc)
{
    DisplayMenu(g_MainMenu, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_MatchCommands(client, argc)
{
    DisplayMenu(g_MatchCommands, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}
public Action:Command_OpenMenu_MapChanger(client, argc)
{
    DisplayMenu(g_MapChanger, client, MENU_TIME_FOREVER);
    return Plugin_Handled;
}

public Handler_ServerCommands(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                ServerCommand("sm_execcfg prac.cfg");
            }
            else if (StrEqual(info, "2"))
            {
                ServerCommand("sm_execcfg Warmup.cfg");
            }
            else if (StrEqual(info, "3"))
            {
                ServerCommand("sm_execcfg sourcemod/retakeon.cfg");
            }
            else if (StrEqual(info, "4"))
            {
                ServerCommand("sm_execcfg sourcemod/dmon.cfg");
            }
            else if (StrEqual(info, "5"))
            {
                ServerCommand("sm_execcfg sourcemod/off.cfg");
            }
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_MainMenu, client, MENU_TIME_FOREVER);
            }
        }
    }
}

public Handler_MainMenu(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                DisplayMenu(g_MatchCommands, client, MENU_TIME_FOREVER);
            }
            else if (StrEqual(info, "2"))
            {
                DisplayMenu(g_ServerCommands, client, MENU_TIME_FOREVER);
            }
            else if (StrEqual(info, "3"))
            {
                DisplayMenu(g_MapChanger, client, MENU_TIME_FOREVER);
            }
        }
    }
}

public Handler_MatchCommands(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                ServerCommand("sm_execcfg gamestart.cfg");
            }
            else if (StrEqual(info, "2"))
            {
                ServerCommand("sm_execcfg gamestart_ot.cfg");
            }
            else if (StrEqual(info, "3"))
            {
                ServerCommand("sm_execcfg knife.cfg");
            }
            else if (StrEqual(info, "4"))
            {
                ServerCommand("mp_swapteams");
            }
            else if (StrEqual(info, "5"))
            {
                ServerCommand("sm_execcfg coaching.cfg");
            }
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_MainMenu, client, MENU_TIME_FOREVER);
            }
        }
    }
}

public Handler_MapChanger(Handle:menu, MenuAction:action, client, slot)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            decl String:info[64];
            GetMenuItem(menu, slot, info, sizeof(info));
            
            if (StrEqual(info, "1"))
            {
                ServerCommand("sm_map dust2");
            }
            else if (StrEqual(info, "2"))
            {
                ServerCommand("sm_map mirage");
            }
            else if (StrEqual(info, "3"))
            {
                ServerCommand("sm_map inferno");
            }
            else if (StrEqual(info, "4"))
            {
                ServerCommand("sm_map overpass");
            }
            else if (StrEqual(info, "5"))
            {
                ServerCommand("sm_map nuke");
            }
            else if (StrEqual(info, "6"))
            {
                ServerCommand("sm_map vertigo");
            }
            else if (StrEqual(info, "7"))
            {
                ServerCommand("sm_map ancient");
            }
            else if (StrEqual(info, "8"))
            {
                ServerCommand("sm_map train");
            }
            else if (StrEqual(info, "9"))
            {
                ServerCommand("sm_map cache");
            }
            else if (StrEqual(info, "10"))
            {
                ServerCommand("sm_map office");
            }
            else if (StrEqual(info, "11"))
            {
                ServerCommand("sm_map assault");
            }
            else if (StrEqual(info, "12"))
            {
                ServerCommand("sm_map militia");
            }
        }
        case MenuAction_Cancel:
        {
            if (slot == MenuCancel_ExitBack)
            {
                DisplayMenu(g_MainMenu, client, MENU_TIME_FOREVER);
            }
        }
    }
}