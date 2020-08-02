
TYPE
	TempStatus_type : 	STRUCT 
		AmbientTemp : ARRAY[0..3]OF REAL;
		CurrentTemp : ARRAY[0..3]OF REAL;
		AtTemp : ARRAY[0..3]OF BOOL;
		TuningInProgress : BOOL;
		SetTemp : ARRAY[0..3]OF REAL;
		CoolOn : ARRAY[0..3]OF BOOL;
		HeatOn : ARRAY[0..3]OF BOOL;
		Error : BOOL;
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
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		UpdateDone : BOOL;
		Heat : BOOL;
		Cool : BOOL;
		ControlActive : BOOL;
		Info : MpTempControllerInfoType;
		TuningDone : BOOL;
	END_STRUCT;
	MtZone_Type : 	STRUCT 
		Profile : MtZoneProfile_type;
		Controller : MtZoneController_type;
		Tuning : MtZoneTuning_type;
		Cmd : MtZoneCmd_type;
		Status : MtZoneStatus_type;
	END_STRUCT;
	MtZoneStatus_type : 	STRUCT 
		CurrentTemp : REAL;
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
		Enable : BOOL;
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
		State : MTTempProfileStateEnum;
		InSetPoint : BOOL;
		InitDone : BOOL;
	END_STRUCT;
	MtZoneTuning_type : 	STRUCT 
		In : MtZoneTuningInput_type;
		Out : MtZoneTuningOutput_type;
	END_STRUCT;
	MtZoneTuningInput_type : 	STRUCT 
		AmbientTemperature : REAL;
		ActTemperature : REAL;
		HeatIn : REAL;
		CoolIn : REAL;
		Mode : MTTempTuningModeEnum;
		SetPointTemperature : REAL;
		CoolDownTemperature : REAL;
		StartSingleZone : BOOL;
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
		State : MTTempTuningStateEnum;
		PIDParameters : MTTempControllerType;
		PIDParametersValid : BOOL;
		ControlStatusOut : DINT;
	END_STRUCT;
	MtZoneCmd_type : 	STRUCT 
		Abort : BOOL;
	END_STRUCT;
END_TYPE
