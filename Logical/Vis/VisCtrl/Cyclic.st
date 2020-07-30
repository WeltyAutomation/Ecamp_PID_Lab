(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 30, 2020/11:50 AM 
 *********************************************************************************)

PROGRAM _CYCLIC
	
	//Page := ChangePage;
	
	IF Page = PAGE_START AND gMainState = MAIN_IDLE THEN 
		ChangePage := PAGE_MAIN;
	END_IF	
	 
END_PROGRAM
