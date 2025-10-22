//msn_skip_time_can_be_skipped = true;
//msn_skip_time_skipping = false;
// msn_skip_time =	[
// 		player,														// Object the action is attached to
// 		"Наблюдение",													// Title of the action
// 		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
// 		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
// 		"msn_skip_time_can_be_skipped",									// Condition for the action to be shown
// 		"msn_skip_time_can_be_skipped",								// Condition for the action to progress
// 		{
// 			msn_skip_time_skipping = true;
// 			[] spawn {
// 				while {msn_skip_time_skipping} do
// 				{
// 					skipTime 0.00333;
// 					sleep 0.1; // smooth time transition
// 				};
// 			};
// 		},																// Code executed when action starts
// 		{
// 		},																// Code executed on every progress tick
// 		{ 
// 			msn_skip_time_skipping = false;
// 		},
// 		{
// 			msn_skip_time_skipping = false;
// 		},																// Code executed on interrupted
// 		[],																// Arguments passed to the scripts as _this select 3
// 		32,																// Action duration in seconds
// 		0,																// Priority
// 		false,															// Remove on completion
// 		false															// Show in unconscious state
// 	] call BIS_fnc_holdActionAdd;

msn_restSkipTime_Available = false;
msn_player_restState = 0;
msn_player_skill = 1;
msn_restSkipTime =	[
		player,														// Object the action is attached to
		"Отдых",													// Title of the action
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Idle icon shown on screen
		"\a3\data_f_destroyer\data\UI\IGUI\Cfg\holdactions\holdAction_unloadVehicle_ca.paa",	// Progress icon shown on screen
		"msn_restSkipTime_Available",									// Condition for the action to be shown
		"msn_restSkipTime_Available",								// Condition for the action to progress
		{
			[0, "BLACK", 4, 0] spawn BIS_fnc_fadeEffect;
		},																// Code executed when action starts
		{
		},																// Code executed on every progress tick
		{ 
			private _timeToRest = [msn_player_restState] call fnc_getRestSkipTime;
			msn_player_restState = msn_player_restState + _timeToRest/4;
			if (msn_player_restState>=1) then {
				msn_player_restState = 0;
				msn_player_skill = msn_player_skill + 0.4 min 1;
			};
			
			skipTime _timeToRest;
			[] call fnc_fireTimeEvent;
			[1, "BLACK", 1, 0] call BIS_fnc_fadeEffect;
		},
		{
			[1, "BLACK", 1, 0] call BIS_fnc_fadeEffect;
		},																// Code executed on interrupted
		[],																// Arguments passed to the scripts as _this select 3
		4,																// Action duration in seconds
		0,																// Priority
		false,															// Remove on completion
		false															// Show in unconscious state
	] call BIS_fnc_holdActionAdd;

fnc_getRestSkipTime = {
	params ["_restState"]; 
	private _requiredHours = (1-_restState)*4;
	date params ["_d","_m","_y","_hours","_minutes"]; 
	private _nextEventTime = [] call fnc_nextTimeEvent;
	private _skipTimeEvent = if (_nextEventTime#0 != -1) then {
		private _skipTimeEvent = _nextEventTime#0-_hours; 
		private _min = _nextEventTime#1 - _minutes; 
		if (_min<0) then { 
			_min = _min + 60; 
			_skipTimeEvent = _skipTimeEvent -1;  
		}; 
		_skipTimeEvent = _skipTimeEvent + _min/60;
		_skipTimeEvent = _skipTimeEvent min _requiredHours;
		_skipTimeEvent;
	} else {
		_requiredHours+_minutes/60;
	};
	_skipTimeEvent
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

{
	if (isNil "arrow") then { 
		arrow = "Sign_Arrow_F" createVehicle [0,0,0];
	};
	private _startPos = eyePos player;
	private _vectorDir = getCameraViewDirection player;
	private _maxDistance = 4000;
	private _endPos = _startPos vectorAdd (_vectorDir vectorMultiply _maxDistance);

	private _excludeObjects = player; 
	private _excludePlayers = objNull; 
	private _accuracy = true;

	private _hits = lineIntersectsSurfaces [
		_startPos,
		_endPos,
		_excludeObjects,
		_excludePlayers,
		_accuracy
	];
	arrow setPosASL (_hits select 0 select 0); 
	arrow setVectorUp (_hits select 0 select 1); 
	hintSilent str _ins;
};