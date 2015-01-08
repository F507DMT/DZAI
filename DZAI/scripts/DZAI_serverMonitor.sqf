
if (DZAI_debugLevel > 0) then {diag_log "DZAI Server Monitor will start in 1 minute."};

_cleanDead = diag_tickTime;
_monitorReport = diag_tickTime;
_deleteObjects = diag_tickTime;
_dynLocations = diag_tickTime;
_reportDynOrVehicles = (DZAI_dynAISpawns || ((DZAI_maxHeliPatrols > 0) or {(DZAI_maxLandPatrols > 0)}));

uiSleep 60;

while {true} do {
	//Main cleanup loop
	//if ((diag_tickTime - _cleanDead) > 600) then {
		_bodiesCleaned = 0;
		_vehiclesCleaned = 0;
		_nullObjects = 0;
		
		//Body/vehicle cleanup loop
		{
			_deathTime = _x getVariable "DZAI_deathTime";
			_EMS = _x getVariable "EMS";
			if (!isNil "_deathTime") then {
				if (_x isKindOf "CAManBase") then {
					//diag_log "DZAI Cleanup Debug: Unit type is CAManBase";
				if (isNil "_EMS") then {
				  if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],1000])) == 0) then {
							//diag_log "DZAI Cleanup Debug: No nearby players. Deleting unit";
							_soundflies = _x getVariable "sound_flies";
							if (!isNil "_soundflies") then {
								detach _soundflies;
								deleteVehicle _soundflies;
							};
							_x call DZAI_purgeEH;
							//diag_log format ["F507DMT DelDZAI :DEL if pl NOT in 1km: Deleting object %1 (type: %2).",_x,typeOf _x];
							deleteVehicle _x;
							_bodiesCleaned = _bodiesCleaned + 1;
							
					} else {
				  
					if ((diag_tickTime - _deathTime) > 900) then {
						if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],100])) == 0) then {
							//diag_log "DZAI Cleanup Debug: No nearby players. Deleting unit";
							_soundflies = _x getVariable "sound_flies";
							if (!isNil "_soundflies") then {
								detach _soundflies;
								deleteVehicle _soundflies;
							};
							_x call DZAI_purgeEH;
							//diag_log format ["F507DMT DelDZAI :DEL if pl in 1km: Deleting object %1 (type: %2).",_x,typeOf _x];
							deleteVehicle _x;
							_bodiesCleaned = _bodiesCleaned + 1;
						};
					};
					
						    };
								};
				
					
					if (!isNil "_EMS") then {
				
									  if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],1000])) == 0) then {
							//diag_log "DZAI Cleanup Debug: No nearby players. Deleting unit";
							_soundflies = _x getVariable "sound_flies";
							if (!isNil "_soundflies") then {
								detach _soundflies;
								deleteVehicle _soundflies;
							};
							_x call DZAI_purgeEH;
							//diag_log format ["F507DMT DelEMS :DEL if pl NOT in 1km: Deleting object %1 (type: %2).",_x,typeOf _x];
							deleteVehicle _x;
							_bodiesCleaned = _bodiesCleaned + 1;
							
					} else {
				  
					if ((diag_tickTime - _deathTime) > 1380) then {
						if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],100])) == 0) then {
							//diag_log "DZAI Cleanup Debug: No nearby players. Deleting unit";
							_soundflies = _x getVariable "sound_flies";
							if (!isNil "_soundflies") then {
								detach _soundflies;
								deleteVehicle _soundflies;
							};
							_x call DZAI_purgeEH;
							//diag_log format ["F507DMT DelEMS :DEL if pl in 1km: Deleting object %1 (type: %2).",_x,typeOf _x];
							deleteVehicle _x;
							_bodiesCleaned = _bodiesCleaned + 1;
						};
					};
					
						    };		
							
					};		
				} else {
					if (_x isKindOf "AllVehicles") then {
					 if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],1000])) == 0) then {
						if (_x in DZAI_monitoredObjects) then {
							{
							if (!(alive _x)) then {
							deleteVehicle _x;
							};
							} forEach (crew _x);
							};
							_x call DZAI_purgeEH;
							deleteVehicle _x;
							_vehiclesCleaned = _vehiclesCleaned + 1;
						
						} else {
					
						if ((diag_tickTime - _deathTime) > 900) then {
							if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],100])) == 0) then {
								if (_x in DZAI_monitoredObjects) then {
									{
										if (!(alive _x)) then {
											deleteVehicle _x;
										};
									} forEach (crew _x);
																	   };
								_x call DZAI_purgeEH;
								deleteVehicle _x;
								_vehiclesCleaned = _vehiclesCleaned + 1;
							};
						};
					  };
					};
				};
			};
			uiSleep 0.025;
		} count allDead;
		
		//Clean abandoned AI vehicles
		{	
			if (!isNull _x) then {
				private ["_deathTime"];
				_deathTime = _x getVariable "DZAI_deathTime";
				if (!isNil "_deathTime") then {
				///	
				if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],1000])) == 0) then {
					
					///del block
						_x call DZAI_purgeEH;
						//diag_log format ["DEBUG :: Deleting object %1 (type: %2).",_x,typeOf _x];
						{
							if (!alive _x) then {
								deleteVehicle _x;
							};
						} forEach (crew _x);
						deleteVehicle _x;
						_vehiclesCleaned = _vehiclesCleaned + 1;
						_nullObjects = _nullObjects + 1;
					///del block
				
				} else {
				if ((diag_tickTime - _deathTime) > 900) then {
					if (({isPlayer _x} count (_x nearEntities [["CAManBase","AllVehicles"],100])) == 0) then {
				
					///del block
						_x call DZAI_purgeEH;
						//diag_log format ["DEBUG :: Deleting object %1 (type: %2).",_x,typeOf _x];
						{
							if (!alive _x) then {
								deleteVehicle _x;
							};
						} forEach (crew _x);
						deleteVehicle _x;
						_vehiclesCleaned = _vehiclesCleaned + 1;
						_nullObjects = _nullObjects + 1;
					///del block
				
				};
				};
				};
				///
				};
			} else {
				_nullObjects = _nullObjects + 1;
			};
			uiSleep 0.025;
		} count DZAI_monitoredObjects;

		
		
		//Clean server object monitor
		if (_nullObjects > 4) then {
			missionNamespace setVariable [DZAI_serverObjectMonitor,((missionNamespace getVariable DZAI_serverObjectMonitor) - [objNull])];
			DZAI_monitoredObjects = DZAI_monitoredObjects - [objNull];
			diag_log format ["DZAI Cleanup: Cleaned up %1 null objects from server object monitor.",_nullObjects];
		};
		if ((_bodiesCleaned + _vehiclesCleaned) > 0) then {diag_log format ["DZAI Cleanup: Cleaned up %1 dead units and %2 destroyed vehicles.",_bodiesCleaned,_vehiclesCleaned]};
		_cleanDead = diag_tickTime;
	//};

	//Main location cleanup loop
	if ((diag_tickTime - _dynLocations) > 360) then { //clean up locations every 6 minutes
		_locationsDeleted = 0;
		{
			_deletetime = _x getVariable "deletetime";
			if (diag_tickTime > _deletetime) then {
				deleteLocation _x;
				_locationsDeleted = _locationsDeleted + 1;
			};
			uiSleep 0.025;
		} count DZAI_dynLocations;
		DZAI_dynLocations = DZAI_dynLocations - [locationNull];
		if (_locationsDeleted > 0) then {diag_log format ["DZAI Cleanup: Cleaned up %1 expired dynamic blacklist areas.",_locationsDeleted]};
		_dynLocations = diag_tickTime;
	};

	//Report statistics to RPT log
	if ((DZAI_monitorRate > 0) && {((diag_tickTime - _monitorReport) > DZAI_monitorRate)}) then {
		_uptime = [] call DZAI_getUptime;
		diag_log format ["DZAI Monitor :: Server Uptime: [%1d %2h %3m %4s]. Active AI Groups: %5.",_uptime select 0, _uptime select 1, _uptime select 2, _uptime select 3,({!isNull _x} count DZAI_activeGroups)];
		diag_log format ["DZAI Monitor :: Static Spawns: %1. Respawn Queue: %2 groups queued.",(count DZAI_staticTriggerArray),(count DZAI_respawnQueue)];
		if (_reportDynOrVehicles) then {diag_log format ["DZAI Monitor :: Dynamic Spawns: %1. Air Patrols: %2. Land Patrols: %3.",(count DZAI_dynTriggerArray),DZAI_curHeliPatrols,DZAI_curLandPatrols];};
		_monitorReport = diag_tickTime;
	};
	
	uiSleep 30;
};
_nul = [] execVM format ['%1\scripts\DZAI_serverMonitor.sqf',DZAI_directory]; //restart DZAI server monitor if main loop exits for some reason.
