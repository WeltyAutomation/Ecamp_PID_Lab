
TYPE
	TempStatus_type : 	STRUCT 
		AmbientTemp : ARRAY[0..3]OF REAL;
		CurrentTemp : ARRAY[0..3]OF REAL;
		AtTemp : ARRAY[0..3]OF BOOL;
		TuningInProgress : BOOL;
		SetTemp : ARRAY[0..3]OF REAL;
		CoolOn : ARRAY[0..3]OF BOOL;
		HeatOn : ARRAY[0..3]OF BOOL;
	END_STRUCT;
	TempGroupCmd_type : 	STRUCT 
		ErrorReset : BOOL;
	END_STRUCT;
	TempGroup_type : 	STRUCT 
		MpZones : ARRAY[0..2]OF TempZone_type;
		MtZone : MtZone_Type;
		Cmd : TempGroupCmd_type;
	END_STRUCT;
	TempZone_type : 	STRUCT 
		In : TempZoneInput_type;
		Out : TempZoneOutput_type;
	END_STRUCT;
	TempZoneInput_type : 	STRUCT 
		Update : BOOL;
		SetTemperature : REAL;
		ActualTemperature : REAL;
		Control : BOOL;
		Parameters : MpTempControllerParType := (Tuning:=(Mode:=mpTEMP_TUNING_MODE_HEAT_COOL,SetPointHeat:=80,SetPointCool:=50));
		Tune : BOOL;
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
		TuningDone : BOOL;
	END_STRUCT;
	TempCtrlState_enum : 
		(
		TEMP_INIT,
		TEMP_IDLE,
		TEMP_ON,
		TEMP_AUTOTUNE,
		TEMP_ERROR
		);
	MtZone_Type : 	STRUCT 
		Profile : MtZoneProfile_type;
		Controller : MtZoneController_type;
		Tuning : MtZoneTuning_type;
		Cmd : MtZoneCmd_type;
	END_STRUCT;
	MtZoneController_type : 	STRUCT 
		In : MtZoneControllerInput_type;
		Out : MtZoneControllerOutput_type;
	END_STRUCT;
	MtZoneControllerInput_type : 	STRUCT 
		PIDParameters : MTTempControllerType;
		MaxHeatOut : REAL;
		MaxCoolOut : REAL;
		Update : BOOL;
		SetTemperature : REAL;
		ActTemperature : REAL;
		FeedForwardHeat : REAL;
		FeedForwardCool : REAL;
		ControlStatusIn : DINT;
	END_STRUCT;
	MtZoneControllerOutput_type : 	STRUCT 
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		UpdateDone : BOOL;
		HeatOut : REAL;
		CoolOut : REAL;
	END_STRUCT;
	MtZoneProfile_type : 	STRUCT 
		In : MtZoneProfileInput_type;
		Out : MtZoneProfileOutput_type;
	END_STRUCT;
	MtZoneProfileInput_type : 	STRUCT 
		PlantParameters : MTTempPlantType;
		MaxHeatOut : REAL;
		MaxCoolOut : REAL;
		Mode : MTTempProfileModeEnum;
		Update : BOOL;
		AmbientTemperature : REAL;
		SetPointTemperature : REAL;
		Start : BOOL;
		Abort : BOOL;
		InitTemperature : REAL;
		Init : BOOL;
	END_STRUCT;
	MtZoneProfileOutput_type : 	STRUCT 
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		UpdateDone : BOOL;
		SetTemperature : REAL;
		FeedForwardHeat : REAL;
		FeedForwardCool : REAL;
		State : MTTempProfileModeEnum;
		InSetPoint : BOOL;
		InitDone : BOOL;
	END_STRUCT;
	MtZoneTuning_type : 	STRUCT 
		In : MtZoneTuningInput_type;
		Out : MtZoneTuningOutput_type;
	END_STRUCT;
	MtZoneTuningInput_type : 	STRUCT 
		AmbientTemperature : USINT;
		ActTemperature : REAL;
		HeatIn : REAL;
		CoolIn : REAL;
		Mode : MTTTempTuningModeEnum;
		SetPointTemperature : REAL;
		CoolDownTemperature : REAL;
		StartZingleZone : BOOL;
		Abort : BOOL;
	END_STRUCT;
	MtZoneTuningOutput_type : 	STRUCT 
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		SetTemperature : REAL;
		FeedForwardHeat : REAL;
		FeedForwardCool : REAL;
		TuningActive : BOOL;
		TuningDone : BOOL;
		State : MtTempTuningStateEnum;
		PIDParameters : MTTempControllerType;
		PIDParametersValid : BOOL;
		ControlStatusOut : DINT;
	END_STRUCT;
	MtZoneCmd_type : 	STRUCT 
		Abort : BOOL;
	END_STRUCT;
END_TYPE
