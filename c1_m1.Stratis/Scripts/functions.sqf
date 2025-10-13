
fnc_playerLeaveBoat = {
	doGetOut karpov;
	[karpov] joinSilent group player;
	msn_team1 joinSilent group player;
	msn_team2 joinSilent group player;
	sleep 1;
	{
		doGetOut _x;
		_x assignTeam "RED";
	} forEach  msn_team1;
	sleep 1;
	{
		doGetOut _x;
		_x assignTeam "GREEN";
	} forEach  msn_team2;
	group player setSpeedMode "NORMAL";
};

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

fnc_joinPlayer = {
	params ["_teamArray","_groupName"];
	[_teamArray#0] join grpNull;
	_team = group (_teamArray#0);
	_team setGroupId [_groupName];
	for "_i" from 1 to count _teamArray do { 
		[_teamArray#_i] join _team;
	};
	[_team, position player,player,false,""] call PC_fnc_wpPlatoonJoin;
};
fnc_loadStatuses = {
	skipTime (15/60);
	if (gromov loadStatus "gromovStatus")then {
		karpov loadStatus "karpovStatus";
		morozov loadStatus "morozovStatus";
		ustinov loadStatus "ustinovStatus";
		mironov loadStatus "mironovStatus";
		medvedev loadStatus "medvedevStatus";
		shevchenko loadStatus "shevchenkoStatus";
		orlov loadStatus "orlovStatus";
		romanov loadStatus "romanovStatus";
		usuriev loadStatus "usurievStatus";
	};
	{
		if (isNull unitBackpack  _x) then {
			_x addBackpack "B_Bergen_tna_F";
		};
	} forEach units player;

	["Спустя 15 минут...", [] call fnc_getDate, [] call fnc_getTimeStr,2] spawn fnc_showText;

	if (addon_pc_exists) then {
		[msn_team1,"Дельфин-1"] call fnc_joinPlayer;
		[msn_team2,"Дельфин-2"] call fnc_joinPlayer;
	};

	msn_group_rearmed = true;
	["t2","SUCCEEDED"] call BIS_fnc_taskSetState;
	player addRating 100;
	
	sleep 5;
	[] spawn fnc_setCreateCampTask;
};

fnc_addSwapLoadoutAction = {
	params ["_storage"];
	player addRating 100;
	sleep 2;
	[
		player,
		"t2",
		["Необходимо снять гидрокостюмы и акваланги, достать вооружение и снаряжения.","Перевооружиться"],
		position _storage,
		"ASSIGNED",
		2,
		true
	] call BIS_fnc_taskCreate;
	["t2","box"] call BIS_fnc_taskSetType;
		// adds the action to every client and JIP, but also adds it when it was already removed. E.g., Laptop has already been hacked by a player
	[
		_storage,														// Object the action is attached to
		"Поменять снаряжение",													// Title of the action
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Idle icon shown on screen
		"\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa",	// Progress icon shown on screen
		"_this distance _target < 6",									// Condition for the action to be shown
		"_caller distance _target < 6",									// Condition for the action to progress
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},																// Code executed when action starts
		{},																// Code executed on every progress tick
		{ 
			[] call fnc_loadStatuses; 
			[1, "BLACK", 4, 0] call BIS_fnc_fadeEffect;
			saveGame;
		},							// Code executed on completion
		{
			[1, "BLACK", 1, 0] call BIS_fnc_fadeEffect;
		},																// Code executed on interrupted
		[],																// Arguments passed to the scripts as _this select 3
		4,																// Action duration in seconds
		10,																// Priority
		true,															// Remove on completion
		false															// Show in unconscious state
	] call BIS_fnc_holdActionAdd;
};



fnc_setCreateCampTask = {
	private _position = if (triggerActivated trg_4a_boat_zone) then {
		_pos = getPosATL camp_trigger_a;
		[group player, 3] setWaypointPosition [getPosATL camp_trigger_a,0];
		_pos;
	} else {
		_pos = getPosATL camp_trigger_b;
		[group player, 3] setWaypointPosition [getPosATL camp_trigger_b,0];
		_pos;
	};
	[
		player,
		"t3",
		["Уже почти утро. Необходимо разбить лагерь и оставаться там до наступления темноты.","Разбить лагерь"],
		_position,
		"ASSIGNED",
		1,
		true
	] call BIS_fnc_taskCreate;
	["t3","backpack"] call BIS_fnc_taskSetType;
};

fnc_skipTo = { 
	params["_targetHours","_targetMinutes"]; 
	private _dateTime = date; 
	private _hours = _dateTime#3; 
	private _minutes = _dateTime#4; 
	if (_targetHours<_hours) exitWith {};
	
	if (_targetHours == _hours && _minutes<=_targetMinutes) exitWith {};

	_targetHours = _targetHours - _hours;
	_targetMinutes = _targetMinutes-_minutes; 
	

	if (_targetMinutes < 0) then {  
	_targetMinutes = _targetMinutes + 60;  
	_targetHours = _targetHours - 1; 
	};

	_skipValue = _targetHours + (_targetMinutes/60); 

	skipTime _skipValue;  
};


fnc_createCamp = {

	msn_campCreated = true;
	{
		if (backpack _x == "B_Bergen_tna_F") then {
			removeBackpack _x;
		};
	} forEach units player;
	{
		if (backpack _x == "B_Bergen_tna_F") then {
			removeBackpack _x;
		};
	} forEach msn_team1;
	{
		if (backpack _x == "B_Bergen_tna_F") then {
			removeBackpack _x;
		};
	} forEach msn_team2;

	_trigger = if (triggerActivated trg_4a_boat_zone) then {camp_trigger_a} else {camp_trigger_b};
	{_x hideObject false} forEach synchronizedObjects _trigger;
	["t3","SUCCEEDED"] call BIS_fnc_taskSetState;
	player addRating 100;
	//{_x hideObject false} forEach synchronizedObjects camp_trigger;
};
fnc_addCreateCampAction = {
	[
		player,														// Object the action is attached to
		"Разбить лагерь",													// Title of the action
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
		if (triggerActivated trg_4a_boat_zone) then {"(getPosATL camp_trigger_a) distance player < 6"} else {"(getPosATL camp_trigger_b) distance player < 6"},									// Condition for the action to be shown
		if (triggerActivated trg_4a_boat_zone) then {"(getPosATL camp_trigger_a) distance player < 6"} else {"(getPosATL camp_trigger_b) distance player < 6"},								// Condition for the action to progress
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},																// Code executed when action starts
		{},																// Code executed on every progress tick
		{ 
			[] call fnc_createCamp; 
			[7,58] call fnc_skipTo;
			["Время связи с 'Касаткой'", [] call fnc_getDate, [] call fnc_getTimeStr] spawn fnc_showText;
			[1, "BLACK", 4, 0] call BIS_fnc_fadeEffect;
			sleep 1;
			[0, "BLACK", 5, 1,"","END1"] spawn BIS_fnc_fadeEffect;
			
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
	params["_trigger"];
	private _badEvent = triggerActivated _trigger;
	gromov	kbAddTopic ["part2", "kb\part2.bikb"];
	morozov	kbAddTopic ["part2", "kb\part2.bikb"];
	
	gromov kbTell [player, "part2", "Sentence1"];
	waitUntil {gromov kbWasSaid [player, "part2", "Sentence1", 3]};
	if (_badEvent) then {
		morozov kbTell [gromov, "part2", "Sentence2Bad"];
		waitUntil {gromov kbWasSaid [player, "part2", "Sentence2Bad", 3]};
		gromov kbTell [morozov, "part2", "Sentence3Bad"];
		waitUntil {gromov kbWasSaid [player, "part2", "Sentence3Bad", 3]};
	};

	gromov kbRemoveTopic "part2";
	morozov kbRemoveTopic "part2";
	//["Part2", "VMF_C1_M1","","DIRECT",{ true },[],1,true] spawn BIS_fnc_kbTell;
};


msn_activeWaypoint = nil;
msn_old_wp_1 = nil;
msn_old_wp_2 = nil;
msn_old_wp_3 = nil;
fnc_selectDestinationB = {
	if (!isNil "msn_infiltration_b") then {
		player removeAction msn_infiltration_b;
		msn_infiltration_b = nil;
	};
	msn_infiltration_a =  player addAction ["Инфильтрация в точке A",{[] call fnc_selectDestinationA},[],5];
	[group player, 1] setWaypointPosition [getMarkerPos ["marker_travel_b", true],0];
	[group player, 2] setWaypointPosition [getMarkerPos ["marker_wp_alternative_1", true],0];
	[group player, 3] setWaypointPosition [getMarkerPos ["marker_wp_alternative_2", true],0];
};
fnc_selectDestinationA = {
	if (!isNil "msn_infiltration_a") then {
		player removeAction msn_infiltration_a;
		msn_infiltration_a = nil;
	};
	msn_infiltration_b =  player addAction ["Инфильтрация в точке Б",{[] call fnc_selectDestinationB},[],5];
	[group player, 1] setWaypointPosition [getMarkerPos ["marker_travel_a", true],0];
	[group player, 2] setWaypointPosition [msn_old_wp_2,0];
	[group player, 3] setWaypointPosition [msn_old_wp_3,0];
};

fnc_addSkipDiving = {
	hint "Вы можете совершить быстрое перемещение в точки инфильтрации. Выберите действие в меню";
	msn_old_wp_1 = getWPPos[group player,1];
	msn_old_wp_2 = getWPPos[group player,2];
	msn_old_wp_3 = getWPPos[group player,3];
	[] call fnc_selectDestinationA;
	msn_skip_diving = [
		player,
		"В точку инфильтрации",
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
			
			
			_groupUnits = units player;
			_markerPos = if (isNil "msn_infiltration_a") then {
				getMarkerPos ["marker_travel_a", true];
			} else {
				getMarkerPos ["marker_travel_b", true];
			};
			private _speed = 7.16952; // swim speed;
			skipTime (((player distance _markerPos)/1000)/_speed);
			for "_i" from 0 to count(_groupUnits) do { 
				_markerPos set [1,_markerPos#1+_i];
				_groupUnits#_i  setPos _markerPos;
			};
			if (isNil "msn_infiltration_a") then {player removeAction msn_infiltration_b;} else {player removeAction msn_infiltration_a;};
			[1, "BLACK", 4, 0] call BIS_fnc_fadeEffect;
			private _dest = if (isNil "msn_infiltration_a") then {"Точка входа А"} else {"Точка входа Б"};
			[_dest, [] call fnc_getDate, [] call fnc_getTimeStr] spawn fnc_showText;
		},
		{
			[1, "BLACK", 1, 0] spawn BIS_fnc_fadeEffect;
		},
		[],
		4,
		10,
		true,
		false
	] call BIS_fnc_holdActionAdd;
};

