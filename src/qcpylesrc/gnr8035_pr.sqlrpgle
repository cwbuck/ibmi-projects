**Free
//==============================================================================
//     Program: GNR8035_PR
// Description: Prototype for calling GNR8035 program
//==============================================================================

// Prevent duplicate /INCLUDEs
/If Not Defined(GNR8035_PR)
/Define GNR8035_PR
/Else
/Eof
/EndIf

//==============================================================================
// D A T A  S T R U C T U R E S

Dcl-Ds JobInfo Qualified Inz;
  ShortName             VarChar(10);
  User                  VarChar(10);
  Number                Varchar(6);
  Status                VarChar(6);
  Type                  VarChar(28);
  Subsystem             VarChar(10);
  Date                  Date(*ISO);
  JobDescriptionLibrary VarChar(10); 
  JobDescription        VarChar(10);
  EnteredSystemTime     Timestamp;
End-Ds;


//==============================================================================
// P R O T O T Y P E S

Dcl-Pr Is_RcdLocked Ind;
  @Schema         VarChar(10);        // Both
  @Table          VarChar(10) Const;  // In
  @RRN            Zoned(15:0) Const;  // In
  @LockingJobName VarChar(28);        // Out
  @SQLCOD         Like(SQLCOD);       // Out
End-Pr;

Dcl-Pr Get_ObjLib VarChar(10);
  @ObjName VarChar(10) Const;         // In
  @SQLCOD  Like(SQLCOD);              // Out
End-Pr;  

Dcl-Pr Get_ActiveJobInfo;
  @JobName VarChar(28);               // In
  @JobInfo LikeDS(JobInfo);           // Out
  @SQLCOD  Like(SQLCOD);              // Out
End-Pr;  


