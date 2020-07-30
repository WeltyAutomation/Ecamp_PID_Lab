
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
	END_STRUCT;
	MainCmd_type : 	STRUCT 
		HeatOn : BOOL;
		AutotuneHeaters : BOOL;
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
	END_STRUCT;
	RecipeCmd_type : 	STRUCT 
		LoadRecipe : BOOL;
		SaveRecipe : BOOL;
		SaveAutotune : BOOL;
	END_STRUCT;
	RecipeStatus_type : 	STRUCT 
		CommandDone : BOOL;
	END_STRUCT;
	MainStatus_type : 	STRUCT 
		AutotuneDone : BOOL;
	END_STRUCT;
	Recipe_type : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
END_TYPE
