(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 29, 2020/10:21 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	
	RecipeCtrl.In.DeviceName    := DEVICE_NAME;
	RecipeCtrl.Par.In.PVName    := PV_NAME;
		
	RecipeXmlFB.MpLink          := ADR(gRecipeXml);
	RecipeXmlFB.Enable          := TRUE;
	RecipeXmlFB.ErrorReset      := RecipeCtrl.In.ErrorReset;
	RecipeXmlFB.DeviceName      := ADR(RecipeCtrl.In.DeviceName);
	RecipeXmlFB.FileName        := ADR(RecipeCtrl.In.FileName);
	RecipeXmlFB.Load            := RecipeCtrl.In.Load;
	RecipeXmlFB.Save            := RecipeCtrl.In.Save;
	
	RecipeParFB.MpLink          := ADR(gRecipeXml);
	RecipeParFB.Enable          := TRUE;
	RecipeParFB.ErrorReset      := RecipeCtrl.In.ErrorReset;
	RecipeParFB.PVName          := ADR(RecipeCtrl.Par.In.PVName);
	
	RecipeUIFB.MpLink           := ADR(gRecipeXml);
	RecipeUIFB.Enable           := TRUE;
	RecipeUIFB.ErrorReset       := RecipeCtrl.In.ErrorReset;
	RecipeUIFB.UIConnect        := ADR(gRecipeCtrl.Par.UIConnect);
	RecipeUIFB.UISetup          := gRecipeCtrl.Par.UISetup;
	
	RecipeCtrl.Out.Active       := RecipeXmlFB.Active;
	RecipeCtrl.Out.Error        := RecipeXmlFB.Error;
	RecipeCtrl.Out.StatusID     := RecipeXmlFB.StatusID;
	RecipeCtrl.Out.CommandDone  := RecipeXmlFB.CommandDone;
	RecipeCtrl.Out.Info         := RecipeXmlFB.Info;
	
	RecipeCtrl.Par.Out.Active   := RecipeParFB.Active;
	RecipeCtrl.Par.Out.Error    := RecipeParFB.Error;
	RecipeCtrl.Par.Out.StatusID := RecipeParFB.StatusID;
	RecipeCtrl.Par.Out.Info     := RecipeParFB.Info;
	
	CASE RecipeState OF
		RECIPE_INIT:
			RecipeState := RECIPE_IDLE;	
			
		RECIPE_IDLE:
			IF gRecipeCtrl.Cmd.SaveRecipe THEN
				gRecipeCtrl.Cmd.SaveRecipe   := FALSE;
				RecipeState                  := RECIPE_SAVE;
			ELSIF gRecipeCtrl.Cmd.SaveAutotune THEN
				gRecipeCtrl.Cmd.SaveAutotune := FALSE;
				RecipeState                  := RECIPE_SAVE_AUTOTUNE;
			ELSIF gRecipeCtrl.Cmd.LoadRecipe THEN
				gRecipeCtrl.Cmd.LoadRecipe   := FALSE;
				RecipeState                  := RECIPE_LOAD;
			END_IF;
			
		RECIPE_SAVE:
			IF NOT EDGEPOS(RecipeCtrl.Out.CommandDone) THEN
				RecipeCtrl.In.FileName := gRecipeCtrl.Par.SelectedRecipeName;
				RecipeCtrl.In.Save     := TRUE;
			ELSE
				RecipeCtrl.In.Save     := FALSE;
				RecipeCtrl.In.FileName := EMPTY_FILENAME;
				RecipeState            := RECIPE_IDLE;
			END_IF;
			
		RECIPE_SAVE_AUTOTUNE:
			IF NOT EDGEPOS(RecipeCtrl.Out.CommandDone) THEN
				RecipeCtrl.In.FileName := AUTOTUNE_FILENAME;
				RecipeCtrl.In.Save     := TRUE;
			ELSE
				RecipeCtrl.In.Save     := FALSE;
				RecipeCtrl.In.FileName := EMPTY_FILENAME;
				RecipeState            := RECIPE_IDLE;
			END_IF;
			
		RECIPE_LOAD:
			IF NOT EDGEPOS(RecipeCtrl.Out.CommandDone) THEN
				RecipeCtrl.In.FileName := gRecipeCtrl.Par.SelectedRecipeName;
				RecipeCtrl.In.Load     := TRUE;
			ELSE
				RecipeCtrl.In.Load     := FALSE;
				RecipeCtrl.In.FileName := EMPTY_FILENAME;
				RecipeState            := RECIPE_IDLE;
			END_IF;
			
		RECIPE_DELETE:
		RECIPE_ERROR:		  

	END_CASE;	
	 
END_PROGRAM
