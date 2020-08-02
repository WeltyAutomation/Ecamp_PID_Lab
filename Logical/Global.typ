
TYPE
	MainState_enum : 
		(
		MAIN_INIT := 0,
		MAIN_IDLE := 1,
		MAIN_HEAT := 2,
		MAIN_AUTOTUNE := 3,
		MAIN_ERROR := 4
		);
	RecipeCtrlState_enum : 
		(
		RECIPE_INIT := 0,
		RECIPE_IDLE := 1,
		RECIPE_SAVE := 2,
		RECIPE_SAVE_AUTOTUNE := 3,
		RECIPE_LOAD := 4,
		RECIPE_DELETE := 5,
		RECIPE_ERROR := 6
		);
	TempCtrlState_enum : 
		(
		TEMP_INIT := 0,
		TEMP_IDLE := 10,
		TEMP_ON := 20,
		TEMP_ON_MTZONE := 30,
		TEMP_AUTOTUNE := 40,
		TEMP_AUTOTUNE_ABORT := 41,
		TEMP_AUTOTUNE_MTZONE := 50,
		TEMP_ERROR := 60
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
		PID : ARRAY[0..3]OF PIDParameterContainer_type;
		Enables : ARRAY[0..3]OF BOOL := [4(TRUE)];
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
	StateReporter_type : 	STRUCT 
		Main : MainState_enum;
		Recipe : RecipeCtrlState_enum;
		Temp : TempCtrlState_enum;
	END_STRUCT;
END_TYPE
