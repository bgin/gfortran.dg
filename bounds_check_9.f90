! { dg-do run }
! { dg-options "-fbounds-check" }
! PR fortran/31119
!
module sub_mod
contains
elemental subroutine set_optional(i,idef,iopt)
  integer, intent(out) :: i
  integer, intent(in) :: idef
  integer, intent(in), optional :: iopt
  if (present(iopt)) then
    i = iopt
  else
    i = idef
  end if
  end subroutine set_optional

  subroutine sub(ivec)
    integer, intent(in), optional :: ivec(:)
    integer :: ivec_(2)
    call set_optional(ivec_,(/1,2/))
    if (any (ivec_ /= (/1, 2/))) stop 1
    call set_optional(ivec_,(/1,2/),ivec)
    if (present (ivec)) then
      if (any (ivec_ /= ivec)) stop 1
    else
      if (any (ivec_ /= (/1, 2/))) stop 1
    end if
  end subroutine sub
end module sub_mod

program main
  use sub_mod, only: sub
  call sub()
  call sub((/4,5/))
end program main
