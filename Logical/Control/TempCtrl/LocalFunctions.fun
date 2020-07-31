
{REDUND_ERROR} FUNCTION UpdateControlParameters : BOOL (*Updates Control Parameters*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		NewParValues : ControlTune_type;
		ControllerPar : REFERENCE TO MpTempControllerParType;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION UpdateGlobalParameters : BOOL (*Update Global Parameters from control info*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		TuneValues : REFERENCE TO ControlTune_type;
		ControllerInfo : MpTempControllerInfoType;
	END_VAR
END_FUNCTION
