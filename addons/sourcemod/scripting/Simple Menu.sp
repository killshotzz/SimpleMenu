public Plugin myinfo = {
    name        = "Simple Menu",
    author      = "^kS",
    description = "A Menu for executing CFG's and various commands",
    version     = "1.2.1",
    url         = "https://github.com/ksgoescoding"
}

public void OnPluginStart()	{
	RegAdminCmd("sm_srvcomms", Command_OpenMenu_ServerCommands, ADMFLAG_GENERIC|ADMFLAG_ROOT);
	RegAdminCmd("sm_main", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
	RegAdminCmd("sm_setup", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
	RegAdminCmd("sm_configs", Command_OpenMenu_MainMenu, ADMFLAG_GENERIC|ADMFLAG_ROOT);
	RegAdminCmd("sm_mcomms", Command_OpenMenu_MatchCommands, ADMFLAG_GENERIC|ADMFLAG_ROOT);
	RegAdminCmd("sm_mapchange", Command_OpenMenu_MapChanger, ADMFLAG_GENERIC|ADMFLAG_ROOT);
}

Action Command_OpenMenu_ServerCommands(int client, int args=-1)	{
	Menu menu = new Menu(Handler_ServerCommands);
	menu.SetTitle("Server Commands")
	menu.AddItem("0", "Practice Mode")
	menu.AddItem("1", "Warmup Mode")
	menu.AddItem("2", "Retakes Mode")
	menu.AddItem("3", "Deathmatch Mode")
	menu.AddItem("4", "Turn DM or Retake off")
	menu.ExitBackButton = true;
	menu.Display(client, MENU_TIME_FOREVER);
	return Plugin_Handled;
}

Action Command_OpenMenu_MainMenu(int client, int args=-1)	{
	Menu menu = new Menu(Handler_MainMenu);
	menu.SetTitle("Main Menu")
	menu.AddItem("0", "Match Commands")
	menu.AddItem("1", "Server Commands")
	menu.AddItem("2", "Change Map")
	menu.Display(client, MENU_TIME_FOREVER);
	return Plugin_Handled;
}

Action Command_OpenMenu_MatchCommands(int client, int args=-1)	{
	Menu menu = new Menu(Handler_MatchCommands);
	menu.SetTitle("Configs for Match Configuration")
	menu.AddItem("0", "Start Match (No OT)")
	menu.AddItem("1", "Start Match (With OT)")
	menu.AddItem("2", "Knife")
	menu.AddItem("3", "Swap Sides")
	menu.AddItem("4", "Coach Mode")
	menu.ExitBackButton = true;
	menu.Display(client, MENU_TIME_FOREVER);
	return Plugin_Handled;
}

Action Command_OpenMenu_MapChanger(int client, int args=-1)	{
	Menu menu = new Menu(Handler_MapChanger);
	menu.SetTitle("Change Map")
	menu.AddItem("0", "Dust 2")
	menu.AddItem("1", "Mirage")
	menu.AddItem("2", "Inferno")
	menu.AddItem("3", "Overpass")
	menu.AddItem("4", "Nuke")
	menu.AddItem("5", "Vertigo")
	menu.AddItem("6", "Ancient")
	menu.AddItem("7", "Train")
	menu.AddItem("8", "Cache")
	menu.AddItem("9", "Office")
	menu.AddItem("10", "Assault")
	menu.AddItem("11", "Militia")
	menu.ExitBackButton = true;
	menu.Display(client, MENU_TIME_FOREVER);
	return Plugin_Handled;
}

int Handler_ServerCommands(Menu menu, MenuAction action, int client, int slot)	{
	switch(action)	{
		case	MenuAction_Select:	{
			switch(slot)	{
				case	0:	ServerCommand("sm_execcfg prac.cfg");
				case	1:	ServerCommand("sm_execcfg Warmup.cfg");
				case	2:	ServerCommand("sm_execcfg sourcemod/retakeon.cfg");
				case	3:	ServerCommand("sm_execcfg sourcemod/dmon.cfg");
				case	4:	ServerCommand("sm_execcfg sourcemod/off.cfg");
			}
		}
		case	MenuAction_Cancel:	{
			if(slot == MenuCancel_ExitBack)
				Command_OpenMenu_MainMenu(client);
			
			delete menu;
		}
	}
}

int Handler_MainMenu(Menu menu, MenuAction action, int client, int slot)	{
	switch(action)	{
		case	MenuAction_Select:	{
			switch(slot)	{
				case	0:	Command_OpenMenu_MatchCommands(client);
				case	1:	Command_OpenMenu_ServerCommands(client);
				case	2:	Command_OpenMenu_MapChanger(client);
			}
		}
		case	MenuAction_Cancel:	delete menu;
	}
}

int Handler_MatchCommands(Menu menu, MenuAction action, int client, int slot)	{
	switch(action)	{
		case	MenuAction_Select:	{
			switch(slot)	{
				case	0:	ServerCommand("sm_execcfg gamestart.cfg");
				case	1:	ServerCommand("sm_execcfg gamestart_ot.cfg");
				case	2:	ServerCommand("sm_execcfg knife.cfg");
				case	3:	ServerCommand("mp_swapteams");
				case	4:	ServerCommand("sm_execcfg coaching.cfg");
			}
		}
		case	MenuAction_Cancel:	{
			if(slot == MenuCancel_ExitBack)
				Command_OpenMenu_MainMenu(client);
			
			delete menu;
		}
	}
}

int Handler_MapChanger(Menu menu, MenuAction action, int client, int slot)	{
	switch(action)	{
		case	MenuAction_Select:	{
			switch(slot)	{
				case	0:	ServerCommand("sm_map dust2");
				case	1:	ServerCommand("sm_map mirage");
				case	2:	ServerCommand("sm_map inferno");
				case	3:	ServerCommand("sm_map overpass");
				case	4:	ServerCommand("sm_map nuke");
				case	5:	ServerCommand("sm_map vertigo");
				case	6:	ServerCommand("sm_map ancient");
				case	7:	ServerCommand("sm_map train");
				case	8:	ServerCommand("sm_map cache");
				case	9:	ServerCommand("sm_map office");
				case	10:	ServerCommand("sm_map assault");
				case	11:	ServerCommand("sm_map militia");
			}
		}
		case	MenuAction_Cancel:	{
			if(slot == MenuCancel_ExitBack)
				Command_OpenMenu_MainMenu(client);
			
			delete menu;
		}
	}
}