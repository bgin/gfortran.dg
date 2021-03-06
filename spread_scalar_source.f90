! { dg-do run }
! { dg-options "-O0" }

  character*1 :: i, j(10)
  character*8 :: buffer
  integer(kind=1) :: ii, jj(10)
  type :: mytype
    real(kind=8) :: x
    integer(kind=1) :: i
    character*15 :: ch
  end type mytype
  type(mytype) :: iii, jjj(10)

  i = "w"
  ii = 42
  iii = mytype (41.9999_8, 77, "test_of_spread_")

! Test constant sources.

  j = spread ("z", 1 , 10)
  if (any (j /= "z")) stop 1
  jj = spread (19, 1 , 10)
  if (any (jj /= 19)) stop 1

! Test variable sources.

  j = spread (i, 1 , 10)
  if (any (j /= "w")) stop 1
  jj = spread (ii, 1 , 10)
  if (any (jj /= 42)) stop 1
  jjj = spread (iii, 1 , 10)
  if (any (jjj%x /= 41.9999_8)) stop 1
  if (any (jjj%i /= 77)) stop 1
  if (any (jjj%ch /= "test_of_spread_")) stop 1

! Check that spread != 1 is OK.

  jj(2:10:2) = spread (1, 1, 5)
  if (any (jj(1:9:2) /= 42) .or. any (jj(2:10:2) /= 1)) stop 1

! Finally, check that temporaries and trans-io.c work correctly.

  write (buffer, '(4a1)') spread (i, 1 , 4)
  if (trim(buffer) /= "wwww") stop 1
  write (buffer, '(4a1)') spread ("r", 1 , 4)
  if (trim(buffer) /= "rrrr") stop 1
  write (buffer, '(4i2)') spread (ii, 1 , 4)
  if (trim(buffer) /= "42424242") stop 1
  write (buffer, '(4i2)') spread (31, 1 , 4)
  if (trim(buffer) /= "31313131") stop 1

  end
