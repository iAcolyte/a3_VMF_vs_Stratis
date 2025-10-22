msn_timeBasedEvents = createLocation ["Invisible", [0,0,0], 0, 0];

msn_timeBasedEventsTime = [];

fnc_getTimeName  = {
	params ["_hours","_minutes"];
	private _hoursStr = if (_hours>9) then {str(_hours)} else {"0"+str(_hours)};
	private _minutesStr = if (_minutes>9) then {str(_minutes)} else {"0"+str(_minutes)};
	private _name = _hoursStr + ":" + _minutesStr;
	_name;
};

fnc_addTimeEvent = {
	params ["_hours","_minutes","_function"];
	msn_timeBasedEvents setVariable [[_hours,_minutes] call fnc_getTimeName, _function];
};

fnc_removeTimeEvent = {
	params ["_hours","_minutes"];
	msn_timeBasedEvents setVariable [[_hours,_minutes] call fnc_getTimeName, nil];
};
fnc_fireTimeEvent = {
	params ["_hours","_minutes"];
	if (isNil "_hours") then {
		private _date = date;
		_hours = _date#3;
		_minutes = _date#4;
	} else {
		if (isNil "_minutes") then {
			_minutes = date#4;
		};
	};
	private _name = [_hours,_minutes] call fnc_getTimeName;
	private _possibleEvent = msn_timeBasedEvents getVariable _name;
	if (isNil "_possibleEvent") exitWith {};
	[] spawn _possibleEvent;
	[_hours,_minutes] call fnc_removeTimeEvent;
};

fnc_allEvents = {
	private _events = allVariables msn_timeBasedEvents;
	private _result = [];
	{
		private _var = msn_timeBasedEvents getVariable _x;
		if (isNil {_var}) then {} else {
			_result pushBack _x;
		};
	} forEach _events;
	_result sort true;
	_result;
};

fnc_nextTimeEvent = {
	private _events = [] call fnc_allEvents;
	if (count(_events)==0) exitWith {[-1,-1]};
	private _var = _events select 0;
    private _spl = _var splitString ":";
	private _hours = [_spl#0] call BIS_fnc_parseNumber;
	private _minutes = [_spl#1] call BIS_fnc_parseNumber;
	[_hours,_minutes]
};

[missionNamespace, "OnEachMinutes", fnc_fireTimeEvent] call BIS_fnc_addScriptedEventHandler;