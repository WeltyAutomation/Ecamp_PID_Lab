
TYPE
	MainState_enum : 
		(
		MAIN_INIT,
		MAIN_IDLE,
		MAIN_HEAT,
		MAIN_AUTOTUNE,
		MAIN_SAVERECIPE,
		MAIN_LOADRECIPE,
		MAIN_ERROR
		);
	MainCtrl_type : 	STRUCT 
		Cmd : MainCmd_type;
		Status : MainStatus_type;
		Par : MainCtrlPar_type;
	END_STRUCT;
	MainCmd_type : 	STRUCT 
		HeatOn : BOOL;
		AutotuneHeaters : BOOL;
		ErrorReset : BOOL;
		AutotuneMtHeater : BOOL;
		AbortTune : BOOL;
	END_STRUCT;
	MainStatus_type : 	STRUCT 
		AutotuneDone : BOOL;
		AutotuneInProgress : BOOL;
	END_STRUCT;
	MainCtrlPar_type : 	STRUCT 
		SingleZoneIndex : USINT;
	END_STRUCT;
	DIO_type : 	STRUCT 
		ZoneTemps : ARRAY[0..3]OF INT;
		HeatOn : ARRAY[0..3]OF BOOL;
		ZoneFans : ARRAY[0..2]OF BOOL;
		DisturbanceFan : BOOL;
	END_STRUCT;
	Error_type : 	STRUCT 
		ErrorActive : BOOL;
		ErrorSetID : UDINT;
		ErrorResetID : UDINT;
		ErrorName : STRING[100];
		LastState : MainState_enum;
		ErrorAcknowledgeID : UDINT;
	END_STRUCT;
	MainRecipeCtrl_type : 	STRUCT 
		Par : RecipeParameters_type;
		Cmd : RecipeCmd_type;
		Status : RecipeStatus_type;
	END_STRUCT;
	RecipeParameters_type : 	STRUCT 
		SelectedRecipeName : STRING[255];
		UISetup : MpRecipeUISetupType;
		UIConnect : MpRecipeUIConnectType;
		RecipeSaveIndex : USINT;
	END_STRUCT;
	RecipeCmd_type : 	STRUCT 
		LoadRecipe : BOOL;
		SaveRecipe : BOOL;
		SaveAutotune : BOOL;
	END_STRUCT;
	RecipeStatus_type : 	STRUCT 
		CommandDone : BOOL;
		SaveInProgress : BOOL;
		LoadInProgress : BOOL;
	END_STRUCT;
	TuneRecipe_type : 	STRUCT 
		ControlTune : ARRAY[0..3]OF ControlTune_type;
		Update : BOOL;
	END_STRUCT;
	ControlTune_type : 	STRUCT 
		PIDParameters : PIDParameterContainer_type;
		ProfileParameters : ProfileParametersContainer_type;
	END_STRUCT;
	PIDParameterContainer_type : 	STRUCT 
		Heat : PIDParameter_type;
		Cool : PIDParameter_type;
	END_STRUCT;
	PIDParameter_type : 	STRUCT 
		ProportionalGain : REAL;
		IntegrationTime : REAL;
		DerivativeTime : REAL;
		FilterTime : REAL;
	END_STRUCT;
	ProfileParametersContainer_type : 	STRUCT 
		Heat : ProfileParameters_type;
		Cool : ProfileParameters_type;
	END_STRUCT;
	ProfileParameters_type : 	STRUCT 
		SlewRate : REAL;
		FilterTime : REAL;
		DelayTime : REAL;
	END_STRUCT;
	TempInterface_type : 	STRUCT 
		Trends : ARRAY[0..3]OF TempInterfaceTrends_type;
		Status : ARRAY[0..3]OF TempInterfaceStatus_type;
		Parameters : ARRAY[0..3]OF TempInterfaceParameters_type;
		Commands : TempInterfaceCommands_type;
	END_STRUCT;
	TempInterfaceTrends_type : 	STRUCT 
		ActualTemp : REAL;
		SetTemp : REAL;
	END_STRUCT;
	TempInterfaceStatus_type : 	STRUCT 
		TuningInProgress : BOOL;
		HeatOn : BOOL;
		FanOn : BOOL;
		ControlActive : BOOL;
	END_STRUCT;
	TempInterfaceParameters_type : 	STRUCT 
		SetPoints : REAL;
		ProportionalGain : REAL;
		IntegralTime : REAL;
		DerivativeTime : REAL;
		Enable : BOOL;
	END_STRUCT;
	TempInterfaceCommands_type : 	STRUCT 
		StartTuning : BOOL;
		StopTuning : BOOL;
		HeatOn : BOOL;
	END_STRUCT;
END_TYPE
