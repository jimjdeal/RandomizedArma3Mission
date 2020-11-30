_patrolCenterHints = [];
if (isNil "patrolCenter") then {
    _patrolCenterHints append [parseText "You must place a <t font=""PuristaBold"" color=""#ff0000"">Game Logic</t> (Found in Systems > Logic Entities) entity with the variable name <t font=""PuristaBold"" color=""#ff0000"">patrolCenter</t> where you want the mission to take place"];
} else {
    _patrolCenterMissingVariables = [];
    if (isNil { patrolCenter getVariable "patrolRadius" }) then {
        _patrolCenterMissingVariables append [parseText "<t align=""left"" color=""#ff0000"">this setVariable [""patrolRadius"", 150];</t><br/>where 150 would be the desired AO radius in meters"];
    };

    if (isNil { patrolCenter getVariable "friendlySpawnMinRadius" }) then {
        _patrolCenterMissingVariables append [parseText "<t align=""left"" color=""#ff0000"">this setVariable [""friendlySpawnMinRadius"", 800];</t><br/>where 800 would be the minimum distance from the center of the AO where friendly units should be spawned"];
    };

    if (isNil { patrolCenter getVariable "friendlySpawnMaxRadius" }) then {
        _patrolCenterMissingVariables append [parseText "<t align=""left"" color=""#ff0000"">this setVariable [""friendlySpawnMaxRadius"", 1000];</t><br/>where 1000 would be the maximum distance from the center of the AO where friendly units should be spawned"];
    };

    if (isNil { patrolCenter getVariable "enemySpawnMinRadius" }) then {
        _patrolCenterMissingVariables append [parseText "<t align=""left"" color=""#ff0000"">this setVariable [""enemySpawnMinRadius"", 0];</t><br/>where 0 would be the minimum distance from the center of the AO where enemy units should be spawned"];
    };

    if (isNil { patrolCenter getVariable "enemySpawnMaxRadius" }) then {
        _patrolCenterMissingVariables append [parseText "<t align=""left"" color=""#ff0000"">this setVariable [""enemySpawnMaxRadius"", 400];</t><br/>where 400 would be the maximum distance from the center of the AO where enemy units should be spawned"];
    };

    if ((count _patrolCenterMissingVariables) > 0) then {
        _commonPatrolCenterInstruction = [parseText "Find the <t font=""PuristaBold"" color=""#ff0000"">Game Logic</t> entity with the variable name <t font=""PuristaBold"" color=""#ff0000"">patrolCenter</t>. Enter these into said entity's init box:"];
        _patrolCenterHints = _commonPatrolCenterInstruction + _patrolCenterMissingVariables;
    };
};



_spawnerInitInstruction = parseText "In its init box you should put a variable with an array of group config paths for friendly groups to be spawned. For example:<br/><t align=""left"" color=""#ff0000"">this setVariable [""groups"", [<br/>&#160;&#160;&#160;&#160;(GROUP_CONFIG_PATH),<br/>&#160;&#160;&#160;&#160;(GROUP_CONFIG_PATH),<br/>&#160;&#160;&#160;&#160;(GROUP_CONFIG_PATH)<br/>]];</t><br/>Replace <t color=""#ff0000"">GROUP_CONFIG_PATH</t> with a group config path which can be found in the Eden editor <t font=""PuristaBold"" color=""#ff0000"">Tools -> Config Viewer</t>. Find <t font=""PuristaBold"" color=""#ff0000"">cfgGroups</t> on the left. Select the one you want and copy it from <t font=""PuristaBold"" color=""#ff0000"">Config Path</t> in the bottom of the screen. It should look something like this:<br/><t color=""#ff0000"">configfile >>""CfgGroups"" >> ""Indep"" >> ""IND_E_F"" >> ""Infantry"" >> ""I_E_InfTeam""</t><br/>You may add as many as you want. Add duplicates if you want more of the same group.";


_friendlySpawnerHints = [];
if (isNil "friendlySpawner" || {isNil {friendlySpawner getVariable "groups"} || {count(friendlySpawner getVariable "groups") == 0}}) then {
    _friendlySpawnerHints append [parseText "You must place a <t font=""PuristaBold"" color=""#ff0000"">Game Logic</t> entity with the variable name <t font=""PuristaBold"" color=""#ff0000"">friendlySpawner</t>."];

    _friendlySpawnerHints append [_spawnerInitInstruction];
};


_enemySpawnerHints = [];
if (isNil "enemySpawner" || {isNil {enemySpawner getVariable "groups"} || {count(enemySpawner getVariable "groups") == 0}}) then {
    _enemySpawnerHints append [parseText "You must place a <t font=""PuristaBold"" color=""#ff0000"">Game Logic</t> entity with the variable name <t font=""PuristaBold"" color=""#ff0000"">enemySpawner</t>."];

    _enemySpawnerHints append [_spawnerInitInstruction];
};



_allHints = [];

if ((count _patrolCenterHints) > 0) then {
    _allHints append [["Mission Area Setup", _patrolCenterHints]];
};

if ((count _friendlySpawnerHints) > 0) then {
    _allHints append [["Friendly Groups Spawner Setup", _friendlySpawnerHints]];
};

if ((count _enemySpawnerHints) > 0) then {
    _allHints append [["Enemy Groups Spawner Setup", _enemySpawnerHints]];
};

_allHints;