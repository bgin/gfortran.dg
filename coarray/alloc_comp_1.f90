! { dg-do run }
!
! Allocatable scalar corrays were mishandled (ICE)
!
type t
  integer, allocatable :: caf[:]
end type t
type(t) :: a
allocate (a%caf[3:*])
a%caf = 7
if (a%caf /= 7) stop 1
if (any (lcobound (a%caf) /= [ 3 ]) &
    .or. ucobound (a%caf, dim=1) /= this_image ()+2)  &
  stop 1
deallocate (a%caf)
end
