**Free
//==============================================================================
// C O M P I L E R  O P T I O N S

Ctl-Opt DftActGrp(*No) Option(*SrcStmt : *NoDebugIO) BndDir('CB_BNDDIR');


//==============================================================================
// D A T A  S T R U C T U R E S


//==============================================================================
// G L O B A L  V A R I A B L E S

Dcl-S Schema      VarChar(10);
Dcl-S LockedByJob VarChar(28);


//==============================================================================
// E X T E R N A L  P R O C E D U R E S

// Check for record lock and return lock info
/Include QCPYLESRC,GNR8035_PR

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

Schema = *Blank;
If Is_RcdLocked(Schema:'VRMRATEQ':89:LockedByJob:SQLCOD);
  Get_ActiveJobInfo(LockedByJob:JobInfo:SQLCOD);
EndIf;


//------------------------------------------------------------------------------
// End Program
*Inlr = *On;
Return;


