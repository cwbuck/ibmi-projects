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
// P R O T O T Y P E

Dcl-Pr GNR8035 ExtPgm('GNR8035');
  Schema       VarChar(10);
  Table        VarChar(10) Const;
  RRN          Zoned(15:0) Const;
  IsLocked     Ind;
  LockedByData LikeDs(LockedByData);
  SQLCod       Like(SQLCOD) Dim(2);
End-Pr;


//==============================================================================
// D A T A  S T R U C T U R E S

Dcl-Ds LockedByData Qualified Inz;
  JobName               VarChar(10);
  JobUser               VarChar(10);
  JobNumber             Varchar(6);
  JobStatus             VarChar(6);
  JobType               VarChar(28);
  JobSubsystem          VarChar(10);
  JobDate               Date(*ISO);
  JobDescriptionLibrary VarChar(10); 
  JObDescription        VarChar(10);
  JobEnteredSystemTime  Timestamp;
End-Ds;