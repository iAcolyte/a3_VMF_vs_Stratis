player setIdentity "Gromov";



addWeaponPool ["rhs_weap_asval_grip",14];
addWeaponPool ["rhs_weap_vss_grip",4];
execVM "Scripts\functions.sqf";

msn_preload_finished = false;
msn_preloadFinishedHandle = addMissionEventHandler ["PreloadFinished", {
	msn_preload_finished = true;
	removeMissionEventHandler["PreloadFinished", msn_preloadFinishedHandle];
}];

waitUntil {msn_preload_finished};

execVM "Scripts\onAfterPreloadFinished.sqf";

