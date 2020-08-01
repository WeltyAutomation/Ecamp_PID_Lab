
{REDUND_ERROR} FUNCTION UpdateControlParameters : BOOL (*Updates Control Parameters*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		NewParValues : ControlTune_type;
		ControllerPar : REFERENCE TO MpTempControllerParType;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION UpdateGlobalParameters : BOOL (*Update Global Parameters from control info*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		TuneRecipe : REFERENCE TO TuneRecipe_type;
		TempGroup : TempGroup_type;
	END_VAR
	VAR
		index : USINT;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION UpdateMtControlParameters : BOOL (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		NewParValues : ControlTune_type;
		ControllerPar : REFERENCE TO MTTempControllerType;
	END_VAR
END_FUNCTION
