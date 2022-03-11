**Free
//==============================================================================
// C O M P I L E R  O P T I O N S

Ctl-Opt DftActGrp(*No) Option(*SrcStmt : *NoDebugIO);


//==============================================================================
// D A T A  S T R U C T U R E S


//==============================================================================
// G L O B A L  V A R I A B L E S

Dcl-S EndProgram Ind Inz(*Off);


//==============================================================================
// G L O B A L  C O N S T A N T S


//==============================================================================
// E X T E R N A L  P R O C E D U R E S

// Setup SQL Environment
Exec SQL
  Set Option
      Commit    = *None
    , DlyPrp    = *No
    , CloSqlCsr = *EndMod
    , DatFmt    = *ISO
    , Naming    = *Sys;


//==============================================================================
// M A I N

DoW Not EndProgram;
  
  If (1 = 1);
    EndProgram = *On;
  EndIf;

  If (2 = 2);
    EndProgram = *On;
  EndIf;
 
  If (3 = 3);
    EndProgram = *On;
  EndIf;

  If (4 = 4);
    EndProgram = *On;
  EndIf;
  

EndDo;



//------------------------------------------------------------------------------
// End Program
*Inlr = *On;
Return;


//==============================================================================
// S U B P R O C E D U R E S

