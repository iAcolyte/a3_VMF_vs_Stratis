
private _getMiddle = {
	_coordinates = [0,0,0];

	for "_i" from 0 to count _this -1 do
	{
		private _element = _this select _i;
		_coordinates set [0, _coordinates#0+_element#0];
		_coordinates set [1, _coordinates#1+_element#1];
		_coordinates set [2, _coordinates#2+_element#2];
	};
	_coordinates apply {_x / count _this};
};

private _tellWithSubtitle = {
	params ["_topic","_sentence"];
	private _subtitle = getText (missionConfigFile >> "CfgSentences" >> "VMF_C1_Intro" >> _topic >> "Sentences" >> _sentence >> "textPlain");
	private _actor = getText (missionConfigFile >> "CfgSentences" >> "VMF_C1_Intro" >> _topic >> "Sentences" >> _sentence >> "actor");
	_speaker = missionNamespace getVariable(_actor);
	_speaker kbTell [player, _topic, _sentence];
	sleep 0.1;
	while {!(_speaker kbWasSaid [player, _topic, _sentence, 3])} do {
		[name _speaker, localize _subtitle] spawn Bis_fnc_showSubtitle;
		sleep 1;
	};
};


//ShowHUD true;
enableEnvironment false;

gromov setIdentity "Gromov";
griev setIdentity "Griev";

gromov	kbAddTopic ["Briefing", "kb\briefing.bikb"];
griev	kbAddTopic ["Briefing", "kb\briefing.bikb"];
[1, "BLACK", 5, 0] spawn BIS_fnc_fadeEffect;
openMap[true,false];
_handler = addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	if (not _mapIsOpened) exitWith {
		endMission "END1";
	};
}];

mapAnimAdd[0,0.8,position gromov];
mapAnimCommit;

sleep 2;

["Briefing", "Sentence1"] call _tellWithSubtitle;

["Briefing", "Sentence2"] call _tellWithSubtitle;

["Briefing", "Sentence3"] call _tellWithSubtitle;

["Briefing", "Sentence4"] spawn _tellWithSubtitle;

mapAnimAdd[0.5,0.78,position gromov];
mapAnimAdd[0.5,0.8,position gromov];
mapAnimCommit;
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence4", 3]; };

["Briefing", "Sentence5"] call _tellWithSubtitle;

["Briefing", "Sentence6"] call _tellWithSubtitle;

["Briefing", "Sentence7"] call _tellWithSubtitle;

["Briefing", "Sentence8"] call _tellWithSubtitle;

["Briefing", "Sentence9"] call _tellWithSubtitle;

["Briefing", "Sentence10"] call _tellWithSubtitle;

["Briefing", "Sentence11"] call _tellWithSubtitle;

["Briefing", "Sentence12"] call _tellWithSubtitle;

["Briefing", "Sentence13"] call _tellWithSubtitle;

["Briefing", "Sentence14"] call _tellWithSubtitle;

["Briefing", "Sentence15"] call _tellWithSubtitle;

["Briefing", "Sentence16"] call _tellWithSubtitle;

["Briefing", "Sentence17"] call _tellWithSubtitle;

["Briefing", "Sentence18"] call _tellWithSubtitle;

["Briefing", "Sentence19"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.1,markerPos "marker_1"];
mapAnimCommit;
[] spawn {
	sleep 2;
	marker_1_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence19", 3]; };

["Briefing", "Sentence20"] spawn _tellWithSubtitle;
private _pos = [markerPos "marker_1", markerPos "marker_2"] call _getMiddle;
[_pos] spawn {
	mapAnimAdd[1,0.2, _this # 0];
	mapAnimAdd[1,0.1,markerPos "marker_2"];
	mapAnimCommit;
	sleep 2;
	marker_2_show = true;
	sleep 1;
	mapAnimAdd[1,0.3, _this # 0];
	mapAnimCommit;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence20", 3]; };
sleep 1;

["Briefing", "Sentence21"] spawn _tellWithSubtitle;
_pos = [markerPos "marker_1", markerPos "marker_2",markerPos "marker_3"] call _getMiddle;
mapAnimAdd[1,0.5,_pos];
mapAnimAdd[1,0.2,markerPos "marker_3"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_3_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence21", 3]; };

["Briefing", "Sentence22"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.4, [markerPos "marker_3", markerPos "marker_4"] call _getMiddle];
mapAnimAdd[1,0.1,markerPos "marker_4"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_4_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence22", 3]; };

["Briefing", "Sentence23"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.4, [markerPos "marker_4", markerPos "marker_5"] call _getMiddle];
mapAnimAdd[1,0.2,markerPos "marker_5"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_5_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence23", 3]; };

["Briefing", "Sentence24"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.3, [markerPos "marker_5", markerPos "marker_6"] call _getMiddle];
mapAnimAdd[1,0.2,markerPos "marker_6"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_6_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence24", 3]; };

["Briefing", "Sentence25"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.3, [markerPos "marker_6", markerPos "marker_7"] call _getMiddle];
mapAnimAdd[1,0.2,markerPos "marker_7"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_7_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence25", 3]; };

["Briefing", "Sentence26"] spawn _tellWithSubtitle;
mapAnimAdd[1,0.3, [markerPos "marker_7", markerPos "marker_8"] call _getMiddle];
mapAnimAdd[1,0.2,markerPos "marker_8"];
mapAnimCommit;

[] spawn {
	sleep 3;
	marker_8_show = true;
};
waitUntil { griev kbWasSaid [player, "Briefing", "Sentence26", 3]; };
sleep 1;

mapAnimAdd[2,0.8,position gromov];
mapAnimCommit;
["Briefing", "Sentence27"] call _tellWithSubtitle;
["Briefing", "Sentence28"] call _tellWithSubtitle;
["Briefing", "Sentence29"] call _tellWithSubtitle;
["Briefing", "Sentence30"] call _tellWithSubtitle;
["Briefing", "Sentence31"] call _tellWithSubtitle;
sleep 1;
[0, "BLACK", 5, 1,"","END1"] spawn BIS_fnc_fadeEffect;