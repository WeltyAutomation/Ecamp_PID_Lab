
TYPE
	TempGroup_type : 	STRUCT 
		MpZones : ARRAY[0..2]OF TempZone_type;
	END_STRUCT;
	TempZone_type : 	STRUCT 
		In : TempZoneInput_type;
		Out : TempZoneOutput_type;
	END_STRUCT;
	TempZoneInput_type : 	STRUCT 
		Enable : BOOL;
		ErrorReset : BOOL;
		Update : BOOL;
		SetTemperature : REAL;
		ActualTemperature : REAL;
		Control : BOOL;
		Parameters : MpTempControllerParType;
	END_STRUCT;
	TempZoneOutput_type : 	STRUCT 
		Active : USINT;
		Error : USINT;
		StatusID : DINT;
		UpdateDone : USINT;
		Heat : BOOL;
		Cool : BOOL;
		ControlActive : USINT;
		Info : MpTempControllerInfoType;
	END_STRUCT;
	TempCtrlState_enum : 
		(
		TEMP_INIT,
		TEMP_IDLE,
		TEMP_ON,
		TEMP_ERROR
		);
	TempStatus_type : 	STRUCT 
		AmbientTemp : ARRAY[0..3]OF REAL;
		CurrentTemp : ARRAY[0..3]OF REAL;
		AtTemp : ARRAY[0..3]OF BOOL;
	END_STRUCT;
END_TYPE
