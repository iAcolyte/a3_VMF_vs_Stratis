fnc_setDiver = {
	params["_unit"];
	removeAllWeapons _unit;
	removeUniform _unit;
	_unit addUniform "U_O_Wetsuit";
	removeVest _unit;
	removeBackpack _unit;
	_unit addVest "V_RebreatherIR";
	_unit addBackpack "B_Bergen_tna_F";
	_unit addGoggles "G_O_Diving";
};

fnc_showText = {
	params ['_l1', '_l2', '_l3','_delay'];                        
		_l11 = _l1 call BIS_fnc_localize;                        
		_l12 = _l2 call BIS_fnc_localize;                        
		_l13 = _l3 call BIS_fnc_localize;                                             
		private _text = parseText format["<t align='right' size='1.6'><t font='PuristaBold' size='1.8'>%1<br/></t>%2<br/>%3</t>",_l11,_l12,_l13];
		if (!isNil "_delay") then {
			sleep _delay;
		};                             
		[_text, true] spawn BIS_fnc_textTiles; 
};

fnc_getDate = { 
	private _dateTime = date; 
	private _dayStr = str(_dateTime#2);
	private _monthStr = str(_dateTime#1);
	if (_dateTime#2<10) then {_dayStr = "0" + _dayStr;};
	if (_dateTime#1<10) then {_monthStr = "0" + _monthStr;};
	_dayStr + "." + _monthStr + '.' + str(_dateTime #0); 
};

fnc_getTimeStr = {
	private _dateTime = date;
	private _hoursStr = str(_dateTime#3);
	private _minutesStr = str(_dateTime#4);
	if (_dateTime#3<10) then {_hoursStr = "0" + _hoursStr;};
	if (_dateTime#4<10) then {_minutesStr = "0" + _minutesStr;};
	_hoursStr + ":" + _minutesStr; 
};

fnc_loadStatuses = {
	skipTime (15/60);
	if (gromov loadStatus "gromovStatus")then {
		karpov loadStatus "karpovStatus";
		morozov loadStatus "morozovStatus";
		ustinov loadStatus "ustinovStatus";
		mironov loadStatus "mironovStatus";
		shevchenko loadStatus "shevchenkoStatus";
	};
	["Спустя 15 минут...", [] call fnc_getDate, [] call fnc_getTimeStr,2] spawn fnc_showText;
	msn_group_rearmed = true;
};

fnc_addSwapLoadoutAction = {
		// adds the action to every client and JIP, but also adds it when it was already removed. E.g., Laptop has already been hacked by a player
	[
		boat_storage,														// Object the action is attached to
		"Поменять снаряжение",													// Title of the action
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Idle icon shown on screen
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 6",									// Condition for the action to be shown
		"_caller distance _target < 6",									// Condition for the action to progress
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},																// Code executed when action starts
		{},																// Code executed on every progress tick
		{ [] call fnc_loadStatuses; [1, "BLACK", 4, 0] call BIS_fnc_fadeEffect; },							// Code executed on completion
		{
			[1, "BLACK", 1, 0] call BIS_fnc_fadeEffect;
		},																// Code executed on interrupted
		[],																// Arguments passed to the scripts as _this select 3
		4,																// Action duration in seconds
		0,																// Priority
		true,															// Remove on completion
		false															// Show in unconscious state
	] call BIS_fnc_holdActionAdd;
};
fnc_createCamp = {
	msn_campCreated = true;
};
fnc_addCreateCampAction = {
	[
		player,														// Object the action is attached to
		"Поменять снаряжение",													// Title of the action
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
		"camp_task distance player < 6",									// Condition for the action to be shown
		"camp_task distance player < 6",									// Condition for the action to progress
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},																// Code executed when action starts
		{},																// Code executed on every progress tick
		{ 
			[] call fnc_createCamp; 
			[1, "BLACK", 4, 0] call BIS_fnc_fadeEffect; 
		},							// Code executed on completion
		{
			[1, "BLACK", 1, 0] call BIS_fnc_fadeEffect;
		},																// Code executed on interrupted
		[],																// Arguments passed to the scripts as _this select 3
		4,																// Action duration in seconds
		0,																// Priority
		true,															// Remove on completion
		false															// Show in unconscious state
	] call BIS_fnc_holdActionAdd;
};

fnc_kbStartPart2 = {
	["Part2", "VMF_C1_M1","","DIRECT",{ true },[],1,true] spawn BIS_fnc_kbTell;
};

fnc_skipDiving = {
	msn_skip_diving = [
		player,
		"Пропустить путь до суши.",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_connect_ca.paa",
		"spn_boat1_destroyed",
		"true",
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},
		{},
		{ 
			player removeAction msn_skip_diving;
			
			skipTime 0.5;
			_groupUnits = units player;
			_markerPos = getMarkerPos ["marker_travel", true];
			for "_i" from 0 to count(_groupUnits) do { 
				hintSilent str _i; 
				_markerPos set [1,_markerPos#1+_i];
				_groupUnits#_i  setPos _markerPos;
			};
			
			[1, "BLACK", 4, 0] call BIS_fnc_fadeEffect;
			["Точка входа А", [] call fnc_getDate, [] call fnc_getTimeStr] spawn fnc_showText;
		},
		{
			[1, "BLACK", 1, 0] spawn BIS_fnc_fadeEffect;
		},
		[],
		4,
		0,
		true,
		false
	] call BIS_fnc_holdActionAdd;
}

