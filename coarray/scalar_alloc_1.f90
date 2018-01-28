! { dg-do run }
!
implicit none
integer, allocatable :: A[:], B[:,:]
integer :: n1, n2, n3

if (allocated (a)) stop 1
if (allocated (b)) stop 1

allocate(a[*])
a = 5 + this_image ()
if (a[this_image ()] /= 5 + this_image ()) stop 1

a[this_image ()] = 8 - 2*this_image ()
if (a[this_image ()] /= 8 - 2*this_image ()) stop 1

if (lcobound(a, dim=1) /= 1 .or. ucobound(a,dim=1) /= num_images()) &
  stop 1
deallocate(a)

allocate(a[4:*])
a[this_image ()] = 8 - 2*this_image ()

if (lcobound(a, dim=1) /= 4 .or. ucobound(a,dim=1) /= 3 + num_images()) &
  stop 1

n1 = -1
n2 = 5
n3 = 3
allocate (B[n1:n2, n3:*])
if (any (lcobound(b) /= [-1, 3]) .or. lcobound(B, dim=2) /= n3) &
  stop 1
call sub(A, B)

if (allocated (a)) stop 1
if (.not.allocated (b)) stop 1

call two(.true.)
call two(.false.)

! automatically deallocate "B"
contains
  subroutine sub(x, y)
    integer, allocatable :: x[:], y[:,:]

    if (any (lcobound(y) /= [-1, 3]) .or. lcobound(y, dim=2) /= n3) &
      stop 1
    if (lcobound(x, dim=1) /= 4 .or. ucobound(x,dim=1) /= 3 + num_images()) &
      stop 1
    if (x[this_image ()] /= 8 - 2*this_image ()) stop 1
    deallocate(x)
  end subroutine sub

  subroutine two(init)
    logical, intent(in) :: init
    integer, allocatable, SAVE :: a[:]

    if (init) then
      if (allocated(a)) stop 1
      allocate(a[*])
      a = 45
   else
      if (.not. allocated(a)) stop 1
      if (a /= 45) stop 1
      deallocate(a)
    end if
  end subroutine two
end
