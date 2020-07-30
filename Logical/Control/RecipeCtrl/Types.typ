
TYPE
	RecipeCtrlState_enum : 
		(
		RECIPE_INIT,
		RECIPE_IDLE,
		RECIPE_SAVE,
		RECIPE_SAVE_AUTOTUNE,
		RECIPE_LOAD,
		RECIPE_DELETE,
		RECIPE_ERROR
		);
	RecipeCtrl_type : 	STRUCT 
		In : RecipeCtrlInput_type;
		Out : RecipeCtrlOutput_type;
		Par : RecipeCtrlPar_type;
	END_STRUCT;
	RecipeCtrlInput_type : 	STRUCT 
		ErrorReset : BOOL;
		DeviceName : STRING[50];
		FileName : STRING[255];
		Save : BOOL;
		Load : BOOL;
	END_STRUCT;
	RecipeCtrlOutput_type : 	STRUCT 
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		CommandDone : BOOL;
		Info : MpRecipeXmlInfoType;
	END_STRUCT;
	RecipeCtrlPar_type : 	STRUCT 
		In : RecipeCtrlParInput_type;
		Out : RecipeCtrlParOutput_type;
	END_STRUCT;
	RecipeCtrlParInput_type : 	STRUCT 
		ErrorReset : BOOL;
		PVName : STRING[100];
	END_STRUCT;
	RecipeCtrlParOutput_type : 	STRUCT 
		Active : BOOL;
		Error : BOOL;
		StatusID : DINT;
		Info : MpRecipeInfoType;
	END_STRUCT;
END_TYPE
