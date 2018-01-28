! { dg-do run }
! { dg-options "-std=f2003 -fall-intrinsics" }
! Tests the functionality of the patch for PR29642, which requested the
! implementation of the F2003 VALUE attribute for gfortran.
!
! Contributed by Paul Thomas  <pault@gcc.gnu.org> 
!
module global
  type :: mytype
    real(4) :: x
    character(4) :: c
  end type mytype
contains
  subroutine typhoo (dt)
    type(mytype), value :: dt
    if (dtne (dt, mytype (42.0, "lmno"))) stop 1
    dt = mytype (21.0, "wxyz")
    if (dtne (dt, mytype (21.0, "wxyz"))) stop 1
  end subroutine typhoo

  logical function dtne (a, b)
    type(mytype) :: a, b
    dtne = .FALSE.
    if ((a%x /= b%x) .or. (a%c /= b%c)) dtne = .TRUE.
  end function dtne
end module global

program test_value
  use global
  integer(8) :: i = 42
  real(8) :: r = 42.0
  character(2) ::   c = "ab"
  complex(8) :: z = (-99.0, 199.0)
  type(mytype) :: dt = mytype (42.0, "lmno")

  call foo (c)
  if (c /= "ab") stop 1

  call bar (i)
  if (i /= 42) stop 1

  call foobar (r)
  if (r /= 42.0) stop 1

  call complex_foo (z)
  if (z /= (-99.0, 199.0)) stop 1

  call typhoo (dt)
  if (dtne (dt, mytype (42.0, "lmno"))) stop 1

  r = 20.0
  call foobar (r*2.0 + 2.0)

contains
  subroutine foo (c)
    character(2), value :: c
    if (c /= "ab") stop 1
    c = "cd"
    if (c /= "cd") stop 1
  end subroutine foo

  subroutine bar (i)
    integer(8), value :: i
    if (i /= 42) stop 1
    i = 99
    if (i /= 99) stop 1
  end subroutine bar

  subroutine foobar (r)
    real(8), value :: r
    if (r /= 42.0) stop 1
    r = 99.0
    if (r /= 99.0) stop 1
  end subroutine foobar

  subroutine complex_foo (z)
    COMPLEX(8), value :: z
    if (z /= (-99.0, 199.0)) stop 1
    z = (77.0, -42.0)
    if (z /= (77.0, -42.0)) stop 1
  end subroutine complex_foo

end program test_value
