! { dg-do run }
! { dg-options "-std=f2008 -fall-intrinsics" }

! PR fortran/44709
! Check that exit and cycle from within a BLOCK works for loops as expected.

! Contributed by Daniel Kraft, d@domob.eu.

PROGRAM main
  IMPLICIT NONE
  INTEGER :: i
  
  ! Simple exit without loop name.
  DO
    BLOCK
      EXIT
    END BLOCK
    stop 1
  END DO

  ! Cycle without loop name.
  DO i = 1, 1
    BLOCK
      CYCLE
    END BLOCK
    stop 1
  END DO

  ! Exit loop by name from within a BLOCK.
  loop1: DO
    DO
      BLOCK
        EXIT loop1
      END BLOCK
      stop 1
    END DO
    stop 1
  END DO loop1

  ! Cycle loop by name from within a BLOCK.
  loop2: DO i = 1, 1
    loop3: DO
      BLOCK
        CYCLE loop2
      END BLOCK
      stop 1
    END DO loop3
    stop 1
  END DO loop2
END PROGRAM main
