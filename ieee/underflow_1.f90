! { dg-do run }
! { dg-require-effective-target sse2_runtime { target { i?86-*-* x86_64-*-* } } }
! { dg-additional-options "-msse2 -mfpmath=sse" { target { i?86-*-* x86_64-*-* } } }

program test_underflow_control
  use ieee_arithmetic
  use iso_fortran_env

  logical l
  real, volatile :: x
  double precision, volatile :: y
  integer, parameter :: kx = kind(x), ky = kind(y)

  if (ieee_support_underflow_control(x)) then

    x = tiny(x)
    call ieee_set_underflow_mode(.true.)
    x = x / 2000._kx
    if (x == 0) stop 1
    call ieee_get_underflow_mode(l)
    if (.not. l) stop 1

    x = tiny(x)
    call ieee_set_underflow_mode(.false.)
    x = x / 2000._kx
    if (x > 0) stop 1
    call ieee_get_underflow_mode(l)
    if (l) stop 1

  end if

  if (ieee_support_underflow_control(y)) then

    y = tiny(y)
    call ieee_set_underflow_mode(.true.)
    y = y / 2000._ky
    if (y == 0) stop 1
    call ieee_get_underflow_mode(l)
    if (.not. l) stop 1

    y = tiny(y)
    call ieee_set_underflow_mode(.false.)
    y = y / 2000._ky
    if (y > 0) stop 1
    call ieee_get_underflow_mode(l)
    if (l) stop 1

  end if

end program
