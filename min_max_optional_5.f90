! More tests for MIN/MAX with optional arguments
! PR33095
!
! { dg-do run }
  if (m1(3,4) /= 4) stop 1
  if (m1(3) /= 3) stop 1
  if (m1() /= 2) stop 1

  if (m1(3,4) /= 4) stop 1
  if (m1(3) /= 3) stop 1
contains
  integer function m1(a1,a2)
    integer, optional, intent(in) :: a1, a2
    m1 = max(1, 2, a1, a2)
  end function m1

  integer function m2(a1,a2)
    integer, optional, intent(in) :: a1, a2
    m2 = max(1, a1, 2, a2)
  end function m2
end
