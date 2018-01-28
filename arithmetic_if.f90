! { dg-do run }
! { dg-options "-w" }
! Test program for PR 28439
integer function myfunc(i)
   integer i
   integer, save :: value = 2
   value = value - 1 + 0 * i
   myfunc = value
end function myfunc

program pr28439

   integer myfunc
      
   if (myfunc(0)) 10, 20, 30  ! Should go to 30
10 stop 1
20 stop 1

30 if (myfunc(0)) 40, 50, 60  ! Should go to 50
40 stop 1
60 stop 1

50 if (myfunc(0)) 70, 80, 90  ! Should go to 70
80 stop 1
90 stop 1

70 continue

end program pr28439


