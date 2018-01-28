! { dg-do run }
! Test of Steve Kargl's fix to PR19754
! This exercises bugs that the original patch caused
!
program PR19754_2
   real a(2,2), b(2,2),c(2,2),d(2,2)
   integer i(2,2),j(2,2),k(2,2)
   a = 1. ; b = 2. ;  i = 4
   c = b - floor( a / b )        ! this caused an ICE
   d = b - real(floor( a / b ))
   if (any (c/=d)) stop 1
   j = aint(b) - floor( a / b )  ! this caused an ICE
   if (any(real(j)/=d)) stop 1
   c = i
   if (any(real(i)/=c)) stop 1
   c = i + b                     ! this caused an ICE 
   d = real(i) + b
   if (any(c/=d)) stop 1
   j = i + aint (a)
   k = i + a                     ! this caused an ICE
   if (any(j/=k)) stop 1
end program PR19754_2
