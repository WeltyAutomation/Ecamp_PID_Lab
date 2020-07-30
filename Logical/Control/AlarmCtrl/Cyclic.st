(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 29, 2020/8:34 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	AlarmFB.MpLink := ADR(gAlarmLink);
	AlarmFB.Enable := TRUE;
	
	AlarmListUI.MpLink    := ADR(gAlarmLink);
	AlarmListUI.Enable    := TRUE;
	AlarmListUI.UISetup   := AlarmUISetup;
	AlarmListUI.UIConnect := ADR(gAlarmUIConnect);

	AlarmFB();
	AlarmListUI();
	 
END_PROGRAM
