[] execVM "functions.sqf";

private _campPos = profileNamespace getVariable ["iacolyte_vmf_c1_m1_camp_position", "a"];
if (_campPos == "b") then {
	{_x hideObject true} forEach synchronizedObjects camp_trigger_a;
	private _pos = position camp_trigger_b;
	private _units = units player;
	for "_i" from 0 to count(_units)  do {
		_pos set [0,_pos#0 + _i];
		_units#_i setPos [_pos#0+_i, _pos#1,_pos#2];
	};
} else {
	{_x hideObject true} forEach synchronizedObjects camp_trigger_b;
};

msn_currentHours = -1;
msn_currentMinutes = -1;

private _eachFrameEH = addMissionEventHandler ["EachFrame", {
	date params ["_year", "_month", "_day", "_hours", "_minutes"];
	if (msn_currentMinutes == _minutes) exitWith {};
	msn_currentMinutes = _minutes;
	msn_currentHours = _hours;
	[missionNamespace, "OnEachMinutes", [_hours, _minutes]] call BIS_fnc_callScriptedEventHandler;
}];
msn_preloadFinishedHandle = addMissionEventHandler ["PreloadFinished", {
	removeMissionEventHandler["PreloadFinished", msn_preloadFinishedHandle];
	msn_preloadFinishedHandle = nil;
	[] execVM "onAfterPreloadFinished.sqf";
}];