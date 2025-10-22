params ["_endType"];
if (_endType == "KILLED" || _endType == "LOSER") exitWith {};
gromov saveStatus "gromovStatus";
karpov saveStatus "karpovStatus";
morozov saveStatus "morozovStatus";
ustinov saveStatus "ustinovStatus";
mironov saveStatus "mironovStatus";
medvedev saveStatus "medvedevStatus";
shevchenko saveStatus "shevchenkoStatus";
orlov saveStatus "orlovStatus";
romanov saveStatus "romanovStatus";
usuriev saveStatus "usurievStatus";

profileNamespace setVariable ["iacolyte_vmf_c1_m1_camp_position", if (triggerActivated trg_4a_boat_zone) then {"a"} else {"b"}]