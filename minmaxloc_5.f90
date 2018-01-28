! { dg-do run }
! PR35994 [4.3/4.4 regression] MAXLOC and MINLOC off by one with mask
program GA4076
  REAL DDA(100)
  dda = (/(J1,J1=1,100)/)
  IDS = MAXLOC(DDA,1)
  if (ids.ne.100) stop 1  !expect 100
  
  IDS = MAXLOC(DDA,1, (/(J1,J1=1,100)/) > 50)
  if (ids.ne.100) stop 1  !expect 100

  IDS = minLOC(DDA,1)
  if (ids.ne.1) stop 1  !expect 1

  IDS = MinLOC(DDA,1, (/(J1,J1=1,100)/) > 50)
  if (ids.ne.51) stop 1 !expect 51

END
